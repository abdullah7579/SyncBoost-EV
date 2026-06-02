% Defined constants
Vc = 48;
D = 0.75;
L = 7.5e-6;
C = 58.59e-6;
R = 5.3;

% Numerator and Denominator based on reference image
term1 = L / (R * (1-D)^2);
term2 = (L * C) / (1-D)^2;

num = 192 * [-term1, 1]; % Distributed negative sign
den = [term2, term1, 1];

G_plant = tf(num, den);

% Tune PI controller for stability
% Target crossover frequency should be < 1/10th of RHP zero frequency
f_rhp = 1 / (2 * pi * term1); % ~7 kHz
opts = pidtuneOptions('PhaseMargin', 60);
C_pi = pidtune(G_plant, 'PI', 2 * pi * (f_rhp / 5), opts);

fprintf('Calculated Kp: %f\n', C_pi.Kp);
fprintf('Calculated Ki: %f\n', C_pi.Ki);