function [a, b] = fit_one_term_exponential(x, y, plt_fig)
%Fit data with a single-term exponential model.
%
%   [a, b] = fit_one_term_exponential(x, y, plt_fig) fits the data points
%   (x, y) using a one-term exponential model of the form:
%
%       y = a * exp(b * x)
%
%   Inputs:
%       x       - Vector of independent variable values.
%       y       - Vector of dependent variable values (same length as x).
%       plt_fig - Boolean flag (1 = plot the fit, 0 = no plot).
%
%   Outputs:
%       a - Coefficient "a" of the exponential fit.
%       b - Coefficient "b" of the exponential fit.
%
%   Notes:
%       - Uses MATLAB's built-in `fit` function with fittype 'exp1'.
%       - Displays fit results and goodness-of-fit metrics in the console.
%       - If plt_fig is set to 1, the function generates a figure showing
%         both the raw data and the fitted curve.
%
%   Example:
%       x = (0:0.1:10)';
%       y = 5*exp(-0.3*x) + 0.1*randn(size(x));
%       [a, b] = fit_one_term_exponential(x, y, 1);
%
%   Author: Jingyi Wu (2025)

    % Define and perform exponential fit
    ft = fittype('exp1');
    [fitresult, gof] = fit(x(:), y(:), ft);

    % Extract coefficients
    a = fitresult.a;
    b = fitresult.b;

    % Display fit summary
    disp('One-term exponential fit (exp1):');
    disp(fitresult);
    disp(gof);

    % Plot data and fit if requested
    if plt_fig == 1
        x_fit = linspace(min(x), max(x), 100);
        y_fit = a * exp(b * x_fit);

        figure;
        plot(x, y, 'bo', 'DisplayName', 'Data');
        hold on;
        plot(x_fit, y_fit, 'r-', 'LineWidth', 2, 'DisplayName', 'exp1 Fit');
        xlabel('x');
        ylabel('y');
        title('One-term Exponential Fit');
        legend('show');
        grid on;
        hold off;
    end
end
