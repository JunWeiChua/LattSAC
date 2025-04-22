% Optimzation Program for Plate Lattices. (Validation)

clc; clear all; close all;
load('Optimization_Plate.mat');
% idx_chosen = [1 6 11 16];
idx_chosen = [5 9 11 19];
for idx_f = 1:size(x0_chosen,1)
	x0_chosen(idx_f,:) = param_chosen(idx_chosen(idx_f),:);
end
save('Optimization_Plate.mat');

clc; clear all; close all;
load('Unit Cell Architecture.mat');
load('Optimization_Plate.mat');
PlateLattList = cellArchList{2};

% Initalise constant parameters.
Type = ["Plate"; "Plate"];
Freq = 450:2.5:6400; % Whole frequency range.
CrossSection = "Circle";
SampleDiameter = 29;
Ht = 36; % Sample Height
N_layers = size(Type,1);

figure('Position', [100 100 660 660]);
color = [0.8 0 0;0 0 0.8;0 0.8 0;0.8 0.6 0];
line_style = ["-" "--" ":" "-."];
marker = ['o','x','+','s'];

labels = ["450 - 6300 Hz"; ...
		  "450 - 2000 Hz"; ...
		  "2000 - 4000 Hz"; ...
		  "4000 - 6300 Hz"];

rho0 = 1.225; % Air density, kg/m3
c0 = 343; % Sound speed, m/s
Z0 = complex(rho0*c0); % Air impedance
Sample_Plate = cell(size(x0_chosen,1),1);

for idx = 1:size(x0_chosen,1)
    % Create lattice and calculate SAC.
	x0 = x0_chosen(idx,:);
	x0 = reshape(x0,[],N_layers)';
	
	UC = x0(:,1);
	CS = x0(:,2);
	RD = x0(:,3);
	Hole = x0(:,4);
	Nz = x0(:,5);
	
	fprintf("Chosen Point %d:\n",idx);
	Sample = Lattice('Circle',Freq);
	for idx_layer = 1:N_layers
		Cell = cellArchLib.findCellArch(Type(idx_layer),PlateLattList(round(UC(idx_layer))));
		Part = LattPartPlate(Cell.Name,CS(idx_layer),RD(idx_layer), ...
			Hole(idx_layer),CrossSection, ...
			SampleDiameter,SampleDiameter,Nz(idx_layer));
		Layer = LattLayer(CrossSection,Freq);
		Layer.insertPart(Part,1);
		Sample.insertLayer(Layer,idx_layer);
	end
	Sample.updateThickness(1);
	Sample.calcTMM();
	Sample.calcSAC();
	Sample.disp();
	alpha = Sample.SAC;
	Sample_Plate{idx,1} = Sample;
	
	% Import experiment data.
	filename = sprintf("Validation_BSWA SW4601-Sample%d.2-1.txt",idx);
	file = fullfile(pwd,'Validation',filename);
	try
		opts = detectImportOptions(file);
		Data = readtable(file,opts);
		freq = table2array(Data(:,1));
		z_real = table2array(Data(:,6));
		z_imag = table2array(Data(:,7));
		
		% exclude = (freq>1100 & freq<1400) | (freq>1700 & freq<2000) | ...
			% (freq>2100 & freq<2200);
		% if ~isempty(exclude)
			% z_real(exclude) = NaN;
			% z_imag(exclude) = NaN;
		% end
		z_real = smoothdata(z_real,'gaussian',150,'includenan');
		% z_real = fillmissing(z_real,'pchip','EndValues','nearest');
		z_real = smooth(z_real);
		
		z_imag = smoothdata(z_imag,'gaussian',150,'includenan');
		% z_imag = fillmissing(z_imag,'pchip','EndValues','nearest');
		z_imag = smooth(z_imag);
		
		Zs = Z0*(z_real + 1i*z_imag);
		SAC_expt = 1-abs((Zs-Z0)./(Zs+Z0)).^2;
		
		plot(freq,SAC_expt,'DisplayName','Experiment', ...
			'Color',color(1,:),'LineStyle',line_style(1),'LineWidth',3);
		hold on;
		plot(Freq,alpha,'DisplayName','Mathematical Model', ...
			'Color',color(2,:),'LineStyle',line_style(2),'LineWidth',3);
		hold on;
		error(idx,:) = mean(abs(SAC_expt-alpha));
	
		ax = gca;
		ax.FontSize = 20;
		ax.XLim = [450 6300];
		% switch idx
			% case 1
				% ax.XLim = [450 6300];
				% ax.XTick = 0:1000:6300;
			% case 2
				% ax.XLim = [450 2000];
				% ax.XTick = 0:500:6300;
			% case 3
				% ax.XLim = [2000 4000];
				% ax.XTick = 0:500:6300;
			% case 4
				% ax.XLim = [4000 6300];
				% ax.XTick = 0:500:6300;
		% end
		ax.YLim = [0 1];
		
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
		legend('FontSize',20);
		legend('boxoff');

		exportgraphics(gca,sprintf('Validation_Plate_%s_Full.emf',labels(idx)),... 
			'Resolution',1000,'ContentType','vector',...
			'BackgroundColor','none');
		print(sprintf('Validation_Plate_%s_Full.tif',labels(idx)),'-dtiff','-r500');
		% print(sprintf('Validation_Plate_%s_Partial.tif',labels(idx)),'-dtiff','-r500');
		hold off;
	catch
		fprintf(strcat("Unable to import ",filename,".\n"));
	end
