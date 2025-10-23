classdef Default_Plate < handle
    properties (Constant)
		CellType = "Plate"
		
		% Lists and Ranges
		CellSize = 4:0.1:8;
		RelativeDensity = 0.2:0.01:0.4;
		HolePercent = 0.3:0.01:0.6;
	end
	
	properties (SetAccess = protected)
		% Lists and Ranges
		CellArchList = [];
		
		% Default Values
		CellArch_0 = [];
		CellSize_0 = [];
		RelativeDensity_0 = [];
		HolePercent_0 = [];
		NumLayer_0 = [];
		
		% Default Bounds
		CellArch_Choices = [];
		CellSize_Min = [];
		CellSize_Max = [];
		RelativeDensity_Min = [];
		RelativeDensity_Max = [];
		HolePercent_Min = [];
		HolePercent_Max = [];
		NumLayer_Min = [];
    end
    
    methods
        function Plate_0 = Default_Plate(list)
			if nargin > 0
				Plate_0.CellArchList = list;
				Plate_0.setDefaultValues();
				Plate_0.setDefaultBounds();
			end
		end
		
		function setDefaultValues(Plate_0)
			% Default Values
			Plate_0.CellArch_0 = Plate_0.CellArchList(1);
			Plate_0.CellSize_0 = mean([Plate_0.CellSize(1),Plate_0.CellSize(end)]);
			Plate_0.RelativeDensity_0 = 0.3;
			Plate_0.HolePercent_0 = 0.4;
			Plate_0.NumLayer_0 = 1;
		end
		
		function setDefaultBounds(Plate_0)
			Plate_0.CellArch_Choices = Plate_0.CellArchList;
			Plate_0.setCellSizeMin(Plate_0.CellSize(1));
			Plate_0.setCellSizeMax(Plate_0.CellSize(end));
			Plate_0.setRDMin(Plate_0.RelativeDensity(1));
			Plate_0.setRDMax(Plate_0.RelativeDensity(end));
			Plate_0.setHoleMin(Plate_0.HolePercent(1));
			Plate_0.setHoleMax(Plate_0.HolePercent(end));
			Plate_0.setMinLayer(Plate_0.NumLayer_0);
		end
		
		function isChoice = isCellArchChoice(Plate_0,cell)
			if find(Plate_0.CellArch_Choices == cell) > 0
				isChoice = true;
			else
				isChoice = false;
			end
		end
		
		function addCellArchChoice(Plate_0,cell)
			Plate_0.CellArch_Choices(size(Plate_0.CellArch_Choices,1)+1) = cell;
		end
		
		function removeCellArchChoice(Plate_0,cell)
			Plate_0.CellArch_Choices(find(Plate_0.CellArch_Choices == cell)) = [];
		end
		
		function setCellSizeMin(Plate_0,value)
			Plate_0.CellSize_Min = value;
		end
		
		function setCellSizeMax(Plate_0,value)
			Plate_0.CellSize_Max = value;
		end
		
		function setRDMin(Plate_0,value)
			Plate_0.RelativeDensity_Min = value;
		end
		
		function setRDMax(Plate_0,value)
			Plate_0.RelativeDensity_Max = value;
		end
		
		function setHoleMin(Plate_0,value)
			Plate_0.HolePercent_Min = value;
		end
		
		function setHoleMax(Plate_0,value)
			Plate_0.HolePercent_Max = value;
		end
		
		function setMinLayer(Plate_0,value)
			Plate_0.NumLayer_Min = value;
		end
		
		function cp = copyBounds(Plate_0)
			cp = Default_Plate(Plate_0.CellArchList);
			cp.CellArch_Choices = Plate_0.CellArch_Choices;
			cp.setCellSizeMin(Plate_0.CellSize_Min);
			cp.setCellSizeMax(Plate_0.CellSize_Max);
			cp.setRDMin(Plate_0.RelativeDensity_Min);
			cp.setRDMax(Plate_0.RelativeDensity_Max);
			cp.setHoleMin(Plate_0.HolePercent_Min);
			cp.setHoleMax(Plate_0.HolePercent_Max);
			cp.setMinLayer(Plate_0.NumLayer_Min);
		end
    end
end