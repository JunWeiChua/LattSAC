classdef CellArchitecture < handle
    properties
		SN			(1,1)					= 0
		name		string 					= ""
		N_node		(1,1)	{mustBeNumeric}	= 0
		N_strut 	(1,1)	{mustBeNumeric}	= 0
		max_deg 	(1,1)	{mustBeNumeric}	= 0
		min_deg 	(1,1)	{mustBeNumeric}	= 0
		cell2strut	(1,1) 	{mustBeNumeric}	= 0
		length_corr (1,1) 	{mustBeNumeric}	= 0
		width_corr 	(1,1) 	{mustBeNumeric}	= 0
		StrutWidthModel 					= []
		Delta1Model 						= []
		Delta2Model 						= []
    end
    
    methods
        function cellArch = CellArchitecture(label,nNode,nStrut,MaxDeg,MinDeg,c2s)
			if nargin > 0
				cellArch.name = label;
				cellArch.N_node = nNode;
				cellArch.N_strut = nStrut;
				cellArch.max_deg = MaxDeg;
				cellArch.min_deg = MinDeg;
				cellArch.cell2strut = c2s;
			end
		end
		
		function disp(cellArch)
			fprintf('S/N:		%d\n',cellArch.SN);
            fprintf('Name:		%s\n',cellArch.name);
            fprintf('# Nodes:	%d\n',cellArch.N_node);
            fprintf('# Struts:	%d\n',cellArch.N_strut);
			fprintf('max_deg:	%d\n',cellArch.max_deg);
			fprintf('min_deg:	%d\n',cellArch.min_deg);
			fprintf('cell2strut:	%.5f\n',cellArch.cell2strut);
			fprintf('length_corr:	%.5f\n',cellArch.length_corr);
			fprintf('width_corr:	%.5f\n',cellArch.width_corr);
			fprintf('\n');
		end
    end
	
	methods (Static)
		% Function to import the data of unit cell architectures and create the objects.
		function importCellLibrary()
			load('Lattice Data.mat');
			load('MMC_errors.mat','length_corr_best','width_corr_best');
			load('Delta Models.mat','delta_1_model');
			%#function network
			load('NN Model Library.mat');
			cell_lib = cell(size(unit_cell,1),1);
			for idx = 1:size(cell_lib,1)
				cell_lib{idx} = CellArchitecture(unit_cell(idx),num_node(idx), ...
					num_strut(idx),max_degree(idx),min_degree(idx),c2s_factor(idx));
				cellArch = cell_lib{idx};
				cellArch.SN = idx;
				cellArch.length_corr = length_corr_best(idx);
				cellArch.width_corr = width_corr_best(idx);
				cellArch.StrutWidthModel = w_model{idx};
				cellArch.Delta1Model = delta_1_model{idx};
				cellArch.Delta2Model = delta_2_NN_lib{idx};
			end
			save('Unit Cell Architecture','cell_lib','unit_cell');
			fprintf("Unit Cell Architecture Library created successfully.\n");
		end
		
		% Function to find unit cell architecture given its label.
		function cell_arch = findCellArch(cell_lib,label)
			cell_arch = CellArchitecture("",0,0,0,0,0);
			for i = 1:size(cell_lib,1)
				if cell_lib{i}.name == label
					cell_arch = cell_lib{i};
				end
			end
		end
	end
end