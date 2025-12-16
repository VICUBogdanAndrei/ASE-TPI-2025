function [ok]=ascunde(poza_i, mesaj, poza_o, poza_m, tip)
    % ascunde un mesaj (litere mici, fara spatii / diacritice etc.) 
    % in poza (color sau monocroma) prin modificarea cite unui pixel 
    % pentru fiecare litera, in pozitii aleatoare
    % I: poza_i - nume fisier imagine initiala
    %    mesaj - text
    %    poza_o - nume fisier poza originala (pt. utilizare la extragere) 
    %    poza_m - nume fisier poza modificata
    %    tip - tip fisier imagini rezultate ('bmp' sau 'png')
    % E: ok - 1 in caz de succes, 0 daca imaginea nu are suficienti pixeli 
    %    utilizabili, 99 altfel (eroare nespecificata)
    % Exemple de apel:
    %     cod=ascunde('mb.jpg','totiiaunotazecelatpi','mb_orig','mb_mod','png');
    %     cod=ascunde('faza.bmp','maisuseogluma','original','modificat','png');
    
    IO=imread(poza_i);
    [~,~,p]=size(IO);
    % trecere de la litere (domeniul [97,122]) la numere (domeniul [1, 26])
    sir=mesaj-'a'+1;
    
    ok=1;
    
    if p==1                             % un plan
        [IM,ok]=codificare(IO,sir);
    elseif p==3                         % 3 plane
        nr=length(mesaj);
        %puncte=unidrnd(nr,1,2); 
        %puncte=sort(puncte);
        puncte=[0 sort(unidrnd(nr,1,2)) nr];
        
        IM=IO;  %zeros(m,n,p);
        i=1;
        while (i<=3) && (ok==1)
            [IM(:,:,i),ok]=codificare(IO(:,:,i),sir(puncte(i)+1:puncte(i+1)));
            i=i+1;
        end;
    else
        ok=99;
    end;
    
    if ok==1
        fo=[poza_o '.' tip];
        fm=[poza_m '.' tip];
        imwrite(IO,fo,tip);
        imwrite(IM,fm,tip);
% optional   
%       figure
%         imshow(IO);
%         title('poza originala');
%       figure 
%         imshow(IM);
%         title('poza modificata');
    end;
end



function [poza_m,ok]=codificare(poza, mesaj)
    % codificare mesaj dat in 1 plan al pozei (primit)
    % I - poza - 1 plan=o matrice, 
    %     mesaj - coduri numerice asociate literelor (translatate, NU ASCII!)
    % E - poza_m - poza modificata, 1 plan=o matrice
    %     ok - 1 succes, 0 nu sint suficienti pixeli utilizabili
    
    poza_m=poza;
    vmax=255-max(mesaj);        % valoare maxima pixel utilizabil
    nr=length(mesaj);           % numar pixeli necesari
    p=pozitii(poza,nr,vmax);    % pixeli folositi: p e matrice cu 2 coloane
    [gasit,~]=size(p);          % numar pixeli utilizabili gasiti
    if gasit~=nr
        ok=0;
    else
        ok=1;
        for i=1:nr
            poza_m(p(i,1),p(i,2)) = poza_m(p(i,1),p(i,2)) + mesaj(i);
        end;
    end;
end



function [poz]=pozitii(poza,nr,vmax)
    % alegere pozitii aleatoare intr-o poza, sortate, sa nu depaseasca o
    % valoare maxima data
    % I: poza - imaginea (1 plan); nr - nr. pozitii necesare,
    %    vmax - val. maxima admisa
    % E: poz - matrice cu coordonatele pozitiilor alese, sortate lexicografic
    
    % verifica daca sint suficienti pixeli utilizabili 
    temp=find(poza<=vmax);
    nrdisp=length(temp);
    if nrdisp<nr    % nr. insuficient de pixeli utiliabili
        poz=[];     % nici o pozitie
    else
        %varianta 1: alegere pixeli cite unul
%         indici=zeros(1,nr);
%         [lin,col]=ind2sub(size(poza),temp);
%         poz=zeros(nr,2);
%         p=0;
%         while p<nr
%             i=unidrnd(nrdisp);      % alege aleator unul din pixelii disponibili
%             if ~ismember(i,indici)  % daca nu a fost deja ales
%                 p=p+1;          
%                 indici(p)=i;
%                 poz(p,1)=lin(i);
%                 poz(p,2)=col(i);
%             end;       
%        end;
        %varianta 2
        indici=datasample(1:nrdisp,nr);
        [lin,col]=ind2sub(size(poza),indici);
        poz=[lin;col]';
        %end varianta
        poz=sortrows(poz);          % sortare pixeli utilizati, lexicografic
    end;
end