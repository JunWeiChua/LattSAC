classdef UnitCell < CellArchitecture
    properties
		cell_length		(1,1)	{mustBeNumeric}	= 0
		rel_density		(1,1)	{mustBeNumeric}	= 0
		strut_length	(1,1)	{mustBeNumeric}	= 0
		strut_width		(1,1)	{mustBeNumeric}	= 0
		delta_1			(1,1)	{mustBeNumeric}	= 0
		delta_2			(1,1)	{mustBeNumeric}	= 0
    end
    
    methods
		function unitCell = UnitCell(label,lcell,RD)
			if nargin > 0
				load('Unit Cell Architecture.mat');
				cellArch = CellArchitecture.findCellArch(cell_lib,label);
				P = properties(cellArch);
				for k = 1:length(P)
					unitCell.(P{k}) = cellArch.(P{k});
				end
				unitCell.cell_length = lcell;
				unitCell.rel_density = RD;
				calcStrutLW(unitCell);
				calcDelta(unitCell);
			end
		end
		
		function calcStrutLW(unitCell)
			% Strut Length
			unitCell.strut_length = unitCell.cell_length*unitCell.cell2strut;
			
			% Strut Width
			model = unitCell.StrutWidthModel;
			unitCell.strut_width = model(unitCell.rel_density)*unitCell.cell_length;
		end
		
		function calcDelta(unitCell)
			% delta_1
			X = [unitCell.cell_length unitCell.rel_density];
			model = unitCell.Delta1Model;
			unitCell.delta_1 = model(X);
			
			% delta_2
			X = [unitCell.cell_length unitCell.rel_density];
			X = [X sum(X.^2,2)];
			X_n = ( X - unitCell.Delta2Model.mean ) ./ unitCell.Delta2Model.std;
			Y = [];
			for i = 1:length(unitCell.Delta2Model.NN)
				model = unitCell.Delta2Model.NN{i};
				Y(i) = model(X_n');
			end
			unitCell.delta_2 = log(mean(Y) / (1 - mean(Y)));
		end
		
		function disp(unitCell)
			fprintf('S/N:		%d\n',unitCell.SN);
            fprintf('Name:		%s\n',unitCell.name);
			fprintf('cell_length:	%.5f\n',unitCell.cell_length);
			fprintf('rel_density:	%.5f\n',unitCell.rel_density);
			fprintf('strut_length:	%.5f\n',unitCell.strut_length);
			fprintf('strut_width:	%.5f\n',unitCell.strut_width);
			fprintf('\n');
		end
    end
end