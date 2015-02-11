% Skript zur "�bung 04 - Absorber" des Kurses "Technische Akustik und
% L�rmbek�mpfung" an der Technischen Universit�t M�nchen im WS 14/15.
% Berechnung des Schallabsorptionsgrades alpha  eines por�sen Vorhangs in
% Abh�ngigkeit des Abstandes d zur Wand, sowie der Wellenl�nge lambda.
%
% Gaetano Andreisek, Audio Information Processing, Nov. 2014

clear all 
close all

% Dichte Luft [kg/m^3]
rho = 1.2;
% Schallgeschwindigkeit [m/s]
c = 340;

% Abstand des por�sen Vorhangs von der Wand in Abh�ngigkeit der Wellenl�nge
% d/lambda [-]
d_lambda = 0.001:0.001:1;

% Str�mungswiderstand w des por�sen Vorhangs [N*sec/m^3] (max. 6)
w = rho*c*[1,2,4,0.25,0.5];

for ii = 1:length(w)
    for jj = 1:length(d_lambda)
        Z_rho_c = w(ii)/( rho*c) - 1i*cot(2*pi*d_lambda(jj) );
        alpha(jj,ii) = 4*real(Z_rho_c)/...
            ( (real(Z_rho_c)+1)^2 + imag(Z_rho_c)^2);
    end
end

% Plot-Einstellungen
leg_str = cell(0);
color = ['b','r','g','k','c','m'];
hold on
for kk = 1: size(alpha,2)
    plot(alpha(:,kk),'LineWidth',2,'Color',color(kk))
    leg_str{kk,1} = ['w"/(\rho c) = ' num2str(w(kk)/(rho*c))];
end
xlim([0 1000])
labels = [0,0.25,0.5,0.75,1.0];
title('Absorptionsgrad \alpha_s eines por�sen Vorhangs in Abh�ngigkeit von Wellenl�nge \lambda und Abstand zur Wand d','FontSize',16)
set(gca,'LineWidth',1.5)
set(gca, 'XTick', labels(1:length(labels))*length(d_lambda));
set(gca,'XTickLabel',labels)
set(gca,'FontSize',14)
xlabel('d/\lambda','FontSize',20)
ylabel('Absorptionsgrad \alpha_s','FontSize',20)
legend(leg_str)
grid on
