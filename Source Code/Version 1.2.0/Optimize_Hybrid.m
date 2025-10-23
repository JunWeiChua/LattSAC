% Optimzation Program for Hybrid Lattices.

clc; clear all; close all;
load('Unit Cell Architecture','cellArchList');

% Initalise constant parameters.
Type = ["Strut";"Plate";"TPMS"];
Freq = [450:10:3000]'; % Maximise SAC for these frequency ranges.
CrossSection = "Circle";
SampleDiameter = 29;
Ht = 40; % Sample Height
NumIter = 3;
N_layers = size(Type,1);

% Constraints.
lb = [];
ub = [];
intcon = [];
ParamIdx = 0;
for idx_layer = 1:size(Type,1);
	switch Type(idx_layer)
		case 'Strut'
			lb = [lb; [1;4.0;0.2;2]];
			ub = [ub; [7;8.0;0.4;10]];
			intcon = [intcon [ParamIdx+1 ParamIdx+4]];
			
			ParamIdx = ParamIdx + 4;
		case 'Plate'
			lb = [lb; [1;4.0;0.2;0.3;2]];
			ub = [ub; [3;8.0;0.4;0.6;10]];
			intcon = [intcon [ParamIdx+1 ParamIdx+5]];
			
			ParamIdx = ParamIdx + 5;
		case 'TPMS'
			lb = [lb; [1;1;4.0;0.2;2]];
			ub = [ub; [4;2;8.0;0.4;10]];
			intcon = [intcon [ParamIdx+1 ParamIdx+2 ParamIdx+5]];
			
			ParamIdx = ParamIdx + 5;
	end
end

% Optimize.
Lattice = OptimizeSAC(Type,cellArchList,Freq,CrossSection,SampleDiameter,Ht,lb,ub,intcon,NumIter);

% Plot.
figure('Position', [100 100 700 700]);
color = [0.8 0 0;0 0 0.8;0 0.8 0;0.8 0.6 0;0.6 0 0.8;0 0.8 0.6];
line_style = ["-" "--" ":" "-."];
marker = ["o",'+','x','s',"diamond","pentagram","hexagram"];
item = Lattice.Head; idx_iter = 1;
while ~isempty(item)
	fprintf("Iter Num %d:\n",idx_iter);
	Sample = item.Data;
	Sample.disp();
	freq = Sample.Frequency;
	alpha = Sample.SAC;
	plot(freq,alpha,'DisplayName',sprintf("Iter Num %d",idx_iter), ...
		'Color',color(mod(idx_iter,4)+1,:),'LineStyle',line_style(mod(idx_iter,3)+1),'LineWidth',3);
	hold on;
	
	item = item.Next; idx_iter = idx_iter + 1;
end
ax = gca;
ax.FontSize = 20;
ax.XLim = [450 6400];
ax.YLim = [0 1];
ax.XTick = 0:2000:6400;
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

print('Optimize_Hybrid.tif','-dtiff','-r500');
hold off;