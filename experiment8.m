clc
clear

p = 0.9;
e1 = 1.1;
e2 = 1.0;
m = 0.016;
x0 = 0.45;
x1 = 1.25;
x2 = 0.55;
tfc = 0.42;
pmo = (e1 * e2) / x0;
pm1 = (e1 * e2) / x1;
pm2 = (e1 * e2) / x2;
w = 0;
t = 0;
d = asin(p / pmo);
do = d;

for i = 1:20
    dg(i) = d * 180 / pi;

    if (t < tfc)
        pm = pm1;
    elseif (t >= tfc)
        pm = pm2;
    end

    k1(i) = w * 0.05;
    l1(i) = (p - pm * sin(d)) * 0.05 / m;
    k2(i) = (w + 0.5 * l1(i)) * 0.05;
    l2(i) = (p - pm * sin(d + 0.5 * k1(i))) * 0.05 / m;
    k3(i) = (w + 0.5 * l2(i)) * 0.05;
    l3(i) = (p - pm * sin(d + 0.5 * k2(i))) * 0.05 / m;
    k4(i) = (w + l3(i)) * 0.05;
    l4(i) = (p - pm * sin(d + k3(i))) * 0.05 / m;

    deld = (k1(i) + 2 * k2(i) + 2 * k3(i) + k4(i)) / 6;
    delw = (l1(i) + 2 * l2(i) + 2 * l3(i) + l4(i)) / 6;

    d = d + deld;
    w = w + delw;
    t = t + 0.05;
end

t = 0.00:0.05:0.95;
plot(t, dg);
grid on;
xlabel('time in sec');
ylabel('torque angle delta in degrees');
title('Plot of swing curve');

dmax = pi - asin(p / pm2);
cosdcr = (p * (dmax - do) - pm1 * cos(do) + pm2 * cos(dmax)) / (pm2 - pm1);
dcr = acos(cosdcr) * 180 / pi;
