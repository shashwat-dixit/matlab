clc
clear
n = 3;
v = [1 1 1];
ybus = [70-90j -20+40j -50+50j;
        -20+40j 43.08-55.39j 0+0j;
        -50+50j 0+0j 75-75j];
y = abs(ybus);
yn = angle(ybus);
v = abs(v);
vn = angle(v);
J1 = zeros(n, n);
J2 = zeros(n, n);
J3 = zeros(n, n);
J4 = zeros(n, n);
i = 2; % bus 1 is taken as the slack bus.
while i <= n
    for j = 1:n
        if i == j
            continue;
        end
        J2(i, i) = J2(i, i) + v(j) * y(i, j) * cos(yn(i, j) - vn(i) + vn(j));
        J2(i, j) = -v(i) * v(j) * y(i, j) * sin(yn(i, j) - vn(i) + vn(j));
        J3(i, i) = J3(i, i) + v(j) * y(i, j) * sin(yn(i, j) - vn(i) + vn(j));
        J3(i, j) = v(i) * v(j) * y(i, j) * cos(yn(i, j) - vn(i) + vn(j));
        J4(i, i) = J4(i, i) + v(j) * y(i, j) * cos(yn(i, j) - vn(i) + vn(j));
        J4(i, j) = -v(i) * v(j) * y(i, j) * sin(yn(i, j) - vn(i) + vn(j));
    end
    i = i + 1;
end

J11 = J1(2:n, 2:n);
J22 = J2(2:n, 2:n);
J33 = J3(2:n, 2:n);
J44 = J4(2:n, 2:n);
Jacobian = [J11 J22; J33 J44];
nl = n - 1 + n - 1;
for i = 1:nl
    for k = 1:nl
        fprintf('%7.2f\t\t', Jacobian(i, k));
    end
    fprintf('\n');
end
