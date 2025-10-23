classdef Default_TPMS < handle
    properties (Constant)
		CellType = "TPMS"
		
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
		
		% Default Bounds
		CellArch_Choices = [];
		Network_Choices = [];
		CellSize_Min = [];
		CellSize_Max = [];
		RelativeDensity_Min = [];
		RelativeDensity_Max = [];
		NumLayer_Min = [];
    end
    
    methods
        function TPMS_0 = Default_TPMS(cell,net)
			if nargin > 0
				TPMS_0.CellArchList = cell;
				TPMS_0.NetworkList = net;
				
				TPMS_0.setDefaultValues();
				TPMS_0.setDefaultBounds();
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
		
		function setDefaultBounds(TPMS_0)
			TPMS_0.CellArch_Choices = TPMS_0.CellArchList;
			TPMS_0.Network_Choices = TPMS_0.NetworkList;
			TPMS_0.setCellSizeMin(TPMS_0.CellSize(1));
			TPMS_0.setCellSizeMax(TPMS_0.CellSize(end));
			TPMS_0.setRDMin(TPMS_0.RelativeDensity(1));
			TPMS_0.setRDMax(TPMS_0.RelativeDensity(end));
			TPMS_0.setMinLayer(TPMS_0.NumLayer_0);
		end
		
		function isChoice = isCellArchChoice(TPMS_0,cell)
			if find(TPMS_0.CellArch_Choices == cell) > 0
				isChoice = true;
			else
				isChoice = false;
			end
		end
		
		function addCellArchChoice(TPMS_0,cell)
			TPMS_0.CellArch_Choices(size(TPMS_0.CellArch_Choices,1)+1) = cell;
		end
		
		function removeCellArchChoice(TPMS_0,cell)
			TPMS_0.CellArch_Choices(find(TPMS_0.CellArch_Choices == cell)) = [];
		end
		
		function isChoice = isNetworkChoice(TPMS_0,net)
			if find(TPMS_0.Network_Choices == net) > 0
				isChoice = true;
			else
				isChoice = false;
			end
		end
		
		function addNetworkChoice(TPMS_0,net)
			TPMS_0.Network_Choices(size(TPMS_0.Network_Choices,1)+1) = net;
		end
		
		function removeNetworkChoice(TPMS_0,net)
			TPMS_0.Network_Choices(find(TPMS_0.Network_Choices == net)) = [];
		end
		
		function setCellSizeMin(TPMS_0,value)
			TPMS_0.CellSize_Min = value;
		end
		
		function setCellSizeMax(TPMS_0,value)
			TPMS_0.CellSize_Max = value;
		end
		
		function setRDMin(TPMS_0,value)
			TPMS_0.RelativeDensity_Min = value;
		end
		
		function setRDMax(TPMS_0,value)
			TPMS_0.RelativeDensity_Max = value;
		end
		
		function setMinLayer(TPMS_0,value)
			TPMS_0.NumLayer_Min = value;
		end
		
		function cp = copyBounds(TPMS_0)
			cp = Default_TPMS(TPMS_0.CellArchList,TPMS_0.NetworkList);
			cp.CellArch_Choices = TPMS_0.CellArch_Choices;
			cp.Network_Choices = TPMS_0.Network_Choices;
			cp.setCellSizeMin(TPMS_0.CellSize_Min);
			cp.setCellSizeMax(TPMS_0.CellSize_Max);
			cp.setRDMin(TPMS_0.RelativeDensity_Min);
			cp.setRDMax(TPMS_0.RelativeDensity_Max);
			cp.setMinLayer(TPMS_0.NumLayer_Min);
		end
    end
end