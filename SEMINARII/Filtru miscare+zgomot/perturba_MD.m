function [rez] = perturba_MD(poza,iT,dir)
    % Perturba o imagine prin inducerea efectului de miscare in caz 
    % discret. Imaginea rezultata e salvata intr-un fisier cu numele compus
    % din numele fisierului original si parametrii perturbarii
    % I: poza - numele fisierului care contine imaginea de prelucrat
    %           (se foloseste un plan, format gray-scale)
    %    iT - intensitatea ("viteza") miscarii (intreg)
    %    dir - directia miscarii ('x' - directia x, 'y' - directia y)
    % E: rez - imaginea rezultata (un plan, gray-scale)

    % Exemple de apel 
    % perturba_MD('Lenna_mono.bmp',9,'x'); 
    % perturba_MD('Lenna_mono.bmp',11,'y'); 

    J=imread(poza);
	[l,c]=size(J);
    f=double(J);

    % calculul TFD a imaginii 
    fTFD=fft2(f);

    % construirea filtrului
    hTFD=motion_blur_d(l,c,iT,dir);

    % aplicarea perturbarii, in domeniul frecventelor
    gTFD=zeros(l,c);
    for x=1:l
        for y=1:c
            gTFD(x,y)=fTFD(x,y)*hTFD(x,y);
        end;
    end;
    % gTFD=fTFD.*hTFD;

    % calculul imaginii perturbate
    rez=uint8(abs(ifft2(gTFD)));

    % afisarea si salvarea imaginii perturbate
    figure
        imshow(J);
        title('Imaginea initiala');
    figure
        imshow(rez);
        title(['Imaginea peturbata MB discret pe directia ' dir ' cu iT=' num2str(iT)]);
    [nume,ext]=strtok(poza,'.');
    fo=[nume '_MD_' dir num2str(iT) ext];
    imwrite(rez,fo);
end


