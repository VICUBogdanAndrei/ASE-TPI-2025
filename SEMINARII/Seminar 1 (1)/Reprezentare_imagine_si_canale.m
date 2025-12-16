% incarcare imagine, comanda cu / fara ;
% orice alta imagine RGB (3 plane)
% 
cale='..\\Imagini pentru seminar'; %atentie la punct-si-virgula
fis=[cale '\\' 'veverite.jpg']; 

imagine=imread('veverite.jpg')  
imread(fis)
imread(fis); %variabila ans, poate fi folosita imediat
imagine=imread('..\\imagini pentru seminar\\veverite.jpg');

imagine_mono=rgb2gray(imagine);
imwrite(imagine_mono,'veverite_mono.png');

% vizualizare imagine cu / fara figura
imshow(imagine);
imshow(imagine_mono); %=> aceeasi figura, inlocuieste imaginea afisata anterior
figure
imshow(imagine); % afisare imagine mono in figura separata

% vizualizarea fiecarui plan din imaginea color - imagini in nuante de gri
% o singura figura
figure
imshow(imagine)
imshow(imagine(:,:,1))
imshow(imagine(:,:,2))
imshow(imagine(:,:,3))
% figuri separate
figure
  imshow(imagine(:,:,1))
figure
  imshow(imagine(:,:,2))
figure
  imshow(imagine(:,:,3))
% cu bucla
for i=1:3
  figure
    imshow(imagine(:,:,i))
  switch(i)
      case 1
          title('Canalul roșu');
      case 2
          title('Canalul verde');
      case 3
          title('Canalul albastru');
  end;
end;

% construire imagini noi
[m,n,p]=size(imagine);
imagine_noua=zeros(m,n,p);
a=zeros(size(imagine));

a=uint8(a);
%imagine neagra
figure
  imshow(a);
%imagine alba
a=a+255;
figure
  imshow(a);

% cite o imagine pentru fiecare canal RGB
% atentie la conversii! imaginile sint in uint8, calculele sint in double
imR=zeros(size(imagine));
imR(:,:,1)=imagine(:,:,1);
figure
  imshow(imR) %imagine rosu-plin
imR=uint8(imR);
imshow(imR); % canalul rosu din imaginea de test

imG=uint8(zeros(size(imagine)));
imG(:,:,2)=imagine(:,:,2);
imshow(imG);

imB=uint8(zeros(size(imagine)));
imB(:,:,3)=imagine(:,:,3);
imshow(imB);

% compunere imagine din canalele RGB
imshow(imR+imG+imB);

% transformare rgb -> nuante de gri
a=rgb2gray(imagine);
figure
  imshow(a);

% transformare nuante de gri 1 plan -> reprezentare rgb (3 plane), tot monocroma
b=uint8(zeros(size(imagine)));
for i=1:3
    b(:,:,i)=a;
end;
figure
imshow(b);

% manipulare zona din imagine
imagine(150:350,150:350,2)=255;
imshow(imagine)
imagine(400:600,150:350,1)=0;
imshow(imagine)
a=rgb2gray(imagine);
figure
  imshow(a);
