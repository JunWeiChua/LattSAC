classdef Default_Plate < handle
    properties (Constant)
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
    end
    
    methods
        function Plate_0 = Default_Plate(list)
			if nargin > 0
				Plate_0.CellArchList = list;
				Plate_0.setDefaultValues();
			end
		end
		
		function setDefaultValues(Plate_0)
			% Default Values
			Plate_0.CellArch_0 = Plate_0.CellArchList(1);
			Plate_0.CellSize_0 = mean([Plate_0.CellSize(1),Plate_0.CellSize(end)]);
			Plate_0.RelativeDensity_0 = mean([Plate_0.RelativeDensity(1),Plate_0.RelativeDensity(end)]);
			Plate_0.HolePercent_0 = 0.4;
			Plate_0.NumLayer_0 = 1;
		end
    end
end