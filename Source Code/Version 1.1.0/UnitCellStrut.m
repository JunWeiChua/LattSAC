classdef UnitCellStrut < handle
    properties (SetAccess = protected)
		CellArch		% CellArchStrut Object
		cell_length		(1,1)	{mustBeNonnegative}	= 0
		rel_density		(1,1)	{mustBeNonnegative}	= 0
		strut_length	(1,1)	{mustBeNonnegative}	= 0
		strut_width		(1,1)	{mustBeNonnegative}	= 0
		delta_1			(1,1)	{mustBeNumeric}		= 0
		delta_2			(1,1)	{mustBeNumeric}		= 0
    end
    
    methods
		function unitCell = UnitCellStrut(label,lcell,RD)
			if nargin > 0
				load('Unit Cell Architecture.mat');
				cellArch = cellArchLib.findCellArch("Strut",label);
				unitCell.CellArch = cellArch;
				unitCell.cell_length = lcell;
				unitCell.rel_density = RD;
				unitCell.calcStrutLW();
				unitCell.calcDelta();
			end
		end
		
		function calcStrutLW(unitCell)
			% Strut Length
			unitCell.strut_length = unitCell.cell_length*unitCell.CellArch.cell2strut;
			
			% Strut Width
			model = unitCell.CellArch.StrutWidthModel;
			unitCell.strut_width = model(unitCell.rel_density)*unitCell.cell_length;
		end
		
		function calcDelta(unitCell)
			% delta_1
			X = [unitCell.cell_length unitCell.rel_density];
			model = unitCell.CellArch.Delta1Model;
			unitCell.delta_1 = model(X);
			
			% delta_2
			X = [unitCell.cell_length unitCell.rel_density];
			X = [X sum(X.^2,2)];
			model = unitCell.CellArch.Delta2Model;
			unitCell.delta_2 = predict(model,X);
		end
		
		function changeUC(unitCell,label)
			load('Unit Cell Architecture.mat');
			cellArch = cellArchLib.findCellArch(label);
			unitCell.CellArch = cellArch;
			unitCell.calcStrutLW();
			unitCell.calcDelta();
		end
		
		function setLcell(unitCell,lcell)
			unitCell.cell_length = lcell;
			unitCell.calcStrutLW();
			unitCell.calcDelta();
		end
		
		function setRD(unitCell,RD)
			unitCell.rel_density = RD;
			unitCell.calcStrutLW();
			unitCell.calcDelta();
		end
		
		function cp = copyUC(unitCell)
			cp = UnitCellStrut(unitCell.CellArch.Name, ...
				unitCell.cell_length,unitCell.rel_density);
		end
		
		function disp(unitCell)
			fprintf('S/N:		%d\n',unitCell.CellArch.SN);
            fprintf('Name:		%s\n',unitCell.CellArch.Name);
			fprintf('Cell Type: 	%s\n',unitCell.CellArch.CellType);
			fprintf('Cell Length:	%.5f\n',unitCell.cell_length);
			fprintf('Rel Density:	%.5f\n',unitCell.rel_density);
			fprintf('Strut Length:	%.5f\n',unitCell.strut_length);
			fprintf('Strut Width:	%.5f\n',unitCell.strut_width);
			fprintf('\n');
		end
    end
end