classdef Lattice < LinkedList
    properties (SetAccess = protected)
		CrossSection	string						= []
		l_sample		(1,1)	{mustBeNonnegative}	= 0
		w_sample		(1,1)	{mustBeNonnegative}	= 0	
		t_sample		(1,1)	{mustBeNonnegative}	= 0
		num_layers		(1,1)	{mustBeInteger}		= 0
		Frequency									= []
		TransferMatrix								= []
		SAC											= []
		Porosity		(1,1)	{mustBeNonnegative}	= 0
		FlowFormulation {mustBeNumericOrLogical}	= false
    end
    
    methods
        function sample = Lattice(c_section,freq)
			if nargin > 0
				sample.CrossSection = c_section;
				sample.Frequency = freq;
			end
		end
		
		function insertLayer(sample,layer,idx)
			if isempty(sample.Head)
				sample.insert(layer,1);
				sample.CrossSection = layer.CrossSection;
				sample.l_sample = layer.l_layer;
				sample.w_sample = layer.w_layer;
				sample.t_sample = layer.t_layer;
			else
				if sample.l_sample ~= layer.l_layer || sample.w_sample ~= layer.w_layer || ...
				   sample.CrossSection ~= layer.CrossSection
					error('Dimensions do not match.');
				else
					sample.insert(layer,idx);
				end
			end
			sample.updateThickness(0);
			sample.updatePorosity;
			sample.checkFlow;
		end
		
		function removeLayer(sample,idx)
			sample.remove(idx);
			sample.updateThickness(0);
			sample.updatePorosity;
			sample.checkFlow;
		end
		
		function checkFlow(sample)
			cur = sample.Head; flow = 1;
			while ~isempty(cur)
				layer = cur.Data;
				flow = flow * layer.FlowFormulation;
				cur = cur.Next;
			end
			sample.FlowFormulation = flow;
		end
		
		function changeParam(sample,cs,l,w)
			sample.CrossSection = cs;
			sample.l_sample = l;
			sample.w_sample = w;
			cur = sample.Head;
			while ~isempty(cur)
				cur.Data.changeParam(cs,l,w);
				cur = cur.Next;
			end
		end
		
		function updateThickness(sample,partUpdate)
			sample.num_layers = sample.Length;
			sample.t_sample = 0;
			cur = sample.Head;
			while ~isempty(cur)
				layer = cur.Data;
				layer.updateLayerThickness(partUpdate);
				sample.t_sample = sample.t_sample + layer.t_layer;
				cur = cur.Next;
			end
		end
		
		function updatePorosity(sample)
			sum = 0;
			cur = sample.Head;
			while ~isempty(cur)
				layer = cur.Data;
				layer.updatePorosity();
				sum = sum + layer.Porosity*layer.t_layer;
				cur = cur.Next;
			end
			sample.Porosity = sum/sample.t_sample;
		end
		
		function updateSurfaceRatio(sample)
			cur = sample.Head;
			while ~isempty(cur)
				layer = cur.Data;
				layer.updateSurfaceRatio();
				cur = cur.Next;
			end
		end
		
		function changeFreq(sample,newFreq)
			sample.Frequency = newFreq;
			sample.TransferMatrix = [];
			sample.SAC = [];
		end
		
		function reverseLatt(sample)
			sample.reverse();
			sample.updateThickness(0);
			sample.updatePorosity;
		end
		
		function cp = copyLatt(sample)
			cp = Lattice(sample.CrossSection,sample.Frequency);
			cur = sample.Head; count = 0;
			while ~isempty(cur)
				layer_cp = copyLayer(cur.Data);
				count = count + 1;
				cp.insertLayer(layer_cp,count);
				cur = cur.Next;
			end
			cp.checkFlow;
		end
		
		% Calculate the transfer matrix for the sample given frequency range.
		function calcTMM(sample)
			sample.updateThickness(0);
			sample.updatePorosity;
			sample.TransferMatrix = cell(length(sample.Frequency),1);
			layer = sample.Head;
			while ~isempty(layer)
				freq = sample.Frequency;
				TMM = layer.Data.calcTMM(sample.Frequency);
				flow = layer.Data.FlowFormulation;
				phi_cur = (1 * ~flow) + (layer.Data.Porosity * flow);
				for nf = 1:length(freq)
					TMM_cur = TMM{nf};
					if layer.Index == 1
						sample.TransferMatrix{nf} = ...
							[TMM_cur(1,1) TMM_cur(1,2)/phi_cur; ...
							 TMM_cur(2,1)*phi_cur TMM_cur(2,2)];
					else
						sample.TransferMatrix{nf} = sample.TransferMatrix{nf} * ...
							[TMM_cur(1,1) TMM_cur(1,2)/phi_cur; ...
							 TMM_cur(2,1)*phi_cur TMM_cur(2,2)];
					end
				end
				layer = layer.Next;
			end
		end
		
		% Calculate absorption coefficient for the sample.
		function calcSAC(sample)
			% Air parameters
			rho0 = 1.225; % Air density, kg/m3
			c0 = 343; % Sound speed, m/s
			Z0 = complex(rho0*c0); % Air impedance
			
			freq = sample.Frequency;
			sample.SAC = zeros(length(freq),1);
			phi = (1 * ~sample.FlowFormulation) + (sample.Porosity * sample.FlowFormulation);
			for nf = 1:length(freq)
				mat_whole = sample.TransferMatrix{nf};
				Zs = mat_whole(1,1)/mat_whole(2,1)/phi;
				R = (Zs-Z0)/(Zs+Z0);
				sample.SAC(nf,:) = 1-abs(R)^2;
			end
		end
		
		% Displays lattice and its constituent layers.
		function disp(list)
            fprintf('Cross Section:      %s\n',list.CrossSection);
            fprintf('Sample Diameter:    %dmm\n',list.l_sample);
			fprintf('Sample Thickness:   %.5fmm\n',list.t_sample);
            fprintf('Number of Layers:   %d\n',list.num_layers);
			fprintf('\n');
			fprintf('Lattice containing:\n');
			fprintf('\n');
			item = list.Head; count = 1;
            while ~isempty(item)
                fprintf('Layer Number:       %d\n',count);
				item.disp();
                item = item.Next; count = count + 1;
            end
        end
    end
end