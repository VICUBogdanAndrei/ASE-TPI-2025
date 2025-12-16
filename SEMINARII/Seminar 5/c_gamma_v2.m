function []=c_gamma_v2(nume, c, g, tip)
    % transformarea gamma pentru modificarea luminozitatii si contrastului
    % --- cu normalizare ---
    % I: nume - numele fisierului care contine imaginea
    %    c, g - constantele transformarii (s = c * r^g )
    %    tip - tipul fisierului pentru salvarea imaginii prelucrate
    % E: -
    % Exemple de apel:
    % c_gamma_v2('CopilS.bmp',1,1.15, 'png');  % fara normalizare
    % c_gamma_v2('CopilS.bmp',1.5,0.75, 'png');    % cu normalizare
    % c_gamma_v2('Amprenta.tif',0.5,1.15)
    % c_gamma_v2('LENNAS.BMP',0.5,1.15, 'png');
    % c_gamma_v2('MBS.jpg',0.4,1.2, 'png'); 
    % c_gamma_v2('vulpea si marmota.jpg',1,1.2, 'png');
    % c_gamma_v2('vulpea si marmota.jpg',1.2,0.8, 'png');
    
    poza=imread(nume);
    r=double(poza)/255;         % /255 <-> normalizare
    rez=uint8(c*r.^g*255);      % *225 <-> revenire dupa normalizare
    figure
        subplot(1,2,1), imshow(poza);
        title('Imaginea initiala');
        subplot(1,2,2), imshow(rez);
        title({'Imaginea transformata', ['c= ' num2str(c) '   g= ' num2str(g)]});
    imwrite(rez,[nume '-gamma.' tip],tip);
end
    