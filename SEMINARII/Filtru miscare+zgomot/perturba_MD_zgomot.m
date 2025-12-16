function [rez] = perturba_MD_zgomot(poza,iT,sigma)
    % Perturba imaginea 'poza' prin inducerea efectului de miscare in caz 
    % discret pe axa y si adaugarea de zgomot normal. Imaginea 
    % rezultata e salvata intr-un fisier cu numele compus din numele 
    % fisierului original si parametrii perturbarii
    % I: poza - numele fisierului care contine imaginea de prelucrat
    %           (se foloseste un plan, format gray-scale)
    %    iT - intensitatea ("viteza") miscarii (intreg)
    %    sigma - variantza pentru adaugarea zgomotului N(0,sigma)
    % E: rez - imaginea rezultata (un plan, gray-scale)

    % Exemple de apel 
    % perturba_MD_zgomot('Lenna_mono.bmp',5,20);  - efect de miscare slab si zgomot mare
    % perturba_MD_zgomot('Lenna_mono.bmp',9,10); 
    % perturba_MD_zgomot('Lenna_mono.bmp',11,5);  - efect de miscare puternic si zgomot slab
    % perturba_MD_zgomot('BADSCAN1.bmp',9,15); 
    % perturba_MD_zgomot('BADSCAN1.bmp',13,5);  - efect de miscare puternic si zgomot slab
    % perturba_MD_zgomot('car_gray.png',9,15);
    % perturba_MD_zgomot('Lenna_mono.bmp',20,10);
    
    % preluare imagine din fisier 
    I=imread(poza);
    [l,c]=size(I);
    f=double(I);

    % calculul TFD a imaginii 
    fTFD=fft2(f);

    % construirea filtrului
    hTFD=motion_blur_d(l,c,iT,'y');

    % aplicarea perturbarii, in domeniul frecventelor
    gTFD=zeros(l,c);
    for x=1:l
        for y=1:c
            gTFD(x,y)=fTFD(x,y)*hTFD(x,y);
        end;
    end;
    % gTFD=fTFD.*hTFD;

    % calculul imaginii perturbate
    rez1=abs(ifft2(gTFD));
       
    % adaugare zgomot
    zg=normrnd(0,sigma,l,c);
    rez=uint8(rez1+zg);
    % rez=imnoise(rez1,'gaussian',0,sigma);

    % afisarea si salvarea imaginii perturbate
    figure
        imshow(I);
        title('Imaginea initiala');
    figure
        imshow(rez);
        title(['Imaginea peturbata MB discret Y (iT=' num2str(iT) ') + zgomot (s=' num2str(sigma) ')']);
    [nume,ext]=strtok(poza,'.');
    fo=[nume '_MD_y_iT_' num2str(iT) '_s_' num2str(sigma) ext];    
    imwrite(rez,fo);
end
