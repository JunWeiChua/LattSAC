%% Program 1: Import of SAC Experment Data.

clc; clear all; close all;

load('Validation.mat');

% Import experimental data.
fprintf('Importing experimental data.\n');
num_cases = size(sample,2);
% Forward
for idx_sample = 1:num_cases
	filename = sprintf("Validation2_Sample%d.txt",idx_sample);
	file = fullfile(pwd,'Validation SAC',filename);
	try
		opts = detectImportOptions(file);
		Data = readtable(file,opts);
		freq = table2array(Data(:,1));
		SAC_expt(:,idx_sample) = table2array(Data(:,2));
		label(idx_sample,:) = sprintf("Validation2_Sample%d",idx_sample);
		fprintf(strcat(filename," imported successfully.\n"));
	catch
		fprintf(strcat(filename," does not exist.\n"));
	end
end

% Reverse
for idx_sample = 1:num_cases
	filename = sprintf("Validation2_Sample%dR.txt",idx_sample);
	file = fullfile(pwd,'Validation SAC',filename);
	try
		opts = detectImportOptions(file);
		Data = readtable(file,opts);
		freq = table2array(Data(:,1));
		SAC_expt(:,num_cases+idx_sample) = table2array(Data(:,2));
		label(num_cases+idx_sample,:) = ...
			sprintf("Validation2_Sample%d_Reverse",idx_sample);
		fprintf(strcat(filename," imported successfully.\n"));
	catch
		fprintf(strcat(filename," does not exist.\n"));
	end
end

% Refine the experimental sound absorption data.
fprintf('Refining the experimental sound absorption data.\n');
SAC_expt_raw = SAC_expt;

figure('Position', [100 100 660 660]);
color = [0 0.8 0;0.8 0 0;0 0 0.8;0.8 0.6 0];
line_style = ["--" ":" "-" "-."];
marker = ['o','+','x','s'];
for idx = 1:size(SAC_expt,2)
	alpha_expt = SAC_expt(:,idx);
	
	% if ismember(idx_sample,[1 2 3 4 7 8])
		% alpha_expt(freq>1200 & freq<1400) = NaN;
	% end
	alpha_expt(freq>1900 & freq<2300) = NaN;
	% if idx_sample == 7
		% alpha_expt(freq>3800 & freq<4200) = NaN;
	% end
	SAC_expt(:,idx) = smoothdata(alpha_expt,'gaussian',150,'includenan');
	SAC_expt(:,idx) = fillmissing(SAC_expt(:,idx),'pchip','EndValues','nearest');
	SAC_expt(:,idx) = smooth(SAC_expt(:,idx));
	
	plot(freq,SAC_expt_raw(:,idx),'DisplayName','Raw','LineWidth',2);
	hold on;
	plot(freq,SAC_expt(:,idx),'DisplayName','Smoothed','LineWidth',2);
	
	ax = gca;
	ax.FontSize = 20;
	ax.XLim = [1000 6300];
	ax.YLim = [0 1];
	ax.XTick = 1000:1000:6300;
	ax.YTick = 0:0.2:1.0;
	ax.XLabel.String = "Frequency (Hz)";
	ax.YLabel.String = "Absorption Coefficient \alpha";
	ax.XLabel.FontSize = 24;
	ax.YLabel.FontSize = 24;
	ax.XLabel.FontWeight = 'bold';
	ax.YLabel.FontWeight = 'bold';
	ax.Box = 'on';
	ax.LineWidth = 3;
	legend('Location','southeast','NumColumns',1);
	legend('FontSize',16);
	legend('boxoff');
	
	print(strcat('Expt-',label(idx,:),'.tif'),'-dtiff','-r500');
	hold off;
end
close all;
% pause;

