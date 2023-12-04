clc
clear

% Define the impedance data
Z = [1 1 0 0.25;
     2 2 1 0.1;
     3 3 1 0.1;
     4 2 0 0.25;
     5 2 3 0.1];

% Get the size of the matrix Z
[m, ~] = size(Z);

% Initialize the bus impedance matrix
zbus = [];

% Initialize variable x
x = 0;

% Iterate through each row of Z
for i = 1:m
    % Get the current row index
    j = i;
    
    % Get the size of zbus matrix
    [r, c] = size(zbus);
    
    % Extract values from Z
    from = Z(i, 2);
    to = Z(i, 3);
    value = Z(i, 4);
    
    % Determine N and ref
    N = max(from, to);
    ref = min(from, to);
    
    % Update zbus matrix based on conditions
    if N > x && ref == 0
        zbus = [zbus zeros(r, 1); zeros(1, c) value];
        x = N;
        continue;
    end
    
    if N > x && ref ~= 0
        zbus = [zbus zbus(:, ref); zbus(ref, :) value + zbus(ref, ref)];
        x = N;
        continue;
    end
    
    if N <= x && ref == 0
        zbus = zbus - 1 / (zbus(N, N) + value) * zbus(:, N) * zbus(N, :);
        continue;
    end
    
    if N <= x && ref ~= 0
        zbus = zbus - 1 / (value + zbus(from, from) + zbus(to, to) - 2 * zbus(from, to)) ...
            * ((zbus(:, from) - zbus(:, to)) * (zbus(from, :) - zbus(to, :)));
        continue;
    end
end

% Display the final zbus matrix
disp('Final zbus matrix:');
disp(zbus);
