clear variables
clear figure

lambdaDelta = importdata("lambda_delta.csv");
lambdaStart = importdata("lambda_start.csv");
spectra = importdata("spectra.csv");
starNames = importdata("star_names.csv");

lambdaPr = 656.28; % nm
speedOfLight = 299792.458; % km/s

num_stars = size(starNames, 1);
num_points = size(spectra, 1);

lambdaEnd = lambdaStart + (num_points - 1) * lambdaDelta;

lambda = (lambdaStart : lambdaDelta : lambdaEnd)';

[minIntensities, minIntencityIndices] = min(spectra);

z = lambda(minIntencityIndices) / lambdaPr - 1;
speed = z * speedOfLight;
movaway = starNames(speed > 0);

fg = figure;
set(fg, 'Visible', 'On');

hold on;
for i = 1:num_stars
  if (speed(i) > 0)
    plot(lambda, spectra(:,i), '-', 'LineWidth', 3);
  else
    plot(lambda, spectra(:,i), '--', 'LineWidth', 1);
  end
end
hold off;

title({'Спектры звезд', 'Баргатин Михаил, Б01-002'});
xlabel('\lambda, nm');
ylabel('I, erg/cm^2/s/A');
legend(starNames);
grid on;

saveas(fg, "спектры.png");