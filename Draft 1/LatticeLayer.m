classdef LatticeLayer < UnitCell & IndexLinkedNode
    properties
		N_x				(1,1)	{mustBeNumeric}	= 0
		N_y				(1,1)	{mustBeNumeric}	= 0
		N_z				(1,1)	{mustBeNumeric}	= 0
		cross_section	string					= ""
		l_layer			(1,1)	{mustBeNumeric}	= 0
		w_layer			(1,1)	{mustBeNumeric}	= 0	
		t_layer			(1,1)	{mustBeNumeric}	= 0
    end
    
    methods
        function layer = LatticeLayer(idx,label,lcell,RD,shape,l,w,t)
			layer@IndexLinkedNode(idx);
			layer@UnitCell(label,lcell,RD);
			if nargin > 0
				layer.cross_section = shape;
				layer.l_layer = l;
				layer.w_layer = w;
				layer.t_layer = t;
				calcN(layer);
			end
        end
		
		function layer = calcN(layer)
			layer.N_x = ceil(layer.l_layer/layer.cell_length);
			layer.N_y = ceil(layer.w_layer/layer.cell_length);
			layer.N_z = floor(layer.t_layer/layer.cell_length);
			layer.t_layer = layer.N_z * layer.cell_length;
		end
		
		function layer = update(layer)
			% Check if N_x, N_y and N_z are integer values, update l, w, t accordingly.
			
		end
		
		% Calculate the transfer matrix for the layer given frequency range.
		function matrix = calcTMM(layer,freq)
			matrix = cell(length(freq),1);
			
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
			l_strut = layer.strut_length*1e-3 * layer.length_corr;
			d_strut = layer.strut_width*1e-3 * layer.width_corr;
			num_layers = layer.N_z;
			delta1 = layer.delta_1;
			delta2 = layer.delta_2;
					
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
				
				for ilayer = 1:num_layers
					% Pore layer.
					if ilayer == 1
						t = d_strut/2/sqrt(2);
					else
						t = d_strut/sqrt(2);
					end
					Z = (32*eta*t)/(d^2*sigma)*(sqrt(1+k^2/32)+delta1*R_s) + ...
						1i*(omega*rho0*t)/sigma*(1+(9+k^2/2)^(-1/2)+delta2*d/t);
					mat_layer = [1 Z; 0 1];
					
					% Open cavity
					S = l_strut^2-pi*(d_strut/2)^2;
					h = l_strut-d_strut/sqrt(2);
					mat_layer = mat_layer * [cos(k0*h) 1i*Z0*sin(k0*h); 1i/Z0*sin(k0*h) cos(k0*h)];
					
					% Final layer.
					if ilayer == num_layers
						t = d_strut/2/sqrt(2);
						Z = (32*eta*t)/(d^2*sigma)*(sqrt(1+k^2/32)+delta1*R_s) + ...
							1i*(omega*rho0*t)/sigma*(1+(9+k^2/2)^(-1/2)+delta2*d/t);
						mat_layer = mat_layer * [1 Z; 0 1];
					end
					
					% Append to overall transfer matirx.
					if ilayer == 1
						mat_whole = mat_layer;
					else
						mat_whole = mat_whole * mat_layer;
					end
				end
				matrix{nf,1} = mat_whole;
			end
		end
		
		function disp(layer)
			fprintf('Index:		%d\n',layer.Index);
            fprintf('Name:		%s\n',layer.name);
			fprintf('cell_length:	%.5f\n',layer.cell_length);
			fprintf('rel_density:	%.5f\n',layer.rel_density);
			fprintf('strut_length:	%.5f\n',layer.strut_length);
			fprintf('strut_width:	%.5f\n',layer.strut_width);
			fprintf('cross_section:	%s\n',layer.cross_section);
			fprintf('t_layer:	%.5f\n',layer.t_layer);
			fprintf('\n');
		end
    end
end