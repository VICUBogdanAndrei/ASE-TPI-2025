function [] = t_log(nume, c, tip)
    % Transformarea log pentru o imagine
    % I: nume - fisierul cu imaginea de transformat
    %    c - constanta utilizata in transformare
    %    tip - tip fisier imagine salvat
    % /E: -
    % Exemple de apel
    %    t_log('..\\imagini pentru seminar\\Cat.jpg',40,'png');

    poza=imread(nume);
    rez=uint8(c*log(1+double(poza)));
    figure
        %subplot(1,2,1), subimage(poza);
        subplot(1,2,1), imshow(poza);
        title('Imaginea initiala');
        %subplot(1,2,2), subimage(rez);
        subplot(1,2,2), imshow(rez);
        title('Imaginea transformata');
    
    [~, numecomplet, ~] = fileparts(nume);
    [doarnume, ~] = strtok(numecomplet, '.');
    imwrite(rez,[doarnume '-log.' tip],tip);

end