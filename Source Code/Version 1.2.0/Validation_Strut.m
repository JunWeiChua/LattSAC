% Sample validation cases (Strut Lattices).
clc; clear all; close all;
load('Strut Lattice.mat','unit_cell');
section = "Circle";
frequency = 100:10:6300;

cell_length = 4:0.5:8;
rel_density = 0.1:0.05:0.4;
num_samples = 4;
count = 0;

UC_val = [4 3 5 2 7; ...
		  5 6 3 7 1; ...
		  5 7 3 1 6; ...
		  6 3 5 2 1];
Lcell_val = [7.0 4.0 6.0 7.5 8.0; ...
			 7.5 4.5 6.0 5.5 4.0; ...
			 4.5 7.5 5.0 8.0 6.0; ...
			 4.0 6.0 5.5 4.5 6.5];
RD_val = [0.40 0.35 0.25 0.20 0.10; ...
		  0.30 0.35 0.25 0.40 0.10; ...
		  0.35 0.10 0.40 0.15 0.20; ...
		  0.10 0.25 0.20 0.30 0.35];
Nlayer_val = [2 4 2 2 2; ...
			  2 3 2 2 3; ...
			  3 2 3 2 2; ...
			  4 2 2 3 2];
SR_val = [1.0 0.5 0.5 0.1 0.9; ...
		  1.0 0.5 0.5 0.2 0.8; ...
		  1.0 0.5 0.5 0.8 0.2; ...
		  1.0 0.5 0.5 0.2 0.8];
layerType_val = [2 3 1; 3 1 2; 1 3 2; 3 1 2];

%% 3 layers in series, 1 homogeneous layer, 2 heterogeneous with 2 parts.
for idx_sample = 1:num_samples
    count = count + 1;
    sample{count} = Lattice('Circle',frequency);
    idx_cell = UC_val(idx_sample,:);
    Lcell = Lcell_val(idx_sample,:);
    RD = RD_val(idx_sample,:);
	SR = SR_val(idx_sample,:);
	layer_type = layerType_val(idx_sample,:);
    for idx_layer = 1:3
        layer = LattLayer(section,frequency);
        switch layer_type(idx_layer)
            case 1 % Homogeneous
                part = LattPartStrut(unit_cell(idx_cell(1)), ...
                    Lcell(1),RD(1), ...
                    section,30,30, ...
                    floor(16/Lcell(1)));
                layer.insertPart(part,1);
            case 2 % 2 Parts, each surface ratio 0.5
                for idx_part = 1:2
                    part = LattPartStrut(unit_cell(idx_cell(idx_part+1)), ...
                        Lcell(idx_part+1),RD(idx_part+1), ...
                        section,30,30, ...
                        floor(16/Lcell(idx_part+1)));
                    layer.insertPart(part,1/2);
                end
            case 3 % 2 Parts, surface ratio random
                for idx_part = 1:2
                    part = LattPartStrut(unit_cell(idx_cell(idx_part+3)), ...
                        Lcell(idx_part+3),RD(idx_part+3), ...
                        section,30,30, ...
                        floor(16/Lcell(idx_part+3)));
                    layer.insertPart(part,SR(idx_part+3));
                end
        end
        insertLayer(sample{count},layer,idx_layer);
    end
    sample{count}.updateThickness(1);
    calcTMM(sample{count});
    calcSAC(sample{count});
	fprintf('SAMPLE NUMBER %d\n',idx_sample);
    disp(sample{idx_sample})
end
save('Validation_Strut.mat','sample');



%% Plotting of SAC for heterogeneous strut lattices.
clc; clear all; close all;
load('Validation_Strut.mat');

% Import experimental data.
fprintf('Importing experimental data.\n');
num_cases = size(sample,2);
% Forward
for idx_sample = 1:num_cases
	filename = sprintf("Validation2_Sample%d.txt",idx_sample);
	file = fullfile(pwd,'Strut Lattice Validation','Validation SAC',filename);
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
	file = fullfile(pwd,'Strut Lattice Validation','Validation SAC',filename);
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

figure('Position', [100 100 700 700]);
color = [0.8 0 0;0 0 0.8;0 0.8 0;0.8 0.6 0;0.6 0 0.8;0 0.8 0.6];
line_style = ["-" "--" ":" "-."];
marker = ["o",'+','x','s',"diamond","pentagram","hexagram"];
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
	
	% print(strcat('Expt-',label(idx,:),'.tif'),'-dtiff','-r500');
	hold off;
end
close all;
% pause;

% Plot of Expt vs MMC Model.
figure('Position', [100 100 700 700]);
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
		'Color',color(1,:),'LineStyle',line_style(1),'LineWidth',3);
	hold on;
	
	% MMC Model
	plot(freq(f),alpha_MMC,'DisplayName','Mathematical Model', ...
		'Color',color(2,:),'LineStyle',line_style(2),'LineWidth',3);
	
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
		'Color',color(1,:),'LineStyle',line_style(1),'LineWidth',3);
	hold on;
	
	% MMC Model
	plot(freq(f),alpha_MMC,'DisplayName','Mathematical Model', ...
		'Color',color(2,:),'LineStyle',line_style(2),'LineWidth',3);

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
figure('Position', [100 100 700 700]);
x_pdf = [0:1:10]./100;
histogram(reshape(error,[],1),x_pdf,'Normalization','pdf');
hold on;

ax = gca;
ax.FontSize = 20;
ax.XLim = [0 10]./100;
ax.XTick = [0:2:10]./100;
ax.YLim = [0 60];
ax.YTick = 0:10:60;
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