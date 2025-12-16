function [] = indicatori( poza_o, poza_p, poza_r )
    % calcul SNR si RMI pentru imagine perturbata / restaurata fata de orig.
    % toate imaginile sint tip gray-scale
	% I: poza_o - fisier cu imaginea clara, neperturbata
    %    poza_p - fisier cu imaginea perturbata
    %    poza_r - fisier cu imaginea restaurata
    % E: - 
    % Exemple de apel:
    % indicatori('car_gray.png','car_gray_MD_y_iT_9_s_15.png','car_gray_MD_y_iT_9_s_15_W_g_0.02.png');
    % indicatori('car_gray.png','car_gray_MD_y_iT_9_s_15.png','car_gray_MD_y_iT_9_s_15_W_g_0.2.png');
    % indicatori('LENNAA.BMP','LENNAA_MD_y_iT_11_s_5.bmp','LENNAA_MD_y_iT_11_s_5_M_3_I_.bmp');
    
    a=SNR(poza_p,poza_o);
    b=SNR(poza_r,poza_o);
    c=RMI(poza_p,poza_o);
    d=RMI(poza_r,poza_o);
    
    disp(['SNR: P: ' num2str(a) ' - R: ' num2str(b)]);
    disp(['RMI: P: ' num2str(c) ' - R: ' num2str(d)]);
end

