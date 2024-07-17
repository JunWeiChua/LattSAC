classdef LattPartTPMS < LattLayerPart
    methods
        function part = LattPartTPMS(label,network,lcell,RD,shape,l,w,Nz)
			if nargin > 0
				part.UnitCell = UnitCellTPMS(label,network,lcell,RD);
				part.CrossSection = shape;
				part.l_part = l;
				part.w_part = w;
				part.N_z = Nz;
				part.updateXYZ();
				part.Porosity = 1-RD;
			end
        end
		
		function changeUC(part,label,network)
			part.UnitCell = ...
				UnitCellTPMS(label,network,part.UnitCell.cell_length,part.UnitCell.rel_density);
			part.updateXYZ();
		end
		
		function cp = copyPart(part)
			cp = LattPartTPMS(part.UnitCell.CellArch.Name, ...
				part.UnitCell.CellArch.Network, ...
				part.UnitCell.cell_length,part.UnitCell.rel_density, ...
				part.CrossSection,part.l_part,part.w_part,part.N_z);
			cp.setSR(part.SurfaceRatio);
		end
		
		% Calculate the transfer matrix for the part given frequency range.
		function matrix = calcTMM(part,freq)
			part.Frequency = freq;
			part.TransferMatrix = cell(length(freq),1);
			h_layer = part.t_part*1e-3;
			
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
			
			for nf = 1:length(freq)
				[rho_JCAL,K_JCAL,Zc_JCAL,k_JCAL] = ...
					JCAL_model(freq(nf),part.UnitCell.sigma,part.UnitCell.phi, ...
					part.UnitCell.alpha_inf,part.UnitCell.viscous_length, ...
					part.UnitCell.thermal_length,part.UnitCell.k0_prime);
				
				TM_layer = [cos(k_JCAL*h_layer) 1i*Zc_JCAL*sin(k_JCAL*h_layer); ...
					    1i/Zc_JCAL*sin(k_JCAL*h_layer) cos(k_JCAL*h_layer)];
				part.TransferMatrix{nf,1} = TM_layer;
			end
			matrix = part.TransferMatrix;
			
			% Johnson-Champoux-Allard-Lafarge (JCAL) model.
			function [rho,K,Zc,k] = JCAL_model(freq,sigma,phi,alpha_inf,viscous_length,thermal_length,k0_prime)
				% Air parameters
				rho0 = 1.225; % Air density, kg/m3
				c0 = 343; % Sound speed, m/s
				Z0 = complex(rho0*c0); % Air impedance
				P0 = 101325; %atmospheric pressure
				Cp = 1005;
				Cv = 718;
				gamma = Cp/Cv; %specific heat ratio
				eta = 1.8444e-5; %air viscosity
				kappa = 0.0260; %Thermal Conductivity
				Pr = 0.71465; %Prandtl
				nu = eta/rho0;
				nu_prime = nu/Pr;
				B = sqrt(Pr);
				
				omega = 2*pi*freq;
				rho = alpha_inf*rho0/phi .* (1 + sigma*phi./(1i*omega*rho0*alpha_inf) .* ...
					sqrt(1 + 1i .* (4*alpha_inf^2*eta*rho0*omega)./(sigma^2*viscous_length^2*phi^2)));
				K = (gamma*P0/phi) ./ (gamma - (gamma-1)./(1-1i*phi*kappa./(k0_prime*Cp*rho0*omega) .* ...
					sqrt(1 + 1i .* (4*k0_prime^2*Cp*rho0*omega)./(kappa*thermal_length^2*phi^2))));
				% alpha_visc = alpha_inf + (phi*sigma)./(1i*omega*rho0).* ...
					% sqrt(1 + ((2*alpha_inf*eta)/(viscous_length*phi*sigma))^2 .* (1i*omega)/nu);
				% alpha_ther = 1 + (nu_prime*phi)./(1i*omega*k0_prime) .* ...
					% sqrt(1 + ((2*k0_prime)/(phi*thermal_length))^2 .* (1i*omega)/nu_prime);
				% rho = rho0*alpha_visc;
				% K = P0./(1-(gamma-1)./(gamma*alpha_ther));
				Zc = sqrt(rho.*K);
				k = omega.*sqrt(rho./K);
			end
		end
		
		function disp(layer)
            fprintf('Name:          %s\n',layer.UnitCell.CellArch.Name);
			fprintf('Cell Type:  	%s\n',layer.UnitCell.CellArch.CellType);
			fprintf('Cell Length:   %.5f\n',layer.UnitCell.cell_length);
			fprintf('Rel Density:   %.5f\n',layer.UnitCell.rel_density);
			fprintf('Isovalue:		%.5f\n',layer.UnitCell.isovalue);
			fprintf('Cross Section: %s\n',layer.CrossSection);
			fprintf('# layers:      %.0f\n',layer.N_z);
			fprintf('Surface Ratio: %.1f\n',layer.SurfaceRatio);
			fprintf('\n');
		end
    end
end