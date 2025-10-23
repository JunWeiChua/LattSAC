classdef UnitCellPlate < handle
    properties (SetAccess = protected)
		CellArch		% CellArchPlate Object
		cell_length		(1,1)	{mustBeNonnegative}	= 0
		rel_density		(1,1)	{mustBeNonnegative}	= 0
		hole_percent	(1,1)	{mustBeNonnegative}	= 0
		d_hole			(1,1)	{mustBeNonnegative}	= 0
		t_plate			(1,1)	{mustBeNonnegative}	= 0
		delta_1			(1,1)	{mustBeNumeric}		= 0
		delta_2			(1,1)	{mustBeNumeric}		= 0
    end
    
    methods
		function unitCell = UnitCellPlate(label,lcell,RD,c2h)
			if nargin > 0
				load('Unit Cell Architecture.mat');
				cellArch = cellArchLib.findCellArch("Plate",label);
				unitCell.CellArch = cellArch;
				unitCell.cell_length = lcell;
				unitCell.rel_density = RD;
				unitCell.hole_percent = c2h;
				unitCell.d_hole = lcell*c2h;
				unitCell.calcPlateThickness();
				unitCell.calcDelta();
			end
		end
		
		function calcPlateThickness(unitCell)
			X = [unitCell.rel_density unitCell.hole_percent];
			model = unitCell.CellArch.ThicknessModel;
			unitCell.t_plate = unitCell.cell_length*model(X);
		end
		
		function calcDelta(unitCell)
			% delta_1
			X = [unitCell.cell_length unitCell.rel_density unitCell.d_hole];
			X = [X sum(X.^2,2)];
			model = unitCell.CellArch.Delta1Model;
			unitCell.delta_1 = predict(model,X);
			
			% delta_2
			model = unitCell.CellArch.Delta2Model;
			unitCell.delta_2 = exp(predict(model,X));
		end
		
		function changeUC(unitCell,label)
			load('Unit Cell Architecture.mat');
			cellArch = cellArchLib.findCellArch(label,"Plate");
			unitCell.CellArch = cellArch;
			unitCell.calcPlateThickness();
			unitCell.calcDelta();
		end
		
		function setLcell(unitCell,lcell)
			unitCell.cell_length = lcell;
			unitCell.calcPlateThickness();
			unitCell.calcDelta();
		end
		
		function setRD(unitCell,RD)
			unitCell.rel_density = RD;
			unitCell.calcPlateThickness();
			unitCell.calcDelta();
		end
		
		function setHole(unitCell,c2h)
			unitCell.hole_percent = c2h;
			unitCell.d_hole = unitCell.cell_length*c2h;
			unitCell.calcPlateThickness();
			unitCell.calcDelta();
		end
		
		function cp = copyUC(unitCell)
			cp = UnitCellPlate(unitCell.CellArch.Name, ...
				unitCell.cell_length,unitCell.rel_density,unitCell.hole_percent);
		end
		
		function disp(unitCell)
			fprintf('S/N:			%d\n',unitCell.CellArch.SN);
            fprintf('Name:			%s\n',unitCell.CellArch.Name);
			fprintf('Cell Type:		%s\n',unitCell.CellArch.CellType);
			fprintf('Cell Length:		%.5f\n',unitCell.cell_length);
			fprintf('Rel Density:		%.5f\n',unitCell.rel_density);
			fprintf('Hole Diameter:		%.5f\n',unitCell.d_hole);
			fprintf('Plate Thickness:	%.5f\n',unitCell.t_plate);
			fprintf('\n');
		end
    end
end