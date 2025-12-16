function [er] = perturba_sp(poza,filtru,tip)
	% Simularea perturbarii cu mastile din fisierele mb?.txt in domeniul 
    % spatial
    % I: poza - numele fisierului cu poza de perturbat (clara, originala)
    %    filtru - numele fisierului text care contine masca de filtrare;
    %             filtre disponibile: mb1.txt, mb2.txt, mb3.txt, mb4.txt
    %    tip - tipul fisierelor rezultate (numele va fi compus din numele
    %          fisierului initial plus numele mastii)
    % E: er - indicatorul SNR pentru imaginea perturbata
    
    % exemple de rulare:
    %   perturba_sp('car.jpg','mb1.txt','png');
    %   perturba_sp('LENNAA.BMP','mb2.txt','png');

    % preluare poza, transformare in grayscale si salvare 
    imag=imread(poza);
    [~,~,p]=size(imag);
    if p>1
        imag=rgb2gray(imag);
    end;
    % salvare versiune monocroma in directorul curent
    temp=strfind(poza,'\\');
    if ~isempty(temp)     %length(temp)~=0
        poza=poza(temp(end)+2:end);
    end;
    [nume,~]=strtok(poza,'.');
    fi=[nume '-gray.' tip];
    imwrite(imag,fi,tip);

    % preluare filtru
    w=load(filtru);
    w=w/sum(sum(w));
    
    % filtrul e aplicat folosind functia matlab "imfilter"
    rez=imfilter(imag,w);
    
    % vizualizare imagine initiala si perturbata
    figure
        imshow(imag);
        title('Imaginea initiala');
        
    % salvare imagine perturbata
    fo=[strtok(fi,'.') '-' strtok(filtru,'.') '.'  tip];    
    imwrite(rez,fo,tip);
    er=SNR(fo,fi);    
    
    figure
        imshow(rez);
        title(['Imaginea perturbata spatial cu masca ' strtok(filtru,'.')  ', SNR: ' num2str(er)]);
        

end

