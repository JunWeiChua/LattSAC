classdef LattPartStrut < LattLayerPart
    methods
        function part = LattPartStrut(label,lcell,RD,shape,l,w,Nz)
			if nargin > 0
				part.UnitCell = UnitCellStrut(label,lcell,RD);
				part.CrossSection = shape;
				part.l_part = l;
				part.w_part = w;
				part.N_z = Nz;
				part.updateXYZ();
				part.Porosity = 1-RD;
			end
        end
		
		function changeUC(part,label)
			part.UnitCell = ...
				UnitCellStrut(label,part.UnitCell.cell_length,part.UnitCell.rel_density);
			part.updateXYZ();
		end
		
		function cp = copyPart(part)
			cp = LattPartStrut(part.UnitCell.CellArch.Name, ...
				part.UnitCell.cell_length,part.UnitCell.rel_density, ...
				part.CrossSection,part.l_part,part.w_part,part.N_z);
			cp.setSR(part.SurfaceRatio);
		end
		
		% Calculate the transfer matrix for the part given frequency range.
		function matrix = calcTMM(part,freq)
			part.Frequency = freq;
			part.TransferMatrix = cell(length(freq),1);
			
			% Air parameters
			rho0 = 1.225; % Air density, kg/m3
			c0 = 343; % Sound speed, m/s
			Z0 = complex(rho0*c0); % Air impedance
			P0 = 101325; %atmospheric pressure
			gamma = 1.4; %specific heat ratio
			eta = 1.8444e-5; %air viscosity
			Pr = 0.71465; %Prandtl
			nu = eta/rho0;
			nu_prime = nu/Pr;
			B = sqrt(Pr);
			
			% Obtain values from the lattice structure array.
			l_strut = part.UnitCell.strut_length*1e-3 * part.UnitCell.CellArch.length_corr;
			d_strut = part.UnitCell.strut_width*1e-3 * part.UnitCell.CellArch.width_corr;
			num_layers = part.N_z;
			delta1 = part.UnitCell.delta_1;
			delta2 = part.UnitCell.delta_2;
					
			for nf = 1:length(freq)
				omega = 2*pi*freq(nf);
				k0 = complex(omega/c0);
				S = (l_strut-d_strut)^2;
				P = 4*(l_strut-d_strut);
				r = 2*S/P; % Hydraulic radius.
				d = 2*r;
				sigma = (l_strut-d_strut)^2/l_strut^2;
				k = d*sqrt(rho0*omega/(4*eta));
				R_s = sqrt(2*eta*rho0*omega);
				
				% Cavity layer modelled as open air layer.
				D = l_strut-d_strut/sqrt(2);
				TM_air = [cos(k0*D) 1i*Z0*sin(k0*D); 1i/Z0*sin(k0*D) cos(k0*D)];
				
				% Pore layer modelled as MPP.
				t = d_strut/2/sqrt(2);
				Z = (32*eta*t)/(d^2*sigma)*(sqrt(1+k^2/32)+delta1*R_s) + ...
					1i*(omega*rho0*t)/sigma*(1+(9+k^2/2)^(-1/2)+delta2*d/t);
				TM_pore = [1 Z; 0 1];
				
				% Overall transfer matrix.
				for layer = 1:num_layers
					TM_layer = TM_pore*TM_air*TM_pore;
					if layer == 1
						TM_whole = TM_layer;
					else
						TM_whole = TM_whole * TM_layer;
					end
				end
				part.TransferMatrix{nf,1} = TM_whole;
			end
			matrix = part.TransferMatrix;
		end
		
		function disp(layer)
            fprintf('Name:          %s\n',layer.UnitCell.CellArch.Name);
			fprintf('Cell Type:     %s\n',layer.UnitCell.CellArch.CellType);
			fprintf('Cell Length:   %.5f\n',layer.UnitCell.cell_length);
			fprintf('Rel Density:   %.5f\n',layer.UnitCell.rel_density);
			fprintf('Strut Length:  %.5f\n',layer.UnitCell.strut_length);
			fprintf('Strut Width:   %.5f\n',layer.UnitCell.strut_width);
			fprintf('Cross Section: %s\n',layer.CrossSection);
			fprintf('# layers:      %.0f\n',layer.N_z);
			fprintf('Surface Ratio: %.1f\n',layer.SurfaceRatio);
			fprintf('\n');
		end
    end
end