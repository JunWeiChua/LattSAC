classdef CellArchTPMS < CellArch
    properties (Constant)
		CellType = "TPMS"
	end
	
	properties (SetAccess = protected)
		Network						= ""
		IsovalueModel 				= []
		phi_corr					= 0
		thermal_corr				= 0
		FlowResistivityModel		= []
		TortuosityModel				= []
		ViscousLengthModel			= []
		ThermalPermeabilityModel	= []
    end
    
    methods
        function cellArch = CellArchTPMS(label,net)
			cellArch@CellArch(label);
			cellArch.Network = net;
			cellArch.setParam();
		end
		
		function setParam(cellArch)
			% Import the .mat data files.
			%#function network
			load('TPMS Lattice.mat');
			
			idx_cell = find(TPMS_cell == cellArch.Name);
			idx_network = find(TPMS_network == cellArch.Network);
			cellArch.IsovalueModel = t_model{idx_cell,idx_network};
			cellArch.phi_corr = phi_corr(idx_cell,idx_network);
			cellArch.thermal_corr = thermal_corr(idx_cell,idx_network);
			cellArch.FlowResistivityModel = sigma_model{idx_cell,idx_network};
			cellArch.TortuosityModel = alpha_inf_model{idx_cell,idx_network};
			cellArch.ViscousLengthModel = viscous_length_model{idx_cell,idx_network};
			cellArch.ThermalPermeabilityModel = k0_prime_model{idx_cell,idx_network};
		end
		
		function disp(cellArch)
			fprintf('S/N:        %d\n',cellArch.SN);
            fprintf('Name:       %s\n',cellArch.Name);
			fprintf('Cell Type:  %s\n',cellArch.CellType);
			fprintf('Network: 	 %s\n',cellArch.Network);
			fprintf('\n');
		end
    end
end