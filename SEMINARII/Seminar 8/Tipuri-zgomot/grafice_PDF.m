function [] = grafice_PDF(miu,sig,a,b)
    % reprezentare grafica a repartitiilor de probabilitate pentru diverse
    % tipuri de zgomot (gaussian, exponential negativ, Rayleigh, uniform)
    % I: miu, sig - media si varianta repartitiei (pentru gauss)
    %    a, b - constante pentru exponentiala negativa, rayleigh si
    %    uniforma
    % E: -
    % Exemplu de apel: 
    %    grafice_PDF(2,3,3,5);
    
    % repartitia gauss
    figure
        i=miu- 4*sig : 0.01 : miu+4*sig;
        p=plot(i,1/(sqrt(2*pi*sig^2))*exp(-(i-miu).^2/(2*sig^2)));
        text(miu+sig,0.1,'\leftarrow repartitia Gauss' , 'HorizontalAlignment','left')
        set(p,'Color','black','LineWidth',2)
        title(['\mu=' num2str(miu) '     \sigma=' num2str(sig)]);
    
    % repartitia exponentiala negativa
    figure
        i=0:0.01:a+3;
        p=plot(i,a*exp(-(a*i)));
        text(1,0.5,'\leftarrow repartitia exponentiala negativa' , 'HorizontalAlignment','left')
        set(p,'Color','black','LineWidth',2)
        title(['a=' num2str(a)]);
        
    % repartitia Rayleigh
    figure
        i=a:0.01:a+3*b;
        p=plot(i,(2/b)*(i-a).*exp(-(i-a).^2/b));
        text(8,0.2,'\leftarrow repartitia Rayleigh' , 'HorizontalAlignment','left')
        set(p,'Color','black','LineWidth',2)
        title(['a=' num2str(a) '     b=' num2str(b)]);
        axis([0,a+3*b,0,0.5]);
        
    % repartitia uniforma
    figure
        i=a:0.01:b;
        p=plot(i,1/(b-a),'k.');
        text(a+1,0.4,'\leftarrow repartitia uniforma' , 'HorizontalAlignment','left')
        set(p,'Color','black','LineWidth',2)
        title(['a=' num2str(a) '     b=' num2str(b)]);
        axis([0,8,0,0.6]);
end



