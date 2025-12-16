function []= contrast_poli(nume, r, s, tip)
    % cresterea contrastului in mod liniar, cu doua (n) puncte
    % I: nume - numele fisierului cu imaginea originala
    %    r, s - punctele (vectori, in r coordonata x, in s coordonata y),
    %    tip - tipul fisierului pentru salvare
    % E: -
    % Exemple de apel: 
    % doua puncte
    % contrast_poli('Lenna_mono.bmp',[0 84 170 255], [0 40 210 255], 'png');
    % contrast_poli('MB.jpg',[0 84 170 255], [0 40 210 255], 'png');
    % patru puncte
    % contrast_poli('Lenna_mono.bmp',[0 42 85 127 169 212 255], [0 30 65 127 189 232 255], 'png');
    % contrast_poli('MB.jpg',[0 42 85 127 169 212 255], [0 30 65 127 189 232 255], 'png');

    
    poza=imread(nume);
    [~,~,p]=size(poza);
    pozad=double(poza);
    rez=pozad;
    for k=1:p
        rez(:,:,k)=contrast_plan(pozad(:,:,k),r,s);
    end;
    figure
        subplot(1,2,1), subimage(poza);
        title('Imaginea initiala');
        subplot(1,2,2), subimage(uint8(rez));
        title('Imaginea transformata');
    [~, numecomplet, ~] = fileparts(nume);
    [doarnume, ~] = strtok(numecomplet, '.');
    imwrite(uint8(rez),[doarnume '-cp.' tip],tip);
end

function [rez]=contrast_plan(plan,r,s)
    % contrast liniar pentru un plan
    % I: plan - planul de prelucrat, r si s - punctele pentru contrast
    % E: rez - planul modificat
    
    [m,n]=size(plan);
    nr=length(r);
    rez=plan;
    % pentru fiecare pixel plan(i,j)
    for l=1:m
        for c=1:n
            suma=0;
            for i=1:nr
                prod=1;
                for j=1:nr
                    if i~=j
                        prod=prod*(plan(l,c)-r(j))/(r(i)-r(j));
                    end;
                end;
                suma=rez(l,c)+prod;
            end;
            rez(l,c)=uint8(suma);
        end;
    end;
end