% Ewald's method
%made with cuNii

% ANTES DE EJECUTAR: EDITAR LO SIGUIENTE
% n1 en lineas: 8-10
% R1 en lineas: 13-15
% n en linea: 21
% N1, N2 en lineas: 26-27 

% % numero de atomos por celda primitiva
n1 = 1; %sc
% n1 = 2; %bcc
% n1 = 4; %fcc

% % Distancia del primer punto al origen
R1 = 1; % sc
% R1 = sqrt(3)/2; % bcc
% R1 = 1/sqrt(2); % fcc

%calculo de radios reciprocos - falta hacer la raiz cuadrada
%no confundir k con krec

%falta poner los for y tal
n = 4; % debe ser el exponente
% if mod(n,2) == 1
%     disp('El exponente debe ser par')
%     break
% end
N1 = 5; % iteraciones red reciproca
N2 = 5; % iteraciones red directa
S1 = 0; % suma 1
S2 = 0; % suma 2

a = 1; % Parametro de red.
G = (4*n1*pi/3)^(1/3)*a;
m = n/2-1;
% % Calculo de S1: - red reciproca
S1 = S1+2*(-G^n/n+n1*pi^(3/2)*G^(2*m-1)/(2*m-1));
for i = -N1:N1 % bucle para la red reciproca
    for j = -N1:N1
        for k = -N1:N1
            if i == 0 && j == 0 && k == 0
            else
                % % sea kl el modulo del vector que define la red reciproca
                % % sc
                kl = 2*pi/a*sqrt(i^2+j^2+k^2);
                % % bcc 
                % kl = 2*pi/a*sqrt(2*(i^2+j^2+k^2+i*j+j*k+k*i));
                % % fcc
                % kl = 2*pi/a*sqrt(3*(i^2+j^2+k^2)-2*(i*j+j*k+k*i));
                % % % % % % % % % % %
                S1 = S1+n1*pi^(3/2)*(kl/2)^(2*m-1)/(-m+0.5)*(gamma(-m+1.5)...
                   *gammainc((kl/(2*G))^2,-m+1.5,'upper')...
                   -(kl/(2*G))^(2*(-m+0.5))*exp(-(kl/(2*G))^2));
            end
        end
    end
end
disp(S1)
% % Calculo de S2: - red directa
for i = -N2:N2 % bucle para la red directa
    for j = -N2:N2
        for k = -N2:N2
            if i == 0 && j == 0 && k == 0
            else
                % % sc
                Rj = a*sqrt(i^2+j^2+k^2);
                % % bcc
                % Rj = a/2*sqrt(3*(i^2+j^2+k^2)-2*(i*j+j*k+k*i));
                % % fcc
                % Rj = a*sqrt((i^2+j^2+k^2+i*j+j*k+k*i)/2);
                % % % % % 
                S2 = S2+gamma(m+1)*gammainc((G*Rj)^2,m+1,'upper')/Rj^n;
            end
        end
    end
end
disp(S2)
S = ((S1+S2)/gamma(m+1))*R1^(n);
disp('El exponente usado es n =')
disp(n)
disp('La suma ha dado S=')
disp(S)
clear S S1 S2 Rj kl i j k
