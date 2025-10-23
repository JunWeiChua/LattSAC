classdef LattLayer < LinkedList
    properties (SetAccess = protected)
		CrossSection	string						= ""
		l_layer			(1,1)	{mustBeNonnegative}	= 0
		w_layer			(1,1)	{mustBeNonnegative}	= 0	
		t_layer			(1,1)	{mustBeNonnegative}	= 0
		Frequency									= []
		TransferMatrix								= []
		Z_eff										= []
		k_eff										= []
		Porosity		(1,1)	{mustBeNonnegative}	= 0
		FlowFormulation {mustBeNumericOrLogical}	= false
    end
	
	methods
        function layer = LattLayer(c_section,freq)
			if nargin > 0
				layer.CrossSection = c_section;
				layer.Frequency = freq;
			end
        end
		
		function insertPart(layer,part,SR)
			if isempty(layer.Head)
				layer.insert(part,1);
				layer.CrossSection = part.CrossSection;
				layer.l_layer = part.l_part;
				layer.w_layer = part.w_part;
				layer.t_layer = part.t_part;
				part.setSR(1);
				layer.Porosity = part.Porosity;
				layer.checkFlow;
			else
				if layer.l_layer ~= part.l_part || layer.w_layer ~= part.w_part || ...
				   layer.CrossSection ~= part.CrossSection
					error('Dimensions do not match.');
				else
					cur = layer.Head;
					while ~isempty(cur)
						cur.Data.setSR(cur.Data.SurfaceRatio*(1-SR));
						cur = cur.Next;
					end
					layer.insert(part,layer.Length+1);
					part.setSR(SR);
					layer.checkFlow;
				end
			end
		end
		
		function removePart(layer,idx)
			part = layer.getNode(idx);
			SR = part.Data.SurfaceRatio;
			layer.remove(idx);
			cur = layer.Head;
			while ~isempty(cur)
				cur.Data.setSR(cur.Data.SurfaceRatio/(1-SR));
				cur = cur.Next;
			end
			layer.checkFlow;
		end
		
		function checkFlow(layer)
			cur = layer.Head; flow = 1;
			while ~isempty(cur)
				type = cur.Data.UnitCell.CellArch.CellType;
				flow = flow * (type == "Plate");
				cur = cur.Next;
			end
			layer.FlowFormulation = flow;
		end
		
		function changeParam(layer,cs,l,w)
			layer.CrossSection = cs;
			layer.l_layer = l;
			layer.w_layer = w;
			cur = layer.Head;
			while ~isempty(cur)
				cur.Data.setCS(layer.CrossSection);
				cur.Data.setL(layer.l_layer);
				cur.Data.setW(layer.w_layer);
				cur = cur.Next;
			end
		end
		
		function updateLayerThickness(layer,partUpdate)
			t = []; cur = layer.Head;
			while ~isempty(cur)
				t = [t cur.Data.t_part];
				cur = cur.Next;
			end
			layer.t_layer = max(t);
			if partUpdate
				layer.updatePartThickess();
			end
		end
		
		function updatePartThickess(layer)
			cur = layer.Head;
			while ~isempty(cur)
				cur.Data.setT(layer.t_layer);
				cur = cur.Next;
			end
		end
		
		function updatePorosity(layer)
			cur = layer.Head; phi = 0;
			while ~isempty(cur)
				phi = phi + cur.Data.Porosity*cur.Data.SurfaceRatio;
				cur = cur.Next;
			end
			layer.Porosity = phi;
		end
		
		function updateSurfaceRatio(layer)
			cur = layer.Head; SR_total = 0;
			while ~isempty(cur)
				SR_total = SR_total + cur.Data.SurfaceRatio;
				cur = cur.Next;
			end
			
			cur = layer.Head;
			while ~isempty(cur)
				cur.Data.setSR(cur.Data.SurfaceRatio/SR_total);
				cur = cur.Next;
			end
		end
		
		function cp = copyLayer(layer)
			cp = LattLayer(layer.CrossSection,layer.Frequency);
			cur = layer.Head;
			while ~isempty(cur)
				part_cp = copyPart(cur.Data);
				cp.insertPart(part_cp,cur.Data.SurfaceRatio);
				cur = cur.Next;
			end
			cp.checkFlow;
		end
		
		% Calculate the transfer matrix for the layer given frequency range.
		function matrix = calcTMM(layer,freq)
			layer.Frequency = freq;
			layer.TransferMatrix = cell(length(freq),1);
			
			if layer.Length == 1
				part = layer.Head.Data;
				layer.TransferMatrix = part.calcTMM(freq);
			else
				cur = layer.Head;
				while ~isempty(cur)
					part = cur.Data;
					mat = part.calcTMM(freq);
					cur = cur.Next;
				end
				
				for nf = 1:length(freq)
					cur = layer.Head;
					ry = zeros(2,2);
					while ~isempty(cur)
						part = cur.Data;
						TMM = part.TransferMatrix{nf,1};
						r = part.SurfaceRatio;
						
						% Calculate admittance matrix
						AM = [TMM(2,2)	TMM(2,1)*TMM(1,2)-TMM(2,2)*TMM(1,1); ...
							  1			-TMM(1,1)] ...
							  /TMM(1,2);
						
						% Calculate the products of sum(r_i*y_i,ab).
						ry = ry + r*AM;
						
						cur = cur.Next;
					end
					% Calculates the final transfer matrix for parallel assembly. Refer to Verdie`re et al.
					layer.TransferMatrix{nf} = ...
						[(-1)*ry(2,2) 					1 ; ...
						ry(1,2)*ry(2,1)-ry(2,2)*ry(1,1) ry(1,1)]/ ry(2,1);
				end
			end
			matrix = layer.TransferMatrix;
			layer.calcZ;
			layer.calck;
		end
		
		% Calculate the effective charactereistic impedance.
		function calcZ(layer)
			freq = layer.Frequency;
			for idx = 1:length(freq)
				TM = layer.TransferMatrix{idx};
				Z_eff{idx} = sqrt(TM(1,2)/TM(2,1));
			end
		end
		
		% Calculate the effective wavenumber.
		function calck(layer)
			freq = layer.Frequency;
			for idx = 1:length(freq)
				TM = layer.TransferMatrix{idx};
				k_eff{idx} = acos((TM(1,1)/TM(2,2))/2)/(layer.t_layer*1e-3);
			end
		end
		
		% Displays lattice layer and its constituent parts.
		function disp(list)
            disp('Lattice Layer containing:');
            item = list.Head;
            while ~isempty(item)
                item.disp();
                item = item.Next;
            end
        end
    end
end