function [] = test(bR,med,var)
    % exemplu de zgomot (rayleigh, gaussian) pe un "perete gri" 
    % I: bR - constanta b pentru rayleigh, a este zero
    %    med, var - media si varianta pentru gauss
    % E: -
    %
    % Exemplu de apel:  
    %    test(900,0,20);

    % imagine de test tip "perete gri"
    m=500;n=500;    %dimensiuni imagine gri 
    f=127*ones(m,n);
    
    % Zgomot Rayleigh cu a=0, b=bR
    zg=unifrnd(0,1,[m,n]);
    sig1=sqrt(bR/2);
    zgR=zeros(m,n);
    for l=1:m
        for c=1:n
            zgR(l,c)=sig1*(-2*log(zg(l,c)))^0.5;
        end
    end
    J1=uint8(f+zgR);
    figure
        imshow(J1);
        title('Zgomot aditiv Rayleigh'); 
    imwrite(J1,'testR.png','png');

    % Zgomot gaussian cu medie med si dispersie var
    f=127*ones(m,n);
    zg=normrnd(med,var,[m,n]);
    J1=uint8(f+zg);
    figure
        imshow(J1);
        title('Zgomot aditiv gaussian');
        imwrite(J1,'testG.png','png');
end

