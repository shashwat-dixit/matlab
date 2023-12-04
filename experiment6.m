z = 0.1062 + 0.1108j;
y = 0;
vs = 33000;
vsph = vs / sqrt(3); % if the line is 3 phase
is = 65.0944 - 48.8208i;

len = input('enter the length in KM: ');

if len <= 80
    x = 1;
elseif len <= 240
    x = 2;
else
    x = 3;
end

Z = z * len;
Y = y * len;

switch x
    case 1
        A = 1;
        B = Z;
        C = 0;
        D = A;
    case 2
        p = input('enter 1 for PI and 2 for T: ');
        A = 1 + (Y * Z) / 2;
        D = A;
        if p == 1
            B = Z;
            C = Y * (1 + (Z * Y) / 4);
        else
            C = Y;
            B = Z * (1 + (Z * Y) / 4);
        end
    case 3
        A = cosh(sqrt(Y * Z));
        B = sqrt(Z / Y) * sinh(sqrt(Y * Z));
        C = sqrt(Y / Z) * sinh(sqrt(Y * Z));
        D = A;
end

ABCD = A * D - B * C;
vr = D * vsph - B * is;
ir = -C * vsph + A * is;
spower = 3 * vsph * conj(is);
rpower = 3 * vr * conj(ir);
efficiency = real(rpower) / real(spower) * 100;
regulation = (abs(vsph) / abs(A) - abs(vr)) / abs(vr) * 100;

fprintf('abcd constants of transmission line are\n');
fprintf('A=%f+j%f\n', real(A), imag(A));
fprintf('B=%f+j%f\n', real(B), imag(B));
fprintf('C=%f+j%f\n', real(C), imag(C));
fprintf('D=%f+j%f\n', real(D), imag(D));
fprintf('receivingend vr=%f+j%f\n', real(vr), imag(vr));
fprintf('receiving end current ir=%f+j%f\n', real(ir), imag(ir));
fprintf('efficiency=%f\n', efficiency);
fprintf('reg=%f\n', regulation);
fprintf('ad-bc=%f\n', ABCD);
