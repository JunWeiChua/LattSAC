classdef CellArchPlate < CellArch
    properties (Constant)
		CellType = "Plate"
	end
	
	properties (SetAccess = protected)
		t_corr		(1,1) 	{mustBeNonnegative}	= 0
		d_corr 		(1,1) 	{mustBeNonnegative}	= 0
		s_corr 		(1,1) 	{mustBeNonnegative}	= 0
		ThicknessModel 							= []
		Delta1Model 							= []
		Delta2Model 							= []
    end
    
    methods
        function cellArch = CellArchPlate(label)
			cellArch@CellArch(label);
			cellArch.setParam();
		end
		
		function setParam(cellArch)
			% Import the .mat data files.
			%#function network
			load('Plate Lattice.mat');
			
			idx = find(unit_cell == cellArch.Name);
			cellArch.t_corr = t_corr(idx);
			cellArch.d_corr = d_corr(idx);
			cellArch.s_corr = s_corr(idx);
			cellArch.ThicknessModel = t_plate_model{idx};
			cellArch.Delta1Model = delta_1_model{idx};
			cellArch.Delta2Model = delta_2_model{idx};
		end
		
		function disp(cellArch)
			fprintf('S/N:        %d\n',cellArch.SN);
            fprintf('Name:       %s\n',cellArch.Name);
			fprintf('Cell Type:  %s\n',cellArch.CellType);
			fprintf('\n');
		end
    end
end