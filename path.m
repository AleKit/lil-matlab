%sirve para dibujar un camino aleatorio en 2D de forma que no 
%se pueda volver a pisar un punto que ya se pisó

%otra cosa que se puede hacer es ver la facilidad con que se
%atasca ejecutando el programa N veces
%con un nf (número máximo de pasos) alto, guardando los t
%en los que no se puede avanzar y haciendo la media

%también se podría ir dibujando como en una película
%con el comando drawnow, paso por paso

%% Para elegir un punto inicial
% m0=input('Elige el límite de la abscisa del punto inicial');
% n0=input('Elige el límite de la ordenada del punto inicial');
% 
% i0=floor((m0+1)*rand(1));
% j0=floor((n0+1)*rand(1));

%% Para empezar en el origen

i0=0; j0=0;

%número de pasos que vamos a dar
nf = input('Elige el número máximo de pasos: nf =');

%defino ya el lugar de guardado
V=zeros(nf,2);
V(1,1)=i0;
V(1,2)=j0;
t=2;
while t<=nf
    A=rand(1,2);
    if A(1)<0.5 && A(2) < 0.5 
        %hacia abajo
        i1=i0;
        j1=j0-1;
    elseif A(1)< 0.5 && A(2) >= 0.5
        %hacia la derecha
        i1=i0+1;
        j1=j0;
    elseif A(1) >= 0.5 && A(2) < 0.5
        %hacia la izquierda
        i1=i0-1;
        j1=j0;
    elseif A(1) >= 0.5 && A(2) >= 0.5
        %hacia arriba
        i1=i0;
        j1=j0+1;
    end
    %no pisar lo pisado (se puede quitar esta condición)
    %la B es para esto; las E son para el atasco
    B=zeros(t,2);
    E1=zeros(t,2);
    E2=zeros(t,2);
    E3=zeros(t,2);
    E4=zeros(t,2);
    
    B(:,1)=i1;
    B(:,2)=j1;

    E1(:,1)=i0-1;
    E1(:,2)=j0;
    E2(:,1)=i0+1;
    E2(:,2)=j0;
    E3(:,1)=i0;
    E3(:,2)=j0-1;
    E4(:,1)=i0;
    E4(:,2)=j0+1;
    D=0;
    F=0;
    for a = 1:t-1
        C = B(a,:) == V(a,:);

        if C == [1,1]
            D = 1;
        end
    end
        for a = 1:t-1
        %condición de atasco: ya hemos pisado lo de alrededor
            F1 = E1(a,:) == V(a,:);
            F2 = E2(a,:) == V(a,:);
            F3 = E3(a,:) == V(a,:);
            F4 = E4(a,:) == V(a,:);
            if F1 == [1,1]
                F = F+1;
                %fprintf('F1 \n para a =')
                %disp(a)
            end
            if F2 == [1,1]
                F = F+1;
                %fprintf('F2 \n para a =');
                %disp(a);
            end
            if F3 == [1,1]
                F = F+1;
                %fprintf('F3 \n para a =');
                %disp(a);
            end
            if F4 == [1,1]
                F = F+1;
                %fprintf('F4 \n para a =');
                %disp(a);
            end
        end
    if F == 4
        fprintf('No se puede avanzar más. \n Nos hemos quedado en t = %d \n', t)
        break
    elseif D == 0
        V(t,1)=i1;
        V(t,2)=j1;
        i0=i1; j0=j1;
        t=t+1;
        F=0;   
     else
         i0=V(t-1,1);
         j0=V(t-1,2);
         F=0;
     end
end
hold off %si no quieres que pinte un camino sobre otro    
plot (V(1,1),V(1,2),'*r')
hold on
if F == 4
    plot(V(1:t-1,1),V(1:t-1,2))
    plot(V(t-1,1),V(t-1,2),'*y')
else
    plot(V(:,1),V(:,2))
    plot(V(nf,1),V(nf,2),'*g')
end
legend('origen','camino','extremo')