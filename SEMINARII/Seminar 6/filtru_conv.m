function [ R ] = filtru_conv( I, w )
    % aplicarea filtrului de tip corelatie pe o imagine (un plan)
    % I: I - imaginea initiala (un plan)
    %    w - filtrul aplicat (matrice patrata, dimensiuni impare)
    % E: R - imaginea filtrata
    
    % pentru operatia de corelatie se poate folosi functia MatLab filter2(w,f)
    % pentru operatia de convolutie se poate folosi functia MatLab conv2
    
    [m,n]=size(I);
    [m1,n1]=size(w);
   
    a=(m1-1)/2; b=(n1-1)/2;
    l=m+2*a; c=n+2*b;
    
    f=zeros(l,c);
   
    f(a+1:m+a,b+1:n+b)=double(I);
    R=zeros(m,n);
       
    % filtrare cu masca w
    for i=1:m
        for j=1:n
%varianta 1
%             for s=-a:a
%                 for t=-b:b
%                     %remarcati ca simpla schimbare a semnului pentru s si t
%                     %in formulele indicilor pentru f, adica - in loc de +
%                     %fata de functia filtru_c, 
%                     %transforma operatia din corelatie in convolutie.
%                     R(i,j)=R(i,j)+w(1+a+s,1+b+t)*f(i+a-s,j+b-t);
%                 end;
%             end;
%final varianta
%varianta din prezentarea de la seminar
              for s=1:m1
                  for t=1:n1
                      R(i,j)=R(i,j)+w(s,t)*f(i+m1-s, j+n1-t);
                  end;
              end;
%final varianta
        end;
    end;
end

