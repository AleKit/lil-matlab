format long
N = 10; % iteraciones de la red
n1 = 1; %sc
n2 = 2; %bcc
n4 = 4; %fcc
fnew1 = 0;
fnew2 = 0;
fnew4 = 0;
contadorminasigma = 1;
contadormint = 1;
minimos = 0;
cubics = 0;
gammavec = logspace(-3,2,100);
tbucle = linspace(0.001,0.025,49); %49 bonito
rho = linspace(0.025,0.8,32); %32 bonito
for t = tbucle
    %t = 0.001; %gana fcc pierde sc
    for a = rho %queremos hacer un bucle en a/sigma
        asigma1 = (n1/a)^(1/3); %gana fcc pierde sc si a = 0.1
        asigma2 = (n2/a)^(1/3);
        asigma4 = (n4/a)^(1/3);
        l = 1;
        for gamma = gammavec
            f1 = 3/2 * log(gamma);
            f2 = 3/2 * log(gamma);
            f4 = 3/2 * log(gamma);
            for i = -N:N
                for j = -N:N
                    for k = -N:N
                        if i == 0 && j == 0 && k == 0
                        else
                            S1 = (asigma1*sqrt(i^2+j^2+k^2))^2;% % sc
                            S2 = (asigma2/2*sqrt(3*(i^2+j^2+k^2)- ...
                                2*(i*j+j*k+k*i)))^2; % % bcc
                            S4 = (asigma4/sqrt(2)* ...
                                sqrt((i^2+j^2+k^2+i*j+j*k+k*i)))^2; % % fcc
                            f1 = f1 + 1/(t*(1+1/gamma)^(3/2))* ...
                                exp(-S1/(1+1/gamma));
                            f2 = f2 + 1/(t*(1+1/gamma)^(3/2))* ...
                                exp(-S2/(1+1/gamma));
                            f4 = f4 + 1/(t*(1+1/gamma)^(3/2))* ...
                                exp(-S4/(1+1/gamma));
                        end
                    end
                end
            end
            fnew1(l) = f1;
            fnew2(l) = f2;
            fnew4(l) = f4;
            l = l+1;
        end
        drawnow
        fnew1(end+1) = max(fnew1);
        fnew2(end+1) = max(fnew2);
        fnew4(end+1) = max(fnew4);
        hold off
        figure(1)
        %plot(gammavec,fnew1(1:end-1),gammavec, ...
        %     fnew2(1:end-1),gammavec,fnew4(1:end-1))
        [pk1,loc1] = findpeaks(-fnew1);
        [pk2,loc2] = findpeaks(-fnew2);
        [pk4,loc4] = findpeaks(-fnew4);
        Lsc=sqrt(3/(2*2*gammavec(loc1(1))))*(1/asigma1);
        Lbcc=sqrt(3/(2*gammavec(loc2(1))*3/4))/asigma2*n2^(1/3)
        Lfcc=sqrt(3/(2*gammavec(loc4(1))*2/4))/asigma4*n4^(1/3);
        minpeaks = min([-pk1(1),-pk2(1),-pk4(1)]) %,pfluido
        minimos(contadorminasigma,contadormint) = minpeaks;
        figure(2)
        hold on
        if minpeaks == -pk1(1) & Lsc < 0.15
            cubics(contadorminasigma,contadormint) = 1;
            plot(a,t/2,'*g')
        elseif minpeaks == -pk2(1) & Lbcc < 0.15
            cubics(contadorminasigma,contadormint) = 2;
            plot(a,t/2,'*r')
        elseif minpeaks == -pk4(1) & Lfcc < 0.15
            cubics(contadorminasigma,contadormint) = 4;
            plot(a,t/2,'pb')
        %elseif minpeaks == pfluido
         %   cubics(contadorminasigma,contadormint) = 0;
          %  plot(a,t/2,'*k')
        else
            cubics(contadorminasigma,contadormint) = 0;
            plot(a,t/2,'^m')
        end
        contadorminasigma = contadorminasigma + 1;
        clear fnew1 fnew2 fnew4
    end
    contadormint = contadormint + 1;
    contadorminasigma = 1;
end
figure(3)
contourf(rho,tbucle/2,cubics',2,'LineWidth', 0.01), caxis([-3,3]);