function [] = filtru_med_inv2(poza,d,iT,eps)
    % combinatie de filtre pentru eliminare zgomot (median) si efect de miscare (invers)
    % I: poza - imaginea perturbata cu zgomot si efect de miscare
    %           presupusa a fi grascale (1 plan)
    %    d - dimensiunea mastii pentru filtrul median
    %    iT - intensitatea miscarii pentru filtrul invers
    %    eps - vecinatatea lui zero pentru filtrul invers
    % E: -
    % Exemple de apel:
    % filtru_med_inv2('Lenna_mono_MD_y_iT_11_s_5.bmp',3,11,0.001);
    % filtru_med_inv2('Lenna_mono_MD_y_iT_11_s_5.bmp',3,11,0.01);
    % filtru_med_inv2('Lenna_mono_MD_y_iT_11_s_5.bmp',3,11,0.1);
    % filtru_med_inv2('Lenna_mono_MD_y_iT_11_s_5.bmp',3,11,0.15);
    % filtru_med_inv2('Lenna_mono_MD_y_iT_20_s_10.bmp',3,20,0.1);
    % filtru_med_inv2('Lenna_mono_MD_y_iT_20_s_10.bmp',3,20,0.3);
    % filtru_med_inv2('Lenna_mono_MD_y_iT_20_s_10.bmp',3,20,0.01);
    % filtru_med_inv2('Lenna_mono_MD_y_iT_20_s_10.bmp',3,20,0.05);

    I=imread(poza);
    [m,n]=size(I);

    %eliminare zgomot cu filtrul median (functia matlab)
    J=medfilt2(I,[d,d]);

    %trecere in domeniul de frecvente pentru aplicarea filtrului invers
    gTFD=fft2(double(J));
    hTFD=motion_blur_d(m,n,iT,'y');
    
    %aplicare filtru invers
    citi=0;     %pe citi pixeli se face calculul
    fTFD=gTFD;
    for i=1:m
        for j=1:n
            if abs(hTFD(i,j))>eps
                fTFD(i,j)= gTFD(i,j) / hTFD(i,j);
                citi=citi+1;
            end;
        end;
    end;

    %revenire in domeniul spatial
    rez=uint8(abs(ifft2(fTFD)));

    figure
        imshow(I);
        title('Imaginea initiala (perturbata)');

    figure
        imshow(rez);
        title(['Rezultatul aplicarii filtrelor median si invers (pe ' num2str(100*citi/(m*n)) '% pixeli)']);
        
    [nume,ext]=strtok(poza,'.');
    fo=[nume '_M_' num2str(d) '_I_' num2str(iT) ext];
    imwrite(rez,fo);
end



