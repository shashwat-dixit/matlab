clc
clear

p = 48;
pf = 0.8;
vt = 34.64;
xd = 13.5;
xq = 9.333;
vt_ph = vt * 1000 / sqrt(3);
pf_a = acos(pf);
q = p * tan(pf_a);
I = (p - 1j * q) * 1000000 / (3 * vt_ph);
delta = 0:1:180;
delta_rad = delta * (pi / 180);

figure; % Create a new figure

if xd == xq
    % non-salient pole sync motor
    ef = vt_ph + (1j * I * xq);
    efmag = abs(ef);
    reg = ((efmag - abs(vt_ph)) / abs(vt_ph)) * 100;
    power_non = 3 * efmag * vt_ph * sin(delta_rad) / xd;
    plot(delta, power_non);
    xlabel('delta(deg)');
    ylabel('3phase power(MW)');
    title('Plot of power angle curve for non-salient pole syn m/c');
    legend('Non-salient power');
    grid on;
end

if xd ~= xq
    % salient pole motor
    del = atan((xq * abs(I) * pf) / (vt_ph + xq * abs(I) * sin(pf_a)));
    theta = del + pf_a;
    id_mag = abs(I) * sin(theta);
    ef_mag = vt_ph * cos(del) + id_mag * xd;
    reg = ((ef_mag - abs(vt_ph)) / abs(vt_ph)) * 100;
    real_p = ((ef_mag * vt_ph * sin(delta_rad) / xd) * 3) / 10^6;
    reluct_p = (vt_ph^2 * (xd - xq) * sin(2 * delta_rad) / (2 * xd * xq)) * 3 / 10^6;
    power_salient = real_p + reluct_p;
    
    figure; % Create another new figure
    plot(delta, power_salient, 'b', 'DisplayName', 'Total Power');
    hold on;
    plot(delta, reluct_p, 'r', 'DisplayName', 'Reluctance Power');
    hold on;
    plot(delta, real_p, 'g', 'DisplayName', 'Real Power');
    xlabel('delta(deg)');
    ylabel('3phase power(MW)');
    title('Plot of power angle curve for salient pole syn m/c');
    legend('Total Power', 'Reluctance Power', 'Real Power');
    grid on;
end