end

Freq = 100:10:6300; % Whole frequency range.
CrossSection = "Circle";
for idx = 1:size(x0_chosen,1)
    % Create lattice and calculate SAC.
	x0 = x0_chosen(idx,:);
	x0 = reshape(x0,[],N_layers)';
	
	UC = x0(:,1);
	CS = x0(:,2);
	RD = x0(:,3);
	Hole = x0(:,4);
	Nz = x0(:,5);
	
	Sample = Lattice('Circle',Freq);
	for idx_layer = 1:N_layers
		Cell = cellArchLib.findCellArch(Type(idx_layer),PlateLattList(round(UC(idx_layer))));
		Part = LattPartPlate(Cell.Name,CS(idx_layer),RD(idx_layer), ...
			Hole(idx_layer),CrossSection, ...
			SampleDiameter,SampleDiameter,Nz(idx_layer));
		Layer = LattLayer(CrossSection,Freq);
		Layer.insertPart(Part,1);
		Sample.insertLayer(Layer,idx_layer);
	end
	Sample.updateThickness(1);
	Sample.calcTMM();
	Sample.calcSAC();
	alpha = Sample.SAC;
	Sample_Plate{idx,1} = Sample;
end
save('Validation_Plate.mat','Sample_Plate');

% Function to maximise calculated SAC for a particular frequency range.
function mean_SAC = SAC_Maximise(param,Type,Freq,CrossSection,SampleDiameter,Ht)
	% ** Plate lattices only.
	%
	% param:
	% UC = unit cell (Integer) (1 <= x <= 3)
	% CS = cell size (4<= x <= 8)
	% RD = relative density (0.2 <= x <= 0.4)
	% Hole = hole precent (0.3 <= x <= 0.6)
	% Nz = Number of layers (Integer) (x >= 1)
	% 
	% Constants:
	% Type: Unit Cell Types for each layer. (Nx1 vector)
	% Freq
	% CrossSection
	% SampleDiameter
	% Ht = Height Limit
	
	N_layers = size(Type,1);
	param = reshape(param,[],N_layers)';
	UC = param(:,1);
	CS = param(:,2);
	RD = param(:,3);
	Hole = param(:,4);
	Nz = param(:,5);
	FreqFull = 450:2.5:6400;
	
	load('Unit Cell Architecture.mat');
	PlateLattList = cellArchList{2};
	
	% Create lattice and calculate SAC.
	Sample = Lattice('Circle',FreqFull);
	for idx_layer = 1:N_layers
		Cell = cellArchLib.findCellArch(PlateLattList(round(UC(idx_layer))),Type(idx_layer));
		Part = LattPartPlate(Cell.Name,CS(idx_layer),RD(idx_layer), ...
			Hole(idx_layer),CrossSection, ...
			SampleDiameter,SampleDiameter,Nz(idx_layer));
		Thickness(idx_layer,:) = Part.UnitCell.t_plate;
		Layer = LattLayer(CrossSection,FreqFull);
		Layer.insertPart(Part,1);
		Sample.insertLayer(Layer,idx_layer);
	end
	Sample.updateThickness(1);
	Sample.calcTMM();
	Sample.calcSAC();
	alpha = Sample.SAC;
	freq_target = find(FreqFull>=Freq(1) & FreqFull<=Freq(end));
	
	% Optimise for target freq range only.
	score = mean(alpha(freq_target))*100;
	mean_SAC.Fval = 1/score;
	
	% Optimise for whole freq range, with emphasis on target freq range.
	% alpha_factor = 10;
	% alpha(freq_target) = alpha(freq_target)*alpha_factor;
	% alpha_max = (length(freq_target)*alpha_factor+(length(FreqFull)-length(freq_target))*1)/length(FreqFull);
	% score = 100*mean(alpha)/alpha_max;
	% mean_SAC.Fval = 1/score;
	
	% Inequality constraints
	mean_SAC.Ineq(1) = sum(CS.*Nz) - Ht; % Sample Height
	for idx_layer = 1:N_layers
		HoleSize = CS(idx_layer)*Hole(idx_layer);
		switch round(UC(idx_layer))
			case 1 % SC-Plate
				mean_SAC.Ineq(idx_layer+1) = 1.0 - (HoleSize-Thickness(idx_layer,:));
			case 2 % BCC-Plate
				mean_SAC.Ineq(idx_layer+1) = 1.6 - (HoleSize-Thickness(idx_layer,:));
			case 3 % FCC-Plate
				mean_SAC.Ineq(idx_layer+1) = 1.2 - (HoleSize-Thickness(idx_layer,:));
		end
	end
	
end