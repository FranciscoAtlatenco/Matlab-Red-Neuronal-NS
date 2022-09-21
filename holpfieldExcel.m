clc
clear all

%Matriz a Original
[num,txt,raw] = xlsread('Datos1.xlsx', 'Matriz Original');
A = [num(:,:)];
%Matriz Corrupta
[num1,txt1,raw1] = xlsread('Datos1.xlsx', 'Matriz Original');
U =[num1(:,:)];

%calculamos matriz de pesos de cada vector de entrada
for i=1: size(A)
    p = A(i,:);
    w = p'*p;
    %Diagonal
    w(eye(size(w))==1) = 0;
    %ahora comparamos si se recupero 
    pro = U(i,:);
    rec = pro*w;
    tam = size(rec);
    %normalizamos
    for y=1:tam(2)
        if rec(y) > 0
            rec(y) = 1;
        elseif rec(y) < 0
            rec(y) = -1;
        else%en caso de que sea cero se pone el patron anterior en los valores
            if y == 1%en caso de ser la primer fila se coloca el de prototipo
                rec(y) = pro(y);%en caso de que sea cero se pone el patron anterior en los valores
            else
                rec(y) = rec(y-1);%Es erroneo
            end
        end
    end
    if rec == A(i,:)
        rec
        imprime = 'recuperacion total', i
        Salida(i, :) = rec;
        %fprintf(documentoF, rec);
    else
        rec
        imprime = 'recuperacion parcial', i
        Salida(i, :) = rec;
        w
        %fprintf(documentoF, w);
    end
end
%diagonal=size(A,1);
%A(1:(diagonal+1):end)=0;
imprime = 'Recuperacion final'
heatmap(A)
%Salida
