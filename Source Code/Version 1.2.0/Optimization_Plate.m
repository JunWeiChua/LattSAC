% Optimzation Program for Plate Lattices.

% clc; clear all; close all;

% % Initalise constant parameters.
% Type = ["Plate"; "Plate"];
% Freq = {450:10:6300; ...
		% 450:10:2000; ...
		% 2000:10:4000; ...
		% 4000:10:6300}; % Maximise SAC for these frequency ranges.
% CrossSection = "Circular";
% SampleDiameter = 29;
% Ht = 36; % Sample Height
% N_layers = size(Type,1);

% load('Optimization_Plate_.mat','x0_chosen');

% num_iter = 5;
% count = 0;
% for idx_f = 1:length(Freq)
	% count = count + 1;
	% param_chosen(count,:) = x0_chosen(idx_f,:);
	% for iter = 2:num_iter
		% % Create function handles to the objective functions.
		% objconstr = @(param)SAC_Maximise(param,Type,Freq{idx_f},CrossSection,SampleDiameter,Ht);

		% % Constraints.
		% A = [];
		% b = [];
		% Aeq = [];
		% beq = [];
		% lb = [];
		% ub = [];
		% intcon = [];

		% for idx = 1:size(Type,1)
			% lb = [lb; [1;4.0;0.2;0.3;2]];
			% ub = [ub; [3;8.0;0.4;0.6;10]];
			% intcon = [intcon [5*(idx-1)+1 5*(idx)]];
		% end

		% options = optimoptions('surrogateopt','PlotFcn','surrogateoptplot',...
			% 'InitialPoints',[],'MaxFunctionEvaluations',200);

		% [x,fval,exitflag,output] = surrogateopt(objconstr,lb,ub,intcon,A,b,Aeq,beq,options)
		% count = count + 1;
		% param_chosen(count,:) = x;
	% end
% end
% save('Optimization_Plate.mat');
% pause;

load('Unit Cell Architecture.mat');
load('Optimization_Plate.mat');
PlateLattList = cellArchList{2};

color = [0 0.8 0;0.8 0 0;0 0 0.8;0.8 0.6 0];
line_style = ["--" ":" "-" "-."];
marker = ['o','+','x','s'];

labels = ["450 - 6300 Hz"; ...
		  "450 - 2000 Hz"; ...
		  "2000 - 4000 Hz"; ...
		  "4000 - 6300 Hz"];

rho0 = 1.225; % Air density, kg/m3
c0 = 343; % Sound speed, m/s
Z0 = complex(rho0*c0); % Air impedance
Freq = 450:2.5:6400;

figure('Position', [100 100 700 600]);
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
	% Create lattice and calculate SAC.
	Sample = Lattice('Circle',Freq);
	for idx_layer = 1:N_layers
		Cell = cellArchLib.findCellArch(PlateLattList(round(UC(idx_layer))),Type(idx_layer));
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
	plot(Freq,alpha,'DisplayName',labels(idx), ...
		'Color',color(mod(idx,4)+1,:),'LineStyle',line_style(mod(idx,3)+1),'LineWidth',3);
	hold on;
end
ax = gca;
ax.FontSize = 20;
ax.XLim = [450 6300];
ax.YLim = [0 1];
ax.XTick = 0:1000:6300;
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

print('Optimization_Plate.tif','-dtiff','-r500');
hold off;

clc;
figure('Position', [100 100 700 600]);
for idx_f = 1:size(x0_chosen,1)
	fprintf("Frequency Range %d:\n",idx_f);
	for iter = 1:num_iter
		fprintf("Iter %d:\n",iter);
		% Create lattice and calculate SAC.
		x0 = param_chosen(5*(idx_f-1)+iter,:);
		x0 = reshape(x0,[],N_layers)';
		
		UC = x0(:,1);
		CS = x0(:,2);
		RD = x0(:,3);
		Hole = x0(:,4);
		Nz = x0(:,5);
		
		% Create lattice and calculate SAC.
		Sample = Lattice('Circle',Freq);
		for idx_layer = 1:N_layers
			Cell = cellArchLib.findCellArch(PlateLattList(round(UC(idx_layer))),Type(idx_layer));
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
		plot(Freq,alpha,'DisplayName',sprintf('Iter %d',iter), ...
			'Color',color(mod(iter,4)+1,:),'LineStyle',line_style(mod(iter,3)+1),'LineWidth',3);
		hold on;
		mean_alpha(5*(idx_f-1)+iter,:) = mean(alpha);
	end
	ax = gca;
	ax.FontSize = 20;
	ax.XLim = [450 6300];
	ax.YLim = [0 1];
	ax.XTick = 0:1000:6300;
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

	print(sprintf('Optimization_Plate_%s.tif',labels(idx_f)),'-dtiff','-r500');
	hold off;
end

load('Optimization_Plate.mat');
% idx_chosen = [1 6 11 16];
idx_chosen = [5 9 11 19];
for idx_f = 1:size(x0_chosen,1)
	x0_chosen(idx_f,:) = param_chosen(idx_chosen(idx_f),:);
end
save('Optimization_Plate.mat');

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