function [g,g1] = filtru_Wiener(poza,gam,iT,eps)
    % filtrare Wiener pentru imagini perturbate cu efect de miscare 
    % in caz discret pe Y si zgomot normal
    % I: poza - numele fisierului cu imaginea perturbata
    %    gam - parametrul de ajustare al filtrului Wiener
    %    iT - intensitatea ("viteza") miscarii (intreg)
    %    eps - defineste vecinatatea lui zero (pentru a evita impartirea)
    % E: g1 - imaginea rezultata in urma filtrarii
    %    g - g1 cu nivelurile de gri aduse pe intervalul 0..255
    % Exemple de apel:
    % filtru_Wiener('Lenna_mono_MD_y_iT_9_s_10.bmp',0.1,9,0.001);
    % filtru_Wiener('car_gray_MD_y_iT_9_s_15.png',0.02,9,0.0001);
    % filtru_Wiener('car_gray_MD_y_iT_9_s_15.png',0.2,9,0.0001);
    %   urmat de calcul SNR si/sau RMI rezultat fata de original, in scop
    %   didactic, in conditii de laborator
    % indicatori( 'Lenna_mono.bmp', 'Lenna_mono_MD_y_iT_9_s_10.bmp', 'Lenna_mono_MD_y_iT_9_s_10_W_g_0.1.bmp' )
    % SNR: P: 11.4661 - R: 19.752
    % RMI: P: 0.16264 - R: 0.29836
    
    % preluare imagine de filtrat
    I=imread(poza);
    [l,c]=size(I);
    g=double(I);

    % calculul filtrului Laplace in frecvente
    numefiltru='laplace.txt'; % util daca se doreste schimbarea filtrului
    w=load(numefiltru); 
    % sau w=[0 -1 0; -1 4 -1; 0 -1 0]; % direct filtru laplace
    lTFD=Laplace_fr(l,c,w);

    % calculul TFD a imaginii 
    gTFD=fft2(g);

    % calculul perturbarii motion blur
    hTFD=motion_blur_d(l,c,iT,'y');

    % filtrarea in domeniul frecventelor cu Wiener
    fTFD=zeros(l,c);
    for x=1:l
        for y=1:c
            numitor= (abs(hTFD(x,y)))^2 + gam*(abs(lTFD(x,y))^2);
            if numitor>eps
                val=(hTFD(x,y))' / numitor;
            else
                val=1;
            end;
            fTFD(x,y)=gTFD(x,y)*val;
        end;
    end;

    % calculul imaginii filtrate
    g1=abs(ifft2(fTFD)); % cu varianta  g1=real(ifft2(TFDf));
    
    % aducerea nivelurilor de gri pe 0..255
    valmax=max(max(g1));
    valmin=min(min(g1));
    g=255*(g1-ones(l,c)*valmin)/(valmax-valmin);

    % matricea rezultat
    rez=uint8(g);

    % afisarea si salvarea imaginii restaurate
    figure
        imshow(I);
        title('Imaginea cu miscare discreta si zgomot');
    figure
        imshow(rez);
        title('Imaginea filtrata Wiener');
    [nume,ext]=strtok(poza,'.');
    fo=[nume '_W_g_' num2str(gam) ext];
    imwrite(rez,fo);
end



