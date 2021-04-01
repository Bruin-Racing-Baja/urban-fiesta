load('comparison_data.mat');

figure(1);
subplot(221);
plot(t, r_P, t, r_esc);
hline([cvt_low, cvt_high], 'k--');
grid on;
xlabel('time [s]');
title('cvt ratio');

subplot(223);
plot(t, eg_rpm_P, t, eg_rpm_esc);
grid on;
xlabel('time [s]');
title('engine speed');
ylabel('[rpm]');

subplot(224);
plot(t, vel_mph_P, t, vel_mph_esc);
grid on;
xlabel('time [s]');
title('wheel speed');
ylabel('[mph]');

subplot(222);
plot(t, u_P, t, u_esc);
hline([motor_max, -motor_max], 'k--');
grid on;
xlabel('time [s]');
title('motor speed');
ylabel('[rpm]');