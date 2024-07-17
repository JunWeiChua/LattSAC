classdef Default_Lattice < handle
    properties (Constant)
		% Lists and Ranges
		CrossSectionList = ["Circle";"Square"];
		SampleLength = [10,50];
		SampleDiameter = [10,50];
		FrequencyFull = [100:10:6300];
		Frequency = [1000:10:6300];
	end
	
	properties (SetAccess = protected)
		% Lists and Ranges
		CellType = [];
		
		% Default Values
		CrossSection_0 = [];
		SampleLength_0 = [];
		SampleDiameter_0 = [];
		NumLayer_0 = [];
		CellType_0 = [];
    end
    
    methods
        function Latt_0 = Default_Lattice(cellTypeList)
			if nargin > 0
				Latt_0.CellType = cellTypeList;
				Latt_0.setDefaultValues();
			end
		end
		
		function setDefaultValues(Latt_0)
			% Default Values
			Latt_0.CrossSection_0 = Latt_0.CrossSectionList(1);
			Latt_0.SampleLength_0 = mean(Latt_0.SampleLength);
			Latt_0.SampleDiameter_0 = mean(Latt_0.SampleDiameter);
			Latt_0.NumLayer_0 = 1;
			Latt_0.CellType_0 = Latt_0.CellType(1);
		end
    end
end