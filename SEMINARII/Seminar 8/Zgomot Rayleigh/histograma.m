function [h] = histograma(nume1,tip)
    % histograma unei imagini. pentru unele cazuri se poate folosi imaginea
    % negativa pentru a vedea mai bine
    % I: nume1 - nume fisier cu imagine, tip - 1 normal, 2 negativ
    % E: h - histograma

    % exemple de apel:
    % histograma('zg_RayN1.jpg',1);
    % histograma('zg_RayN2.jpg',2);
    % histograma('testR.jpg',2);
    
    J=imread(nume1);
    [m,n,~]=size(J);
    f=double(J(:,:,1));
    if(tip==2)
        f=255-f;
    end;
    L=255;
    h=zeros(1,L+1);
    for i=1:m
        for j=1:n
            h(f(i,j)+1) = h(f(i,j)+1)+1;
        end;
    end;
    h=h/(m*n);
    figure
        i=1:L+1;
        p=plot(i,h(i));
        set(p,'Color','black','LineWidth',1.5);
end

