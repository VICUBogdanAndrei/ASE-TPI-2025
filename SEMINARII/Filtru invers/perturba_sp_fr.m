function [er] = perturba_sp_fr(poza,filtru,tip)
	% Simularea perturbarii cu mastile din fisierele mb?.txt in domeniul
	% frecventelor (Fourier)
    % I: poza - numele fisierului cu poza de perturbat (clara, originala)
    %    filtru - numele fisierului text care contine masca de filtrare;
    %             filtre disponibile: mb1.txt, mb2.txt, mb3.txt, mb4.txt
    %    tip - tipul fisierelor rezultate (numele va fi compus din numele
    %          fisierului initial plus numele mastii)
    % E: er - indicatorul SNR pentru imaginea perturbata

    
    % exemple de apel:
    %   perturba_sp_fr('car.jpg','mb1.txt','png');
    %   perturba_sp_fr('LENNAA.BMP','mb2.txt','png');
    %   perturba_sp_fr('amprenta.tif','mb1.txt','png');

    % preluare poza, transformare in gray-scale si salvare 
    imag=imread(poza);
    [m,n,p]=size(imag);
    if p>1
        imag=rgb2gray(imag);
    end;
    % salvare versiune monocroma in directorul curent
    temp=strfind(poza,'\\');
    if ~isempty(temp)     %length(temp)~=0
        poza=poza(temp(end)+2:end);
    end;
    [nume,~]=strtok(poza,'.');
    fi=[nume '-gray.' tip];
    imwrite(imag,fi,tip);

    % preluare filtru 
    w=load(filtru);
    w=w/sum(sum(w));
    [m1,n1]=size(w);
    % dimensiuni imagine expandata cu linii si coloane nule (negre) 
    l=m+m1-1;
    c=n+n1-1;
    
    % expandarea imaginii
    f=zeros(l,c);       % f - functia imagine
    f((m1+1)/2:m+(m1+1)/2-1,(n1+1)/2:n+(n1+1)/2-1)=double(imag);
    % centrarea imaginii expandate
    fc=f;               % fc - imaginea centrata
    for i=1:l
        for j=1:c
            fc(i,j)=f(i,j)*(-1)^(i+j);
        end;
    end;
    % calculul TFD pentru imaginea centrata
    fcTFD=fft2(fc);

    % calculul functiei filtru in dom. de frecv. pe baza filtrului spatial
    h=zeros(l,c);
    l1=uint16(l/2); % coordonate centru
    c1=uint16(c/2);
    % copiere la nivel de matrice
    % h(l1-(m1-1)/2:l1+(m1-1)/2),c1-(n1-1)/2:c1+(n1-1)/2)=w(:,:);
    % sau
    % copiere element cu element
    for i=-(m1-1)/2:(m1-1)/2
        for j=-(n1-1)/2:(n1-1)/2
            h(l1+i,c1+j)=w(i+(m1-1)/2+1,j+(n1-1)/2+1);
        end;
    end;
    % centrare functie filtru in domeniul spatial
    for i=1:l
        for j=1:c
            h(i,j)=h(i,j)*(-1)^(i+j);
        end;
    end;
    % calcul TFD pentru functia filtru
    hTFD=fft2(h);
    for i=1:l
        for j=1:c
            hTFD(i,j)=hTFD(i,j)*(-1)^(i+j);
        end;
    end;

    % aplicare filtru in domeniul de frecvente
	%XX=fcTFD.*hTFD;
    XX=zeros(l,c);
    for i=1:l
        for j=1:c
            XX(i,j)=fcTFD(i,j)*hTFD(i,j);
        end;
    end;
    
    % revenire in domeniul spatial
    gc=ifft2(XX);
    % eliminare centrare
    g=gc;
    for i=1:l
        for j=1:c
            g(i,j)=gc(i,j)*(-1)^(i+j);
        end;
    end;
    g=abs(g);
    
    % extragere matrice (imagine) rezultat
    rez=uint8( g((m1+1)/2:m+(m1+1)/2-1,(n1+1)/2:n+(n1+1)/2-1));
    
    % vizualizare imagine initiala si perturbata
    figure
        imshow(imag);
        title('Imaginea initiala');
   
    % salvare imagine perturbata
    fo=[strtok(fi,'.') '-' strtok(filtru,'.') '-frecv' '.'  tip];    
    imwrite(rez,fo,tip);
    er=SNR(fo,fi);
    
    figure
        imshow(rez);
        title(['Imaginea perturbata in frecvente cu masca ' strtok(filtru,'.') ', SNR: ' num2str(er)]);
        
    
    
end
