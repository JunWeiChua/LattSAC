classdef CellArchStrut < CellArch
    properties (Constant)
		CellType = "Strut"
	end
	
	properties (SetAccess = protected)
		N_node		(1,1)	{mustBeNonnegative}	= 0
		N_strut 	(1,1)	{mustBeNonnegative}	= 0
		max_deg 	(1,1)	{mustBeNonnegative}	= 0
		min_deg 	(1,1)	{mustBeNonnegative}	= 0
		cell2strut	(1,1) 	{mustBeNonnegative}	= 0
		length_corr (1,1) 	{mustBeNonnegative}	= 0
		width_corr 	(1,1) 	{mustBeNonnegative}	= 0
		StrutWidthModel 						= []
		Delta1Model 							= []
		Delta2Model 							= []
    end
    
    methods
        function cellArch = CellArchStrut(label)
			cellArch@CellArch(label);
			cellArch.setParam();
		end
		
		function setParam(cellArch)
			% Import the .mat data files.
			load('Lattice Data.mat');
			load('MMC_errors.mat','length_corr_best','width_corr_best');
			load('Delta Models.mat','delta_1_model');
			%#function network
			load('NN Model Library.mat');
			
			idx = find(unit_cell == cellArch.Name);
			cellArch.N_node = num_node(idx);
			cellArch.N_strut = num_strut(idx);
			cellArch.max_deg = max_degree(idx);
			cellArch.min_deg = min_degree(idx);
			cellArch.cell2strut = c2s_factor(idx);
			cellArch.length_corr = length_corr_best(idx);
			cellArch.width_corr = width_corr_best(idx);
			cellArch.StrutWidthModel = w_model{idx};
			cellArch.Delta1Model = delta_1_model{idx};
			cellArch.Delta2Model = delta_2_NN_lib{idx};
		end
		
		function disp(cellArch)
			fprintf('S/N:		%d\n',cellArch.SN);
            fprintf('Name:		%s\n',cellArch.Name);
			fprintf('Cell Type:	%s\n',cellArch.CellType);
            fprintf('# Nodes:	%d\n',cellArch.N_node);
            fprintf('# Struts:	%d\n',cellArch.N_strut);
			fprintf('Max Degree:	%d\n',cellArch.max_deg);
			fprintf('Min Degree:	%d\n',cellArch.min_deg);
			fprintf('c2s Factor:	%.5f\n',cellArch.cell2strut);
			fprintf('\n');
		end
    end
end