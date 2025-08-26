% ADD_NOISE_AND_PLOT_DOD
% Apply distance-dependent noise model to simulated fluence data and plot
% resulting change in optical density (ΔOD) from the fetal pulsation.
%
% This script:
%   1. Loads mesh information and example simulated fluence data.
%   2. Fits a one-term exponential function to model noise vs. source-detector distance.
%   3. Applies random noise multiple times, averages results, and computes ΔOD.
%   4. Plots clean vs. noisy ΔOD at a selected wavelength.
%
% Requirements:
%   - fit_one_term_exponential.m (utility function)
%   - Pre-generated mesh_info.mat and example_fluence_data.mat
%
% Author: Jingyi Wu (2025)

clear
close all

%% Load mesh information
load('mesh_info/mesh_info.mat');

num_sor = length(sources);          % number of sources
num_det = length(detectors);        % number of detectors
num_ch  = num_sor * num_det;        % total number of source-detector channels

wavelengths = [730,750,770,790,800,810,830,850];
num_wl = length(wavelengths);

%% Load simulated fluence data
% Fluence data has two states: diastole (1) and systole (2)
load('example_fluence_data.mat');
Phi_all = fluence_data.fluence_big_det;
Phi_dia = squeeze(Phi_all(:,:,1));   % diastolic fluence
Phi_sys = squeeze(Phi_all(:,:,2));   % systolic fluence

%% Generate noise model as function of SD distance
% Fit exponential curve to approximate increasing noise with distance
x_in = [10, 60, 120];               % SD distances
y_in = [0.25, 1, 4] / 100;          % corresponding noise levels
[a, b] = fit_one_term_exponential(x_in, y_in, 1);

%% Randomly generate noise and average
rng('default');
rng(09123);                         % fixed seed for reproducibility
num_noises = 480;                   % number of noise

Phi_dia_noisy_all = zeros([size(Phi_dia), num_noises]);
Phi_sys_noisy_all = zeros([size(Phi_sys), num_noises]);

for idx_noises = 1:num_noises
    for idx_ch = 1:num_ch
        std_ch = a * exp(b * distance_surface(idx_ch)); % noise std for this channel
        noises = normrnd(0, std_ch, [num_wl, 2]);       % two columns: dia & sys
        Phi_dia_noisy_all(:, idx_ch, idx_noises) = Phi_dia(:, idx_ch) .* (1 + noises(:,1));
        Phi_sys_noisy_all(:, idx_ch, idx_noises) = Phi_sys(:, idx_ch) .* (1 + noises(:,2));
    end
end

% Compute ΔOD: clean vs noisy (averaged across realizations)
dOD_all_clean = log(Phi_dia ./ Phi_sys);
dOD_all_noisy = abs(log(mean(Phi_dia_noisy_all, 3) ./ mean(Phi_sys_noisy_all, 3)));

%% Plot ΔOD at one wavelength
idx_wl = 1; % index of wavelength to plot

figure; set(gcf,'Position',[0 0 500 500]); hold on;
scatter(distance_surface, dOD_all_clean(idx_wl,:), 'bo', 'fill');
scatter(distance_surface, dOD_all_noisy(idx_wl,:), 'ro', 'fill');
title(['\DeltaOD vs SD Distance, ', num2str(wavelengths(idx_wl)), ' nm']);
ylabel('\DeltaOD');
xlabel('SD Distance (mm)');
legend('Clean','Noisy','FontSize',15,'location','northwest','box','off');
xlim([0 120]);
axis square
set(gca,'FontWeight','bold','FontSize',15,'LineWidth',1.1,'FontName','Arial');
