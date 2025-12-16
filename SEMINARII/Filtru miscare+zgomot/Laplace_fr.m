function [hTFD] = Laplace_fr(l,c,w)
    % reprezentarea filtrului spatial Laplace in domeniul de frecvente 
    % NU se face filtrarea Laplace, deci NU se face centrare
    % I: l,c - dimensiunile filtrului care trebuie construit
    %    w - matricea filtrului spatial Laplace
    % E: TFDh - filtrul in domeniul de frecvente construit
    
    % construire matrice (l,c) nula, cu matricea w in centru
    [m1,n1]=size(w);
    h=zeros(l,c);
    l1=uint16(l/2);
    c1=uint16(c/2);
    for i=-(m1-1)/2:(m1-1)/2
        for j=-(n1-1)/2:(n1-1)/2
            h(l1+i,c1+j)=w(i+(m1-1)/2+1,j+(n1-1)/2+1);
        end;
    end;
    
    % aplicarea transformarii fourier pentru obtinerea filtrului in frecv.
    hTFD=fft2(h);
end