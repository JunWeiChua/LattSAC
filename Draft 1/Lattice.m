classdef Lattice < IndexList
    properties
		cross_section	string					= []
		l_sample		(1,1)	{mustBeNumeric}	= 0
		w_sample		(1,1)	{mustBeNumeric}	= 0	
		t_sample		(1,1)	{mustBeNumeric}	= 0
		num_layers		(1,1)	{mustBeNumeric}	= 0
		frequency								= []
		transfer_matrix							= []
		alpha									= []
    end
    
    methods
        function sample = Lattice(c_section,freq)
			if nargin > 0
				sample.cross_section = c_section;
				sample.frequency = freq;
			end
		end
		
		function insertLayer(sample,layer,idx)
			if isempty(sample.Head)
				insertNode(sample,layer,1);
				sample.cross_section = layer.cross_section;
				sample.l_sample = layer.l_layer;
				sample.w_sample = layer.w_layer;
				sample.t_sample = layer.t_layer;
			else
				if sample.l_sample ~= layer.l_layer || sample.w_sample ~= layer.w_layer || ...
				   sample.cross_section ~= layer.cross_section
					error('Dimensions do not match.');
				else
					insertNode(sample,layer,idx);
					sample.t_sample = sample.t_sample + layer.t_layer;
				end
			end
			sample.num_layers = sample.Length;
		end
		
		function removeLayer(sample,idx)
			removeNode(sample,idx);
			sample.num_layers = sample.Length;
		end
		
		% Calculate the transfer matrix for the sample given frequency range.
		function calcTMM(sample)
			sample.transfer_matrix = cell(length(sample.frequency),1);
			
			latt_layer = sample.Head;
			while ~isempty(latt_layer)
				freq = sample.frequency;
				TMM = calcTMM(latt_layer,sample.frequency);
				if latt_layer.Index == 1
					sample.transfer_matrix = TMM;
				else
					for nf = 1:length(freq)
						sample.transfer_matrix{nf} = sample.transfer_matrix{nf} * TMM{nf};
					end
				end
				latt_layer = latt_layer.Next;
			end
		end
		
		% Calculate absorption coefficient for the sample.
		function calcAlpha(sample)
			% Air parameters
			rho0 = 1.225; % Air density, kg/m3
			c0 = 343; % Sound speed, m/s
			Z0 = complex(rho0*c0); % Air impedance
			
			freq = sample.frequency;
			sample.alpha = zeros(length(freq),1);
			for nf = 1:length(freq)
				mat_whole = sample.transfer_matrix{nf};
				V_final = mat_whole(2,1)/mat_whole(1,1); %A and C in the final matrix.
				R = (1-Z0*V_final)/(1+Z0*V_final);
				sample.alpha(nf,:) = 1-abs(R)^2;
			end
		end
		
		% Plot absorption coefficient for the sample on the given figure.
		function plotAlpha(sample)
			freq = sample.frequency;
			SAC = sample.alpha;
			% plot(freq,SAC);
			plot(freq,SAC,'DisplayName','MMC Model (CBP)', ...
				'Color',[0 0 0.8],'LineStyle',"-",'LineWidth',3);
		end
		
		% Displays lattice and its constituent layers.
		function disp(list)
            disp('Lattice containing:');
            item = list.Head;
            while ~isempty(item)
                item.disp();
                item = item.Next;
            end
        end
    end
end