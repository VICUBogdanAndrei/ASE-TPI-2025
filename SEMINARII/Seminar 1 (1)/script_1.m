%% MASIVE
%initializari
X=[2,4,5];
Y=[2;4;5];
A=[[2,1,0];[1,1,0];[1,2,1]];
T=zeros(3,3,2);
T(:,:,1)=A;
T(:,:,2)=A;
%afisare
disp(X);
disp(Y);
disp(A);
disp(T);
%accesare element/linie,coloana,plan
prim_X=X(1);
elementul_1_2=A(1,2);
prima_linie_A=A(1,:);
prima_coloana_A=A(:,1);
el_1_2_2=T(1,2,2);
primul_plan=T(:,:,1);


%% STUCTURI DE CONTROL
% IF, IF-ELSE, IF-ELSEIF
A=[[2,1,0,1];[1,1,0,3];[1,2,1,5]];
[m,n]=size(A);
if m==n
    disp('A este patratica');
elseif m>n
    disp('Mai multe linii')
else
    disp('Mai multe coloane');
end
% SWITCH
switch m
    case 1
        disp('A este vector linie');
    case n
        disp('A este patratica');
    otherwise
        disp('ok...');
end
% FOR
% numarul elementelor nule din T
nr_0=0;
[l,c,p]=size(T);
for i=1:l
    for j=1:c
        for k=1:p
            if ~T(i,j,k)
                nr_0=nr_0+1;
            end
        end
    end
end
disp(['numarul de elemente nule din T este ' int2str(nr_0)]);

for i=20:-2:10
    disp(i);
end

%WHILE

%aduna numerele din fis_numere
sum=0;
f_nr=fopen('fis_numere.txt','r');
while ~feof(f_nr)
    sum=sum+fscanf(f_nr,'%d',[1,1]);
end
disp(['suma numerelor din fisier este ' int2str(sum)]);
