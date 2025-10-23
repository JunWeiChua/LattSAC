%% Function to optimize SAC of a heterogeneous lattice within a target frequency range.

function Latt = OptimizeSAC(Type,cellArchList,Freq,FreqFull,CrossSection,SampleDiameter,Ht,lb,ub,intcon,NumIter)
	Latt = LatticeLib(); num_sol = 0;
	for iter = 1:NumIter
		% Create function handles to the objective functions.
		objconstr = @(param)SAC_Maximise(param,Type,cellArchList,Freq,FreqFull,CrossSection,SampleDiameter,Ht);

		% Constraints.
		A = [];
		b = [];
		Aeq = [];
		beq = [];
		% lb = [];
		% ub = [];
		% intcon = [];
		options = optimoptions('surrogateopt','PlotFcn','surrogateoptplot',...
			'InitialPoints',[],'ConstraintTolerance',0, ...
			'MinSurrogatePoints',25*size(Type,1),'MaxFunctionEvaluations',100*size(Type,1));

		[ParamOptimzed,fval,exitflag,output] = surrogateopt(objconstr,lb,ub,intcon,A,b,Aeq,beq,options);
		if fval > -2
			num_sol = num_sol + 1;
			
			Sample = createLattice(ParamOptimzed,Type,cellArchList,FreqFull,CrossSection,SampleDiameter);
			Sample.calcTMM();
			Sample.calcSAC();
			
			Latt.insert(Sample,num_sol);
		end
	end
	
	function mean_SAC = SAC_Maximise(param,Type,cellArchList,Freq,FreqFull,CrossSection,SampleDiameter,Ht)
		% ** Strut lattice.
		% param:
		% UC = unit cell (Integer) (1 <= x <= 7)
		% CS = cell size (4<= x <= 8)
		% RD = relative density (0.2 <= x <= 0.4)
		% Nz = Number of layers (Integer) (x >= 1)
		%
		% ** Plate lattice.
		% param:
		% UC = unit cell (Integer) (1 <= x <= 3)
		% CS = cell size (4<= x <= 8)
		% RD = relative density (0.2 <= x <= 0.4)
		% Hole = hole precent (0.3 <= x <= 0.6)
		% Nz = Number of layers (Integer) (x >= 1)
		% 
		% ** TPMS lattice.
		% param:
		% UC = unit cell (Integer) (1 <= x <= 4)
		% Network = network (Integer) (1 <= x <= 2)
		% CS = cell size (4<= x <= 8)
		% RD = relative density (0.2 <= x <= 0.4)
		% Nz = Number of layers (Integer) (x >= 1)
		% 
		% Constants:
		% Type: Unit Cell Types for each layer. (Nx1 vector)
		% Freq
		% CrossSection
		% SampleDiameter
		% Ht = Height Limit
		
		N_layers = size(Type,1);
		
		% Create lattice and calculate SAC.
		Sample = createLattice(param,Type,cellArchList,FreqFull,CrossSection,SampleDiameter);
		Sample.calcTMM();
		Sample.calcSAC();
		alpha = Sample.SAC;
		freq_target = find(FreqFull>=Freq(1) & FreqFull<=Freq(end));
		
		% Optimise for target freq range only.
		score = mean(alpha(freq_target))*100;
		mean_SAC.Fval = 1/score;
		
		% Optimise for whole freq range, with emphasis on target freq range.
		% alpha_factor = 10;
		% alpha(freq_target) = alpha(freq_target)*alpha_factor;
		% alpha_max = (length(freq_target)*alpha_factor+(length(FreqFull)-length(freq_target))*1)/length(FreqFull);
		% score = 100*mean(alpha)/alpha_max;
		% mean_SAC.Fval = 1/score;
		
		% Inequality constraints
		N_ineq = 1;
		mean_SAC.Ineq(N_ineq) = Sample.t_sample - Ht; % Sample Height
		cur = Sample.Head;
		while ~isempty(cur)
			Layer = cur.Data;
			Part = Layer.Head.Data;
			Type = Part.UnitCell.CellArch.CellType;
			UC = Part.UnitCell.CellArch.Name;
			switch Type
				case 'Plate'
					N_ineq = N_ineq + 1;
					HoleSize = Part.UnitCell.d_hole;
					Thickness = Part.UnitCell.t_plate;
					switch UC
						case "SC-Plate" % SC-Plate
							mean_SAC.Ineq(N_ineq) = 1.0 - (HoleSize-Thickness);
						case "BCC-Plate" % BCC-Plate
							mean_SAC.Ineq(N_ineq) = 1.6 - (HoleSize-Thickness);
						case "FCC-Plate" % FCC-Plate
							mean_SAC.Ineq(N_ineq) = 1.2 - (HoleSize-Thickness);
					end
			end
			cur = cur.Next;
		end
	end
	
	% Function to create lattice.
	function Sample = createLattice(param,Type,cellArchList,FreqFull,CrossSection,SampleDiameter)
		load('Unit Cell Architecture','cellArchLib');
		Sample = Lattice(CrossSection,FreqFull);
		ParamIdx = 0;
		for idx_layer = 1:size(Type,1);
			switch Type(idx_layer)
				case 'Strut'
					UC = param(:,ParamIdx+1);
					CS = param(:,ParamIdx+2);
					RD = param(:,ParamIdx+3);
					Nz = param(:,ParamIdx+4);
					
					StrutLattList = cellArchList{idx_layer,1};
					Cell = cellArchLib.findCellArch("Strut",StrutLattList(round(UC)));
					Part = LattPartStrut(Cell.Name,CS,RD,CrossSection,SampleDiameter,SampleDiameter,Nz);
					
					ParamIdx = ParamIdx + 4;
				case 'Plate'
					UC = param(:,ParamIdx+1);
					CS = param(:,ParamIdx+2);
					RD = param(:,ParamIdx+3);
					Hole = param(:,ParamIdx+4);
					Nz = param(:,ParamIdx+5);
					
					PlateLattList = cellArchList{idx_layer,1};
					Cell = cellArchLib.findCellArch("Plate",PlateLattList(round(UC)));
					Part = LattPartPlate(Cell.Name,CS,RD,Hole,CrossSection,SampleDiameter,SampleDiameter,Nz);
					
					ParamIdx = ParamIdx + 5;
				case 'TPMS'
					UC = param(:,ParamIdx+1);
					Network = param(:,ParamIdx+2);
					CS = param(:,ParamIdx+3);
					RD = param(:,ParamIdx+4);
					Nz = param(:,ParamIdx+5);
					
					TPMSLattList = cellArchList{idx_layer,1};
					TPMSNetList = cellArchList{idx_layer,2};
					Cell = cellArchLib.findCellArch("TPMS",TPMSLattList(round(UC)),TPMSNetList(round(Network)));
					Part = LattPartTPMS(Cell.Name,Cell.Network,CS,RD,CrossSection,SampleDiameter,SampleDiameter,Nz);
					
					ParamIdx = ParamIdx + 5;
			end
			Layer = LattLayer(CrossSection,FreqFull);
			Layer.insertPart(Part,1);
			Sample.insertLayer(Layer,idx_layer);
		end
		Sample.updateThickness(1);
	end
end