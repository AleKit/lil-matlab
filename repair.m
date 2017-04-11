%% Problema de reparacion (PROS)
% Supongamos que un sistema  necesita para funcionar 
%que n maquinas esten operativas.
%Cuando una maquina falla puede ser reemplazada 
%por otra de repuesto y lamaquina rota debe ser 
%reparada por un operario.
%Cuando una maquina es reparada pasa a constituir 
%una unidad de repuesto. El tiempo durante el cual una
%maquina esta operativa es una variable
%independiente de cualquier otra y con distribucion F.
%El sistema se colapsa cuando una máquina falla y no hay
%ninguna unidad de respuesto disponible.
 
%Se desea estimar mediante simulación el tiempo
%medio de colapso
 
%% Inicializacion
%n máquinas operativas + s de respuesto
 
%n=input...
%s=input...
 
n=5;
s=17;
t=0; %instante inicial de tiempos
r=0; %número de maquinas rotas
N=n+s+r; %para comprobar si funciona todo bien
 
%tiempos: tiempo en el que cada maquina se rompe,
%tiempo en el que una maquina se arregla
 
%tengo que generar ts, ta
tss=rand(1,n);
tss=sort(tss)
ta=inf;
%supongamos que se rompe una maquina
while true
if tss(1)<=ta
   if s>0
       s=s-1;
   elseif s==0
       fprintf('Colapso en')
       disp(tss(1))
       T=tss(1);
       break
   else
       fprintf('Algo raro pasa')
   end
   r=r+1;
   plot(t,r,'*')
   hold on
   %drawnow
   t=tss(1);
   %generar un nuevo ts = ts + algo
   tsn=t+rand(1);
   tss(1)=tsn;
   tss=sort(tss);
   %generar un ta solo si hay una rota
   if r==1
       ta=t+rand(1);
   end
%supongamos que se arregla una maquina
elseif ta<tss(1)
    s=s+1;
    r=r-1;
    plot(t,r,'*')
    hold on
    %drawnow
    t=ta;
    %generar un nuevo ta
    if r==1
        ta=t+rand(1);
    elseif r==0
        ta=inf;
    end
    
end
end
hold off
 
%para cuando haga varias iteraciones (k)
%ET= 1/k * sum (T_i)

%creo que hay algo mal, con n=s=50 ha ido de r=1 a r=50
%sin bajar en ningun momento, con un ta = 0.74
