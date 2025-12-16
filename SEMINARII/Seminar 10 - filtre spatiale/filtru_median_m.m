function [B] = filtru_median_m(nume,d)
    % filtru median pentru eliminarea zgomotului, folosind functia matlab 
    % medfilt2
    % I: nume - fisierul cu imaginea perturbata, monocroma sau color: se
    %           utilizaza doar primul plan, rezultatul va fi monocrom
    %    d - dimensiunea filtrului
    % E: B - imaginea filtrata (monocroma, un plan)
    
    I=imread(nume);
    [~,~,p]=size(I);
    if p>1
        I=rgb2gray(I);
    end;
    B=medfilt2(I,[d d]);
end