% Plot of Expt vs MMC Model.
figure('Position', [100 100 660 660]);
% Forward
for idx_sample = 1:num_cases
	f = find(freq >= 1000 & freq <= 6300);
	alpha_expt = SAC_expt(f,idx_sample);
	latt = sample{idx_sample};
	latt.changeFreq(freq(f));
	latt.calcTMM();
	latt.calcSAC();
	alpha_MMC = latt.SAC;
	
	% Experiment
	plot(freq(f),alpha_expt,'DisplayName','Experiment', ...
		'Color',color(2,:),'LineStyle',line_style(2),'LineWidth',3);
	hold on;
	
	% MMC Model
	plot(freq(f),alpha_MMC,'DisplayName','MMC Model', ...
		'Color',color(3,:),'LineStyle',line_style(3),'LineWidth',3);
	
	error(idx_sample,:) = mean(abs(alpha_expt-alpha_MMC));
	
	ax = gca;
	ax.FontSize = 20;
	ax.XLim = [1000 6300];
	ax.YLim = [0 1];
	ax.XTick = 1000:1000:6300;
	ax.YTick = 0:0.2:1.0;
	ax.XLabel.String = "Frequency (Hz)";
	ax.YLabel.String = "Absorption Coefficient \alpha";
	ax.XLabel.FontSize = 24;
	ax.YLabel.FontSize = 24;
	ax.XLabel.FontWeight = 'bold';
	ax.YLabel.FontWeight = 'bold';
	ax.Box = 'on';
	ax.LineWidth = 3;
	legend('Location','northeast','NumColumns',1);
	legend('FontSize',24);
	legend('boxoff');
	
	print(strcat(label(idx_sample,:),'.tif'),'-dtiff','-r500');
	hold off;
end

% Reverse
for idx_sample = 1:num_cases
	f = find(freq >= 1000 & freq <= 6300);
	alpha_expt = SAC_expt(f,idx_sample+num_cases);
	latt = sample{idx_sample}.copyLatt();
	latt.reverseLatt();
	latt.updateThickness(1);
	latt.changeFreq(freq(f));
	latt.calcTMM();
	latt.calcSAC();
	alpha_MMC = latt.SAC;
	
	% Experiment
	plot(freq(f),alpha_expt,'DisplayName','Experiment', ...
		'Color',color(2,:),'LineStyle',line_style(2),'LineWidth',3);
	hold on;
	
	% MMC Model
	plot(freq(f),alpha_MMC,'DisplayName','MMC Model', ...
		'Color',color(3,:),'LineStyle',line_style(3),'LineWidth',3);
	
	error(idx_sample+num_cases,:) = mean(abs(alpha_expt-alpha_MMC));
	
	ax = gca;
	ax.FontSize = 20;
	ax.XLim = [1000 6300];
	ax.YLim = [0 1];
	ax.XTick = 1000:1000:6300;
	ax.YTick = 0:0.2:1.0;
	ax.XLabel.String = "Frequency (Hz)";
	ax.YLabel.String = "Absorption Coefficient \alpha";
	ax.XLabel.FontSize = 24;
	ax.YLabel.FontSize = 24;
	ax.XLabel.FontWeight = 'bold';
	ax.YLabel.FontWeight = 'bold';
	ax.Box = 'on';
	ax.LineWidth = 3;
	legend('Location','northeast','NumColumns',1);
	legend('FontSize',24);
	legend('boxoff');
	
	print(strcat(label(idx_sample+num_cases,:),'.tif'),'-dtiff','-r500');
	hold off;
end
close all;
% pause;

% Plot of Errors
figure('Position', [100 100 660 660]);
x_pdf = [0:1:10]./100;
histogram(reshape(error,[],1),x_pdf,'Normalization','pdf');
hold on;

ax = gca;
ax.FontSize = 20;
ax.XLim = [0 10]./100;
ax.XTick = [0:2:10]./100;
ax.YLim = [0 30];
ax.YTick = 0:5:30;
ax.XLabel.String = "Mean Absolute Error";
ax.YLabel.String = "Frequency (%)";
ax.XLabel.FontSize = 24;
ax.YLabel.FontSize = 24;
ax.XLabel.FontWeight = 'bold';
ax.YLabel.FontWeight = 'bold';
ax.Box = 'on';
ax.LineWidth = 3;

% Saves graph as .png file. Open them up to see.
print("error_MMC_validation2.tif",'-dtiff','-r500');
hold off;