clc
clear all
disp('--------------------------------------------')
fprintf('Hernández Larios José Adrián\n\n')
disp('--------------------------------------------')
%Matriz T
fprintf('Ingrese los valores de la Matriz T de dimension 3x3 \n\n')
disp('--------------------------------------------')
t1=input('Ingrese los valores de t1: ')
t2=input('Ingrese los valores de t2: ')
t3=input('Ingrese los valores de t3: ')
T= [ t1; t2; t3 ]
disp('--------------------------------------------')
%Matriz alterada o de prueba
fprintf('Ingrese los valores de la Matriz alterada/prueba de dimension 3x3 \n\n')
disp('--------------------------------------------')
M_alterada1=input('Ingrese los valores de T alterada 1: ')
M_alterada2=input('Ingrese los valores de T alterada 2: ')
M_alterada3=input('Ingrese los valores de T alterada 3: ')
X=[M_alterada1; M_alterada2; M_alterada3]
disp('--------------------------------------------')
%Todos
TamX= [ t1; t2; t3; M_alterada1; M_alterada2; M_alterada3];
%Asociadores lineales de T
ta1= t1' * t1
ta2= t2' * t2
ta3= t3' * t3
%Asociador HOPFIELD
asociadorlineal=ta1+ta2+ta3
diagonal=size(asociadorlineal,1)
%Se hace la diagonal 0
asociadorlineal(1:(diagonal+1):end)=0
%size () le da el número de filas y columnas de una matriz dada
[m , n ]= size(TamX)
fila=0;
%Se entra a la condición del algoritmo.
while fila<m
    fila=fila+1;
    disp('---------------------------------------------------------------')
    disp('Fila: ')
    disp(fila)
    disp('---------------------')
    pfila=TamX(fila,:);
    asociadorHOPFIELD=pfila*asociadorlineal;    
    disp('Patron REFERENCIA 1= '); disp(t1)
    disp('Patron REFERENCIA 1= '); disp(t2)
    disp('Patron REFERENCIA 1= '); disp(t3)
    fprintf('------------------ P r u e b a -------------------------\n\n')
    disp(pfila);
    [filas , columnas ]= size(asociadorHOPFIELD);
    for columna=1:columnas
        a=asociadorHOPFIELD(filas,columna);
        %Se entra a la condicion Hardlims
        if a>0
            a=1;
        else
            a=-1;
        end
      asociadorHOPFIELD(filas,columna)=a;
    end
    asociadorHOPFIELD
    for iteracion=2:10
        asociadorHOPFIELD(iteracion,:)=asociadorHOPFIELD(iteracion-1,:)*asociadorlineal;
        for columna=1:columnas
        a=asociadorHOPFIELD(iteracion,columna);
        %Se entra a la condicion Hardlims
            if a>0
                a=1;
            else
                a=-1;
            end
        asociadorHOPFIELD(iteracion,columna)=a;
        end
        if iteracion==10
            asociadorHOPFIELD;
        end 
    end
    fprintf('- h o p f i e l d ---------------\n\n');
    fprintf('Asociador \n\n');
    disp(asociadorHOPFIELD(7,:))
    disp(asociadorHOPFIELD(8,:))
    disp(asociadorHOPFIELD(9,:))
    disp(asociadorHOPFIELD(10,:))
    fprintf('\n---------------- Recuperacion PARCIAL----------------\n\n');
    if t1==asociadorHOPFIELD(m,:)
    disp('Recuperacion del primer patron')
elseif (t2==asociadorHOPFIELD(m,:)) | (t3==asociadorHOPFIELD(m,:))
    disp('Recuperacion del segundo y tercer  patron')
    else
    end
    %Condicion para indicar si la matriz es estable o no.
    if asociadorHOPFIELD(m-2,:) == asociadorHOPFIELD(m-1,:)
        if asociadorHOPFIELD(m-1,:) == asociadorHOPFIELD(m,:)        
            disp ('ES ESTABLE')
        else 
            disp('NO ES ESTABLE')
        end
    else 
            disp('NO ES ESTABLE')
    end 
end