function [] = filtru_invers_sp(poza,filtru,eps,tip)
    % filtru invers spatial pentru eliminarea efectului de voalare
    % varianta 1 de tratare a cazurilor de elemente nule in filtrul Fourier hTFD
    % se lucreaza cu imagini gray-scale (nu se verifica daca e RGB)
    % I: poza - fisierul cu imaginea perturbata
    %    filtru - fisierul text care contine filtrul (mbx.txt, x=1..4)
    %    eps - pragul sub care valorile din filtru sint considerate nule
    %    tip - tipul fisierelor rezultate (numele va fi compus din numele
    %          fisierului initial plus numele mastii)
    % E: -

    % Exemple de apel:
    %    filtru_invers_sp('car-gray-mb1-frecv.png','mb1.txt',0.0001,'png');
    %    filtru_invers_sp('amprenta_gray-mb1-frecv.png','mb1.txt',0.01,'png');
    %    filtru_invers_sp('lennaa_gray-mb2-frecv.png','mb2.txt',0.0001,'png');
    %    variante prag: 0.01, 0.1, 0.3, 0.0001 
    % verificare
    %    a=SNR('lennaa_gray-mb2-frecv.png','lennaa_gray.png')
    %       a = 20.5980
    %    b=SNR('lennaa_gray-mb2-frecv-R-mb2-fr-0.0001.png','lennaa_gray.png')
    %       b = 25.9542
    %    c=RMI('LENNAA_gray-mb2-frecv.png','LENNAA_gray.png')
    %       c = 0.3728
    %    d=RMI('lennaa_gray-mb2-frecv-R-mb2-fr-0.0001.png','LENNAA_gray.png')
    %       d = 0.6117

    % preluare imagine perturbata si filtru
    imag=imread(poza);
    [m,n]=size(imag);

    w=load(filtru);
    suma=sum(sum(w));
    w=w/suma;
    [m1,n1]=size(w);

    % dimensiuni imagine expandata cu linii si coloane nule (negre) 
    l=m+m1-1;
    c=n+n1-1;

    % expandarea imaginii
    f=zeros(l,c);   % f -imaginea expandata
    f((m1+1)/2:m+(m1+1)/2-1,(n1+1)/2:n+(n1+1)/2-1)=double(imag);
    % centrarea imaginii expandate
    fc=f;           % fc - imaginea expandata centrata
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
    for i=-(m1-1)/2:(m1-1)/2
        for j=-(n1-1)/2:(n1-1)/2
            h(l1+i,c1+j)=w(i+(m1-1)/2+1,j+(n1-1)/2+1);
        end;
    end;
    % centrarea functiei filtru in domeniul spatial
    for i=1:l
        for j=1:c
            h(i,j)=h(i,j)*(-1)^(i+j);
        end;
    end;
    % calculul functiei filtru in domeniul Fourier
    hTFD=fft2(h);
    for i=1:l
        for j=1:c
            hTFD(i,j)=hTFD(i,j)*(-1)^(i+j);
        end;
    end;

    % aplicarea filtrului invers in domeniul de frecvente
    XX=fcTFD;
    for i=1:l
        for j=1:c
            if(abs(hTFD(i,j))>eps)
                XX(i,j)=fcTFD(i,j)/hTFD(i,j);
            end;
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
    % eliminare eventuale reziduuri complexe
    g=abs(g);
 
    % extragere matrice (imagine) rezultat
    rez=uint8( g((m1+1)/2:m+(m1+1)/2-1,(n1+1)/2:n+(n1+1)/2-1));
 
    % vizualizare imagine initiala si filtrata
    figure
        imshow(imag);
        title('Imaginea initiala perturbata');
    figure
        imshow(rez);
        title('Imaginea filtrata cu filtru invers ');
 
    % salvare imagine filtrata
	fo=[strtok(poza,'.') '-R-' strtok(filtru,'.') '-fr-' num2str(eps) '.'  tip];    
    imwrite(rez,fo,tip);
end
