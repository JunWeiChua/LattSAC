% TMM Formulation for SC Truss with circular cross section struts.

function alpha_TMM = MMC_strut(l_strut,d_strut,num_layers,delta_1,delta_2,f)
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
	S = (l_strut-d_strut)^2;
	P = 4*(l_strut-d_strut);
	r = 2*S/P; % Hydraulic radius.
	
	for nf = 1:length(f)
		omega = 2*pi*f(nf);
		k0 = complex(omega/c0);
		d = 2*r;
		sigma = (l_strut-d_strut)^2/l_strut^2;
		k = d*sqrt(rho0*omega/(4*eta));
		R_s = sqrt(2*eta*rho0*omega);
		for ilayer = 1:num_layers
			% Pore layer.
			if ilayer == 1
				t = d_strut/2/sqrt(2);
			else
				t = d_strut/sqrt(2);
			end
			Z = (32*eta*t)/(d^2*sigma)*(sqrt(1+k^2/32)+delta_1*R_s) + ...
				1i*(omega*rho0*t)/sigma*(1+(9+k^2/2)^(-1/2)+delta_2*d/t);
			mat_layer = [1 Z; 0 1];
			
			% Open cavity
			S = l_strut^2-pi*(d_strut/2)^2;
			h = l_strut-d_strut/sqrt(2);
			mat_layer = mat_layer * [cos(k0*h) 1i*Z0*sin(k0*h); 1i/Z0*sin(k0*h) cos(k0*h)];
			
			% Final layer.
			if ilayer == num_layers
				t = d_strut/2/sqrt(2);
				Z = (32*eta*t)/(d^2*sigma)*(sqrt(1+k^2/32)+delta_1*R_s) + ...
					1i*(omega*rho0*t)/sigma*(1+(9+k^2/2)^(-1/2)+delta_2*d/t);
				mat_layer = mat_layer * [1 Z; 0 1];
			end
			
			% Append to overall transfer matirx.
			if ilayer == 1
				mat_whole = mat_layer;
			else
				mat_whole = mat_whole * mat_layer;
			end
		end
		
		% For each frequency, find overall absorption coefficient.
		V_final=mat_whole(2,1)/mat_whole(1,1); %A and C in the final matrix.
		R =(1-Z0*V_final)/(1+Z0*V_final);
		alpha_TMM(nf,:)=1-abs(R)^2;
	end
end

% Unused codes.
% Chapter 4 of Allard book. Does not work for all frequencies.

% c = 1.07; % Square cross section.
% sigma_phi = 7*eta/r;
% s = c*sqrt(8*omega*rho0/sigma_phi);
% s_i = s*sqrt(-1i);
% Gc_Bs = -B*s_i/4*besselj(1,B*s_i)/besselj(0,B*s_i) / (1-2/(B*s_i)*besselj(1,B*s_i)/besselj(0,B*s_i));
% Gc_s = -s_i/4*besselj(1,s_i)/besselj(0,s_i) / (1-2/s_i*besselj(1,s_i)/besselj(0,s_i));
% F = 1/(1+sigma_phi/(1i*Pr*omega*rho0)*Gc_Bs);
% rho = rho0*(1+sigma_phi/(1i*omega*rho0)*Gc_s);
% K = gamma*P0/(gamma-((gamma-1)*F));
% Z = sqrt(rho*K);