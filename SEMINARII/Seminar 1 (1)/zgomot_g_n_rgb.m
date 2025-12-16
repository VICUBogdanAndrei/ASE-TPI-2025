function [fo] = zgomot_g_n_rgb(fi,s_max,tip)
  % adaugarea de zgomot gaussian necorelat la o imagine RGB
  % I: fi - numele fisierului care contine imaginea initiala
  %    s_max - sigma maxim pentru zgomotul adaugat fiecarei 
  %            componente de culoare a fiecarui pixel
  %    tip - tip fisier rezultat ('png' / 'jpg' etc.)
  % E: fo - fisierul cu poza perturbata
  % Exemple de apel
  %    zgomot_g_n_rgb('veverite.png',50,'png');

  I=imread(fi);
  [m,n,p]=size(I);

  figure
    imshow(I);
    title('Imaginea initiala');
  
  R=double(I);  
  for k=1:p  
    sigma=unifrnd(0,s_max,m,n);
    zgomot=normrnd(zeros(m,n),sigma,m,n);
    R(:,:,k)=R(:,:,k)+zgomot;
  end;
  
  R=uint8(R);
  fo=[fi '_g_n_rgb.' tip];
  imwrite(R,fo,tip);
  figure
    imshow(R);
    title('Imaginea perturbata');
end
