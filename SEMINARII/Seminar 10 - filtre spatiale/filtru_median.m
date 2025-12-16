function [rez] = filtru_median(nume,d)
    % filtru median pentru eliminarea zgomotului
    % I: nume - numele fisierului cu imaginea de filtrat
    % d - dimensiune filtru
    % E: -
    %
    % exemplu de apel
    % filtru_median('car_gray.png_zg_RayN.png',5);
    % filtru_median('car_gray.png_zg_RayN.png',3);
    
    % in matlab se poate folosi rez=medfilt2(I,[d,d]);
    
    I=imread(nume);
    [m,n,p]=size(I);
    if p>1
        I=rgb2gray(I);
    end;
    l=m+d-1;            % dimensiuni imagine extinsa
    c=n+d-1;
    t=(d+1)/2;          % coordonate colt stinga sus imagine in matr. extinsa
    fc=zeros(l,c);      % imagine extinsa
    fc(t:m+t-1,t:n+t-1)=double(I);
    g=zeros(l,c);
    % aplicare filtru de ordine
    for x=1:m
        for y=1:n
            r=fc(x:x+d-1,y:y+d-1);
            xx=reshape(r,[d*d,1]);
            yy=sort(xx);
            % filtru median - sectiunea urmatoare se inlocuieste petnru a
            % utiliza alt filtru de ordine
            g(x+t-1,y+t-1)=yy((d*d+1)/2);
            % end filtru median
        end
    end
    % extragere imagine din matricea extinsa
    rez=uint8(g(t:m+t-1,t:n+t-1));
    
    % optional, vizualizarea celor doua imagini
%     figure
%         imshow(I);
%         title('Imaginea perturbata');
%     figure
%         imshow(rez);
%         title('Imaginea filtrata median');
end

