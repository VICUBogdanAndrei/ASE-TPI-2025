function [ fo ] = zgomot_g_n( fi, s_max, tip )
  % adaugarea de zgomot gaussian necorelat la o imagine monocroma
  % I: fi - numele fisierului care contine imaginea initiala
  %    s_max - sigma maxim pentru zgomotul adaugat fiecarui pixel
  %    tip - tip fisier rezultat ('png' / 'jpg' etc.)
  % E: fo - fisierul cu poza perturbata
  % Exemple de apel
  %    f_rez=zgomot_g_n('veverite_mono.png',50,'png');
  %    f_rez=zgomot_g_n('veverite_mono.png',100,'png');

    poza=imread(fi);
    [m,n,p]=size(poza);
    
    figure
        imshow(poza);
        title('Imaginea initiala');
    if p>1
        fo='';
        disp('Imaginea are mai mult de un plan, nu o prelucrez');
    else
        sigma=unifrnd(0,s_max,m,n);
        zgomot=normrnd(0,sigma,m,n);
        poza_noua=uint8(double(poza)+zgomot);
        
        figure
            imshow(poza_noua);
            title('Poza perturbata');
        fo=[fi '_g_n.' tip];
        imwrite(poza_noua,fo,tip);
    end;
end

