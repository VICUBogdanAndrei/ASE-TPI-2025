function []=hist_arcsin(nume)
    % specificarea histogramei (arcsin) pentru o imagine
    % I: nume - fisierul cu imaginea de prelucrat
    % E: -
    % Exemple de apel:
    % hist_arcsin('BufnitaS.png');
    
    poza=imread(nume);
    [~,~,p]=size(poza);
    rez=poza;
    im_eq=poza;
    for k=1:p
        [rez(:,:,k),im_eq(:,:,k)]=prelucrare_plan(poza(:,:,k));
    end;
    figure
        subplot(2,2,1), subimage(poza);
        title('Imaginea initiala');
        subplot(2,2,2), subimage(im_eq);
        title('Imaginea cu histograma egalizata');
        subplot(2,2,4), subimage(rez);
        title('Imaginea cu histograma arcsin');
        
    figure
        imshow(rez);
        title('Imaginea transformata');
        
    for k=1:p
        figure
            histograma_rezultat(rez(:,:,k));
            title(['Histograma pentru planul ' num2str(k)]);
    end;
        
    imwrite(rez,[nume '-arcsin.png']);
end

function [r,r1]=prelucrare_plan(plan)
    % prelucrarea histogramei pentru un plan
    % I: plan - planul pe care se lucreaza
    % E: r - planul cu histograma arcsin
    %    r1 - planul cu histograma egalizata
    
    [m,n]=size(plan);
    L=255;
    h=zeros(1,L+1);
    for i=1:m
        for j=1:n
            h(plan(i,j)+1)=h(plan(i,j)+1)+1;
        end;
    end;
    h=h/(m*n);
    r=zeros(m,n);
    r1=zeros(m,n);
    hnou=zeros(1,L+1);
    hnou(1)=h(1);
    for i=2:L+1
        hnou(i)=hnou(i-1)+h(i);
    end;
    for i=1:m
        for j=1:n
            r(i,j)=127.5*(1+sin(pi*(hnou(plan(i,j)+1)-0.5)));
            r1(i,j)=L*hnou(plan(i,j)+1);
        end;
    end;
    r=uint8(r);
    r1=uint8(r1);
end

function []=histograma_rezultat(plan)
    % reprezentare histograma pentru un plan din imaginea rezultat
    % I: plan - planul pentur care se reprezinta histograma
    % E: - 
    
    [m,n]=size(plan);
    L=255;
    h=zeros(1,L+1);
    for i=1:m
        for j=1:n
            h(plan(i,j)+1)=h(plan(i,j)+1)+1;
        end;
    end;
    h=h/(m*n);
    
    plot(h);
end
