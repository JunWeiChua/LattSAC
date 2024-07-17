classdef Default_Strut < handle
    properties (Constant)
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
    end
    
    methods
        function Strut_0 = Default_Strut(list)
			if nargin > 0
				Strut_0.CellArchList = list;
				Strut_0.setDefaultValues();
			end
		end
		
		function setDefaultValues(Strut_0)
			% Default Values
			Strut_0.CellArch_0 = Strut_0.CellArchList(1);
			Strut_0.CellSize_0 = mean([Strut_0.CellSize(1),Strut_0.CellSize(end)]);
			Strut_0.RelativeDensity_0 = 0.3;
			Strut_0.NumLayer_0 = 1;
		end
    end
end