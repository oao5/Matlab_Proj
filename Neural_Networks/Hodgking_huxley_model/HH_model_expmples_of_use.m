close all
%%Setting Constances
V0 = -65e-3;    % resting potential -65[mV]
dt = 0.04e-3;       %  0.01[msec]
C_m = 1e-3;         %  membrane capatcitance 1[uF/cm^2]
g_K = 36e-3;        %Postassium (K) maximum conductances 36[mS/cm^2]
g_L = 0.3e-3;       % Leak maximum conductances 0.3[mS/cm^2]
g_Na = 120e-3;      % Sodium (Na) maximum conductances 120[mS/cm^2]
E_K = -77e-3;       % Postassium (K) Nernst reversal potentials -77[mV]
E_Na = 50e-3;       % Sodium (Na) Nernst reversal potentials 50[mV]
E_l = -54.387e-3;   % Leak Nernst reversal potentials -54.4[mV]

%% 1. pulse injection and dynamics of h,m,n 
I_Pulse = 16e-6; % current strength 10[uA]
I_ex  = zeros(1,550); % create a vector of current
I_ex(100:110)  = I_Pulse; % stimulation during 10 to 25 msec
[Vt,nt,ht,mt] = HH(V0,C_m,g_K,g_Na,g_L,E_Na,E_l,E_K,I_ex,dt);

%%
% 1.Plots
t = 0:dt:(length(Vt) - 1) * dt;
f1 = figure('WindowState','maximized');
sgtitle('Pulse current in HH model - pulse current')
subplot(2,1,1)
plot(t*1000,Vt*1000)
title('Voltage over time')
xlabel('time [msec]')
ylabel('Voltage [mV]')
yline(-65,'--','V-rest -65 [mV]','Color','red')
subplot(2,1,2)
plot(t*1000,I_ex*10^6)
title('Current over time - pulse current')
xlabel('time [msec]')
ylabel('Current [\muA]')
f2 = figure('WindowState','maximized');
sgtitle("h,m,n change in time - pulse current ")
hold on
plot(t(1:end-1)*1000,mt)
plot(t(1:end-1)*1000,ht)
plot(t(1:end-1)*1000,nt)
xlabel("time [msec]")
ylabel("h,m,n value ")
legend('m','h','n')
hold off

%%
%2.1 constant pulse injection 
I_const = 16e-6; % current strength 10[uA]
I_ex(1:1000)  = I_const; % create a a constant current vector
 [Vt,nt,ht,mt] = HH(V0,C_m,g_K,g_Na,g_L,E_Na,E_l,E_K,I_ex,dt);

% 2.1.Plots
t = 0:dt:(length(Vt) - 1) * dt;
f3 = figure('WindowState','maximized');
sgtitle('constant current in HH model')
subplot(2,1,1)
plot(t*1000,Vt*1000)
title('Voltage over time')
xlabel('time [msec]')
ylabel('Voltage [mV]')
yline(-65,'--','V-rest -65 [mV]','Color','red')
subplot(2,1,2)
plot(t*1000,I_ex*10^6)
title('Current over time')
xlabel('time [msec]')
ylabel('Current [\muA]')
f4 = figure('WindowState','maximized');
sgtitle("h,m,n change in time - constant current ")
hold on
plot(t(1:end-1)*1000,mt)
plot(t(1:end-1)*1000,ht)
plot(t(1:end-1)*1000,nt)
xlabel("time [msec]")
ylabel("h,m,n value ")
legend('m','h','n')
hold off

%%
% 2.2 how diffrent constant currents create diffrent spikes rate 
TH = -55e-3; %neuron estimated threshold  [mV]
spike_rate_vec = zeros(1,40); % memory allocation of spike counts vector
current_vec = zeros(1,length(spike_rate_vec)); %% memory allocation of currents vec 
for i = 1:length(spike_rate_vec)
I_const = (1e-6)*(i-1); % diffrent curent magnitude
I_ex(1:4000)  = I_const; % create a a constant current vector
[Vt,~,~,~] = HH(V0,C_m,g_K,g_Na,g_L,E_Na,E_l,E_K,I_ex,dt);
current_vec(i) = I_const;
spike_rate_vec(i) = (spike_current_count(Vt,TH))/(length(Vt)*dt); 
end

% 2.2.Plot

f5 = figure('WindowState','maximized');
sgtitle('Spike rate through diffrent constant currents')
plot(current_vec*10^6,spike_rate_vec)
ylabel('Spike rate [Hz]')
xlabel('Current [\muA]')


%%
%3.1 show there is a refactoric period 
% i will insert 3 currents pulses for approximatly less 1[msec]  within aprroximatly 1[msec] intervals with and show
% that after the first spike there is not another spike (because there is
% a rafactoric period
I_const = 15e-6; % current strength 10[uA]
I_ex=zeros(1,1000);
I_ex(100:120)  = I_const; 
I_ex(150:170)  = I_const;
I_ex(200:220)  = I_const;
[Vt,nt,ht,mt] = HH(V0,C_m,g_K,g_Na,g_L,E_Na,E_l,E_K,I_ex,dt);

t = 0:dt:(length(Vt) - 1) * dt;
f6 = figure('WindowState','maximized');
sgtitle(' 3 pulses in  HH model - refactoric period demonstarte')
subplot(2,1,1)
plot(t*1000,Vt*1000)
title('Voltage over time')
xlabel('time [msec]')
ylabel('Voltage [mV]')
yline(-65,'--','V-rest -65 [mV]','Color','red')
subplot(2,1,2)
plot(t*1000,I_ex*10^6)
title('Current over time')
xlabel('time [msec]')
ylabel('Current [\muA]')

%% over coming the refactoric period  
%we can overcome the refactoric period a growing magnitudes of currents and

I_growing = linspace(15e-6,500e-6,3); % current strength 10[uA]
I_ex=zeros(1,1000);
I_ex(100:130)  = I_growing(1); 
I_ex(160:190)  = I_growing(2);
I_ex(220:250)  = I_growing(3);
[Vt,nt,ht,mt] = HH(V0,C_m,g_K,g_Na,g_L,E_Na,E_l,E_K,I_ex,dt);

t = 0:dt:(length(Vt) - 1) * dt;
f7 = figure('WindowState','maximized');
sgtitle('3 growing currents to overcome refactoric period in HH model')
subplot(2,1,1)
plot(t*1000,Vt*1000)
title('Voltage over time')
xlabel('time [msec]')
ylabel('Voltage [mV]')
yline(-65,'--','V-rest -65 [mV]','Color','red')
subplot(2,1,2)
plot(t*1000,I_ex*10^6)
title('Current over time')
xlabel('time [msec]')
ylabel('Current [\muA]')

f8 = figure('WindowState','maximized');
sgtitle("h,m,n change in time - growing currents to overcome refactoric period ")
hold on
plot(t(1:end-1)*1000,mt)
plot(t(1:end-1)*1000,ht)
plot(t(1:end-1)*1000,nt)
xlabel("time [msec]")
ylabel("h,m,n value ")
legend('m','h','n')
hold off

