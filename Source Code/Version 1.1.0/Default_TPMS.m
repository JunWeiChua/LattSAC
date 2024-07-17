classdef Default_TPMS < handle
    properties (Constant)
		% Lists and Ranges
		CellSize = 4:0.1:8;
		RelativeDensity = 0.2:0.01:0.4;
	end
	
	properties (SetAccess = protected)
		% Lists and Ranges
		CellArchList = [];
		NetworkList = [];
		
		% Default Values
		CellArch_0 = [];
		Network_0 = [];
		CellSize_0 = [];
		RelativeDensity_0 = [];
		NumLayer_0 = [];
    end
    
    methods
        function TPMS_0 = Default_TPMS(cell,net)
			if nargin > 0
				TPMS_0.CellArchList = cell;
				TPMS_0.NetworkList = net;
				
				TPMS_0.setDefaultValues();
			end
		end
		
		function setDefaultValues(TPMS_0)
			% Default Values
			TPMS_0.CellArch_0 = TPMS_0.CellArchList(1);
			TPMS_0.Network_0 = TPMS_0.NetworkList(1);
			TPMS_0.CellSize_0 = mean([TPMS_0.CellSize(1),TPMS_0.CellSize(end)]);
			TPMS_0.RelativeDensity_0 = mean([TPMS_0.RelativeDensity(1),TPMS_0.RelativeDensity(end)]);
			TPMS_0.NumLayer_0 = 1;
		end
    end
end