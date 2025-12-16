function [zgE] = tipzg(nume1,med,var,a,b,d,aE,bR)
    % exemple de aplicare a diverselor tipuri de zgomot pe imagini
    % I: nume1 - nume fisier cu imaginea initiala 
    %         tip de zgomot - 1 gaussian cu media med si varianta var
    %                         2 uniform [a,b]
    %                         3 impuls cu densitate d
    %                         4 exponential aE
    %                         5 rayleigh a=0, b=bR 
    %          [ pentru a genera un singur tip de zgomot se adauga "tip"
    %            ca parametru si se elimina bucla "for tip=1:5" ] 
    % exemple de apel:
    %   tipzg('LENNAA.BMP',0,20,0,30,0.05,10,900);
    %   tipzg('NASA2.jpg',0,20,0,30,0.05,10,900);
    %   tipzg('vulpea si marmota.jpg',0,20,0,30,0.05,10,900);
    
    J=imread(nume1); 
    [m,n,~]=size(J);
    figure
        imshow(J);
        title('Imaginea initiala');
        f=double(J(:,:,1));
  for tip=1:5    
    switch tip
        case 1
            % zgomot gaussian de medie med si varianta var, pe imagine
            % nenormalizata
            zg=normrnd(med,var,[m,n]);
            J1=uint8(f+zg);
            figure
                imshow(J1);
                title('Imaginea cu zgomot aditiv gaussian');
                imwrite(J1,[nume1 '_zg_GN.png'],'png');
        case 2
            % zgomot uniform pe [a,b]
            zg=unifrnd(a,b,[m,n]);
            J1=uint8(f+zg);
            figure
                imshow(J1);
                title('Imaginea cu zgomot aditiv uniform');    
            imwrite(J1,[nume1 '_zg_UN.png'],'png');
        case 3
            % zgomot sare si piper;
            J1 = imnoise(J,'salt & pepper',d);
            figure
                imshow(J1);
                title('Imaginea cu zgomot aditiv sare si piper');
                imwrite(J1,[nume1 '_zg_SPN.png'],'png');
        case 4
            % Zgomot exponential cu parametru aE;
            zg=zeros(m,n);
            % zg nu trebuie sa contina 0 pentru ca ln(0) nu e definit
            % zg=unifrnd(0,1,[m,n]); poate produce zero in zg
            for l=1:m
                for c=1:n
                    while zg(l,c)==0
                        zg(l,c)=unifrnd(0,1);
                    end;
                end;
            end;
            zgE=zeros(m,n);
            for l=1:m
                for c=1:n
                    zgE(l,c)=-log(zg(l,c))/aE;
                end;
            end;
            g=double(f)/255+zgE;
            J1=uint8(255*g);
            figure
                imshow(J1);
                title('Imaginea cu zgomot aditiv exponential');    
                imwrite(J1,[nume1 '_zg_ExpN.png'],'png');
        case 5
            % zgomot Rayleigh cu a=0, b=bR
            zg=zeros(m,n);
            % zg nu trebuie sa contina 0 pentru ca ln(0) nu e definit
            % zg=unifrnd(0,1,[m,n]); poate produce zero in zg
            for l=1:m
                for c=1:n
                    while zg(l,c)==0
                        zg(l,c)=unifrnd(0,1);
                    end;
                end;
            end;
            sig1=sqrt(bR/2);
            zgR=zeros(m,n);
            for l=1:m
                for c=1:n
                    zgR(l,c)=sig1*(-2*log(zg(l,c)))^0.5;
                end;
            end;
            J1=uint8(f+zgR);
            figure
                imshow(J1);
                title('Imaginea cu zgomot aditiv Rayleigh'); 
                imwrite(J1,[nume1 '_zg_RayN.png'],'png');
        otherwise
            disp('Tip zgomot necunoscut');
    end;
  end;
end

