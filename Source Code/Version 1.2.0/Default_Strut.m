classdef Default_Strut < handle
    properties (Constant)
		CellType = "Strut"
		
		% Lists and Ranges
		CellSize = 4:0.1:8;
		RelativeDensity = 0.1:0.01:0.4;
	end
	
	properties (SetAccess = protected)
		% Lists and Ranges
		CellArchList = [];
		
		% Default Values
		CellArch_0 = [];
		CellSize_0 = [];
		RelativeDensity_0 = [];
		NumLayer_0 = [];
		
		% Default Bounds
		CellArch_Choices = [];
		CellSize_Min = [];
		CellSize_Max = [];
		RelativeDensity_Min = [];
		RelativeDensity_Max = [];
		NumLayer_Min = [];
    end
    
    methods
        function Strut_0 = Default_Strut(list)
			if nargin > 0
				Strut_0.CellArchList = list;
				Strut_0.setDefaultValues();
				Strut_0.setDefaultBounds();
			end
		end
		
		function setDefaultValues(Strut_0)
			% Default Values
			Strut_0.CellArch_0 = Strut_0.CellArchList(1);
			Strut_0.CellSize_0 = mean([Strut_0.CellSize(1),Strut_0.CellSize(end)]);
			Strut_0.RelativeDensity_0 = 0.3;
			Strut_0.NumLayer_0 = 1;
		end
		
		function setDefaultBounds(Strut_0)
			Strut_0.CellArch_Choices = Strut_0.CellArchList;
			Strut_0.setCellSizeMin(Strut_0.CellSize(1));
			Strut_0.setCellSizeMax(Strut_0.CellSize(end));
			Strut_0.setRDMin(Strut_0.RelativeDensity(1));
			Strut_0.setRDMax(Strut_0.RelativeDensity(end));
			Strut_0.setMinLayer(Strut_0.NumLayer_0);
		end
		
		function isChoice = isCellArchChoice(Strut_0,cell)
			if find(Strut_0.CellArch_Choices == cell) > 0
				isChoice = true;
			else
				isChoice = false;
			end
		end
		
		function addCellArchChoice(Strut_0,cell)
			Strut_0.CellArch_Choices(size(Strut_0.CellArch_Choices,1)+1) = cell;
		end
		
		function removeCellArchChoice(Strut_0,cell)
			Strut_0.CellArch_Choices(find(Strut_0.CellArch_Choices == cell)) = [];
		end
		
		function setCellSizeMin(Strut_0,value)
			Strut_0.CellSize_Min = value;
		end
		
		function setCellSizeMax(Strut_0,value)
			Strut_0.CellSize_Max = value;
		end
		
		function setRDMin(Strut_0,value)
			Strut_0.RelativeDensity_Min = value;
		end
		
		function setRDMax(Strut_0,value)
			Strut_0.RelativeDensity_Max = value;
		end
		
		function setMinLayer(Strut_0,value)
			Strut_0.NumLayer_Min = value;
		end
		
		function cp = copyBounds(Strut_0)
			cp = Default_Strut(Strut_0.CellArchList);
			cp.CellArch_Choices = Strut_0.CellArch_Choices;
			cp.setCellSizeMin(Strut_0.CellSize_Min);
			cp.setCellSizeMax(Strut_0.CellSize_Max);
			cp.setRDMin(Strut_0.RelativeDensity_Min);
			cp.setRDMax(Strut_0.RelativeDensity_Max);
			cp.setMinLayer(Strut_0.NumLayer_Min);
		end
    end
end