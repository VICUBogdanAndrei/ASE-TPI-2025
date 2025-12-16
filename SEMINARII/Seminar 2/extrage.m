function [mesaj]=extrage(poza_o, poza_m)
    % extrage mesaj ascuns in poza, avind poza originala si cea modificata.
    % poza color sau nuante de gri (bmp, png, gif numai pentru nuante de
    % gri)
    % I: poza_o - nume fisier poza originala), 
    %    poza_m - nume fisier poza modificata
    % E: mesaj - mesajul extras
    % Exemplu de apel:
    %    mesaj=extrage('mb_orig.png','mb_mod.png');
    %    mesaj=extrage('original.png','modificat.png');
    
    IO=imread(poza_o);
    IM=imread(poza_m);
    
    mesaj='';
    [m,n,p]=size(IO);
    
    dif=IM-IO;                  % masiv diferente
    for k=1:p                   % fiecare plan (chiar daca e doar 1)
        for i=1:m               % fiecare linie
            for j=1:n           % fiecare coloana
                if dif(i,j,k)   % aici e o litera ascunsa
                    % adauga la mesaj litera corespunzatoare numarului
                    mesaj=[mesaj dif(i,j,k)+'a'-1];
                end;
            end;
        end;
    end;
end
    
