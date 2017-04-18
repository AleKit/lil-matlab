%made with cuNii

format long
S = 0; % Suma
n = 14; % exponente deseado
N = 50; % iteraciones
% a = 1
%for n = 6:16
for i = -N:N
    for j = -N:N
        for k = -N:N
            if i == 0 && j == 0 && k == 0
            else
                % % sc
                % S = S+(1/sqrt(i^2+j^2+k^2))^n;
                % % % % % % % % % % % % % % % % % % % % % % % %
                % % bcc
                % S = S+((sqrt(3)/2)/sqrt((3*(i^2+j^2+k^2)-2*(i*j+j*k+k*i))/4))^n;
                % % % % % % % % % % % % % % % % % % % % % % % % 
                % % fcc
                S = S+((1/sqrt(2))/sqrt((i^2+j^2+k^2+i*j+j*k+k*i)/2))^n;
            end
        end
    end
end
disp('El exponente usado es n =')
disp(n)
disp('La suma ha dado S=')
disp(S)
%S = 0;
%end
clear i j k
