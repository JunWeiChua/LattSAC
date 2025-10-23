classdef LattPartPlate < LattLayerPart
    methods
        function part = LattPartPlate(label,lcell,RD,c2h,shape,l,w,Nz)
			if nargin > 0
				part.UnitCell = UnitCellPlate(label,lcell,RD,c2h);
				part.CrossSection = shape;
				part.l_part = l;
				part.w_part = w;
				part.N_z = Nz;
				part.updateXYZ();
				part.Porosity = 1-RD;
			end
        end
		
		function changeUC(part,label)
			part.UnitCell = UnitCellPlate(label,part.UnitCell.cell_length, ...
				part.UnitCell.rel_density,part.UnitCell.hole_percent);
			part.updateXYZ();
		end
		
		function cp = copyPart(part)
			cp = LattPartPlate(part.UnitCell.CellArch.Name, ...
				part.UnitCell.cell_length,part.UnitCell.rel_density,part.UnitCell.hole_percent, ...
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
			K_0 = gamma*P0;
			
			% Obtain values from the lattice structure array.
			t_plate = part.UnitCell.t_plate*1e-3 * part.UnitCell.CellArch.t_corr;
			d_hole = part.UnitCell.d_hole*1e-3 * part.UnitCell.CellArch.d_corr;
			s_cell = part.UnitCell.cell_length*1e-3 * part.UnitCell.CellArch.s_corr;
			num_layers = part.N_z;
			delta1 = part.UnitCell.delta_1;
			delta2 = part.UnitCell.delta_2;
					
			for nf = 1:length(freq)
				omega = 2*pi*freq(nf);
				k0 = complex(omega/c0);
				R_s = sqrt(2*eta*rho0*omega);
					
				% Map lattice parameters to MPP theory parameters.
				d = d_hole-t_plate;
				T = t_plate;
				D_eff = s_cell-t_plate;
				sigma = pi*(d/2)^2/s_cell^2;
				k = d*sqrt(rho0*omega/(4*eta));
				
				% Cavity layer modelled as circular duct. (Equations 4.57, 4.62 to 4.65.)
				[rho_f,K_f,Z_air,k_air] = duct_acoustics(D_eff,omega,"Square");
				h = D_eff/2;
				TM_air = [cos(k_air*h) 1i*Z_air*sin(k_air*h); 1i/Z_air*sin(k_air*h) cos(k_air*h)];
				
				% Pore layer modelled as MPP.
				t = T;
				Z = (32*eta*t)/(d^2*sigma)*(sqrt(1+k^2/32)+delta1*R_s) + ...
					1i*(omega*rho0*t)/sigma*(1+(9+k^2/2)^(-1/2)+delta2*d/t);
				TM_pore = [1 Z; 0 1];
				
				% Overall transfer matrix.
				for layer = 1:num_layers
					TM_layer = TM_air*TM_pore*TM_air;
					if layer == 1
						TM_whole = TM_layer;
					else
						TM_whole = TM_whole * TM_layer;
					end
				end
				part.TransferMatrix{nf,1} = TM_whole;
			end
			matrix = part.TransferMatrix;
			
			function [rho,K,Z,k] = duct_acoustics(d,omega,shape)
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
				K0 = gamma*P0;
				
				if shape == "Circular"
					G_rho = sqrt(-1i*omega*rho0/eta);
					G_K = sqrt(-1i*omega*Pr*rho0/eta);
					r = d/2;
					rho = rho0/(1-2/(r*G_rho)*besselj(1,r*G_rho,1)/besselj(0,r*G_rho,1));
					K = K0/(1+2*(gamma-1)/(r*G_K)*besselj(1,r*G_K,1)/besselj(0,r*G_K,1));
				else
					c = sqrt(8/7);
					r = 2*(d^2)/(4*d);
					sigma_phi = 7*eta/r;
					s = c*sqrt(8*omega*rho0/sigma_phi);
					s_i = s*sqrt(-1i);
					
					Gc_s = -(s_i/4)*besselj(1,s_i,1)/besselj(0,s_i,1) / ...
						(1-2/s_i*besselj(1,s_i,1)/besselj(0,s_i,1));
					Gc_Bs = -(sqrt(Pr)*s_i/4)*besselj(1,sqrt(Pr)*s_i,1)/besselj(0,sqrt(Pr)*s_i,1) / ...
						(1-2/sqrt(Pr)*s_i*besselj(1,sqrt(Pr)*s_i,1)/besselj(0,sqrt(Pr)*s_i,1));
					
					rho = rho0*(1+sigma_phi/(1i*omega*rho0)*Gc_s);
					K = K0/(gamma-(gamma-1)/(1+sigma_phi/(1i*Pr*omega*rho0)*Gc_Bs));
					
					% n_terms = 10;
					% sum_rho = 0; sum_K = 0;
					% for m = 1:n_terms
						% for n = 1:n_terms
							% alpha = (2*m+1)*pi/d;
							% beta = (2*n+1)*pi/d;
							% sum_rho = sum_rho + 1/(alpha^2*beta^2*(alpha^2+beta^2-G_rho^2));
							% sum_K = sum_K + 1/(alpha^2*beta^2*(alpha^2+beta^2-G_K^2));
						% end
					% end
					% rho = rho0*(d/2)^4/(4*G_rho^2*(-1)*sum_rho);
					% K = K0/(gamma+(4*(gamma-1)*G_K^2)/((d/2)^4)*sum_K);
				end
				Z = sqrt(rho*K);
				k = omega*sqrt(rho/K);
			end	
		end
		
		function disp(layer)
            fprintf('Name:          		%s\n',layer.UnitCell.CellArch.Name);
			fprintf('Cell Type:		%s\n',layer.UnitCell.CellArch.CellType);
			fprintf('Cell Length:		%.5f\n',layer.UnitCell.cell_length);
			fprintf('Rel Density:		%.5f\n',layer.UnitCell.rel_density);
			fprintf('Hole Diameter:		%.5f\n',layer.UnitCell.d_hole);
			fprintf('Plate Thickness:	%.5f\n',layer.UnitCell.t_plate);
			fprintf('Hole Diameter (1mm):	%.5f\n',layer.UnitCell.d_hole/layer.UnitCell.cell_length);
			fprintf('Plate Thickness (1mm):	%.5f\n',layer.UnitCell.t_plate/layer.UnitCell.cell_length);
			fprintf('Cross Section: 		%s\n',layer.CrossSection);
			fprintf('# layers:      		%.0f\n',layer.N_z);
			fprintf('Surface Ratio: 		%.1f\n',layer.SurfaceRatio);
			fprintf('\n');
		end
    end
end