classdef UnitCellTPMS < handle
    properties (SetAccess = protected)
		CellArch		% CellArchTPMS Object
		cell_length		(1,1)	{mustBeNonnegative}	= 0
		rel_density		(1,1)	{mustBeNonnegative}	= 0
		isovalue		(1,1)						= 0
		surface_area	(1,1)	{mustBeNonnegative}	= 0
		volume			(1,1)	{mustBeNonnegative}	= 0
		sigma			(1,1)	{mustBeNonnegative}	= 0
		phi				(1,1)	{mustBeNonnegative}	= 0
		alpha_inf		(1,1)	{mustBeNonnegative}	= 0
		viscous_length	(1,1)	{mustBeNonnegative}	= 0
		thermal_length	(1,1)	{mustBeNonnegative}	= 0
		k0_prime		(1,1)	{mustBeNonnegative}	= 0
    end
    
    methods
		function unitCell = UnitCellTPMS(label,network,lcell,RD)
			if nargin > 0
				load('Unit Cell Architecture.mat');
				cellArch = cellArchLib.findCellArch("TPMS",label,network);
				unitCell.CellArch = cellArch;
				unitCell.cell_length = lcell;
				unitCell.rel_density = RD;
				unitCell.calcAreaVolume();
				unitCell.calcJCALParam();
			end
		end
		
		function calcAreaVolume(unitCell)
			TPMS = unitCell.CellArch.Name;
			cellSize = unitCell.cell_length*1e-3;
			if unitCell.CellArch.Network == "Sheet"
				phase = 1;
			else
				phase = 0;
			end
			
			Nx = 1; Ny = 1; Nz = 1;
			N_Cell = Nx*Ny*Nz;
			numPts = 50;
			isovalue = 0;
			
			Model = unitCell.CellArch.IsovalueModel;
			tStart = Model(unitCell.rel_density);
			
			[x,y,z,volumeDataInt] = TPMS_volumeDataInt(TPMS,cellSize,Nx,Ny,Nz,numPts);
			% Type of the TPMS lattice
			if phase == 0
				volumeData = volumeDataInt - tStart;
			else
				volumeData = volumeDataInt.^2 - tStart.^2;
			end

			% Creating isosurface faces and vertices
			% f, v represent faces and vertices in separate structs
			% Isosurface() creates surface at all points in space equal to the isovalue, 
			% based on the points in domain and the function being modeled
			
			[f,v] = isosurface(x,y,z,volumeData,isovalue);
			[f2,v2,c2] = isocaps(x,y,z,volumeData,isovalue, 'enclose', 'below');
			% enclose 'above' is the default, below gives the correct thin-walled
			% structure though, since the 3d domain is negative in that region
			
			% Isocaps faces and vertices
			f3 = [f ; f2+length(v(:,1))];
			v3 = [v ; v2];
			
			% Measure volume fraction and surface area
			totalVolume = TPMSVolume(v3',f3');
			volFrac = totalVolume/(N_Cell*(cellSize)^3);
			
			unitCell.isovalue = tStart;
			unitCell.surface_area = abs(TPMSSurfaceArea(v3',f3'))/N_Cell;
			unitCell.volume = totalVolume/N_Cell;
			
			function [x,y,z,volumeDataInt] = TPMS_volumeDataInt(TPMS,cellSize,Nx,Ny,Nz,numPts)
				scale = 2*pi/cellSize;
				sizePts = 1/numPts;
				
				[x,y,z] = meshgrid(-Nx*cellSize/2:sizePts*cellSize:Nx*cellSize/2, ...
								   -Ny*cellSize/2:sizePts*cellSize:Ny*cellSize/2, ...
								   -Nz*cellSize/2:sizePts*cellSize:Nz*cellSize/2);
							   
				cx = cos(x*scale); cy = cos(y*scale); cz = cos(z*scale);
				sx = sin(x*scale); sy = sin(y*scale); sz = sin(z*scale);
				c2x = cos(2*x*scale); c2y = cos(2*y*scale); c2z = cos(2*z*scale);
				s2x = sin(2*x*scale); s2y = sin(2*y*scale); s2z = sin(2*z*scale);

				switch TPMS
					case 'Primitive' % Schwarz Primitive
						volumeData = cx+cy+cz;
					case 'Gyroid' % Schoen Gyroid
						volumeData = sx.*cy + sy.*cz + sz.*cx;
					case 'Diamond' % Schwarz Diamond
						volumeData = cx.*cy.*cz + sx.*sy.*cz + sx.*cy.*sz + cx.*sy.*cz;
					case 'I-WP' % Schoen I-WP
						volumeData = 2.*(cx.*cy + cy.*cz + cz.*cx) - (c2x + c2y + c2z);
					case 'Fischer Koch S' % Fischer Koch S
						volumeData = c2x.*sy.*cz + cx.*c2y.*sz + sx.*cy.*c2z;
					case 'F-RD' % Schoen F-Rhombic Dodecahedra (F-RD)
						volumeData = 4.*(cx.*cy.*cz)-(c2x.*c2y + c2y.*c2z + c2z.*c2x);
					case 'Neovious' % Neovious
						volumeData = 3.*(cx+cy+cz) + 4.*cx.*cy.*cz;
					otherwise
						error('Incorrect TPMS Input');
				end
				volumeDataInt = volumeData;
			end

			function totalArea = TPMSSurfaceArea(p,t)
				% Compute the vectors d13 and d12
				d13= [(p(1,t(2,:))-p(1,t(3,:))); (p(2,t(2,:))-p(2,t(3,:)));  (p(3,t(2,:))-p(3,t(3,:)))];
				d12= [(p(1,t(1,:))-p(1,t(2,:))); (p(2,t(1,:))-p(2,t(2,:))); (p(3,t(1,:))-p(3,t(2,:)))];
				cr = cross(d13,d12,1);%cross-product (vectorized)
				area = 0.5*sqrt(cr(1,:).^2+cr(2,:).^2+cr(3,:).^2);% Area of each triangle
				totalArea = sum(area);
			end

			function totalVolume = TPMSVolume(p,t)
				% Given a surface triangulation, compute the volume enclosed using
				% divergence theorem.
				% Assumption:Triangle nodes are ordered correctly, i.e.,computed normal is outwards
				% Input: p: (3xnPoints), t: (3xnTriangles)
				% Output: total volume enclosed, and total area of surface  
				% Author: K. Suresh; suresh@engr.wisc.edu

				% Compute the vectors d13 and d12
				d13= [(p(1,t(2,:))-p(1,t(3,:))); (p(2,t(2,:))-p(2,t(3,:)));  (p(3,t(2,:))-p(3,t(3,:)))];
				d12= [(p(1,t(1,:))-p(1,t(2,:))); (p(2,t(1,:))-p(2,t(2,:))); (p(3,t(1,:))-p(3,t(2,:)))];
				cr = cross(d13,d12,1);%cross-product (vectorized)
				area = 0.5*sqrt(cr(1,:).^2+cr(2,:).^2+cr(3,:).^2);% Area of each triangle
				crNorm = sqrt(cr(1,:).^2+cr(2,:).^2+cr(3,:).^2);
				zMean = (p(3,t(1,:))+p(3,t(2,:))+p(3,t(3,:)))/3;
				nz = -cr(3,:)./crNorm;% z component of normal for each triangle
				volume = area.*zMean.*nz; % contribution of each triangle
				totalVolume = sum(volume);%divergence theorem
			end

			function [totalVolume,totalArea] = stlVolume(p,t)
				% Given a surface triangulation, compute the volume enclosed using
				% divergence theorem.
				% Assumption:Triangle nodes are ordered correctly, i.e.,computed normal is outwards
				% Input: p: (3xnPoints), t: (3xnTriangles)
				% Output: total volume enclosed, and total area of surface  
				% Author: K. Suresh; suresh@engr.wisc.edu

				% Compute the vectors d13 and d12
				d13= [(p(1,t(2,:))-p(1,t(3,:))); (p(2,t(2,:))-p(2,t(3,:)));  (p(3,t(2,:))-p(3,t(3,:)))];
				d12= [(p(1,t(1,:))-p(1,t(2,:))); (p(2,t(1,:))-p(2,t(2,:))); (p(3,t(1,:))-p(3,t(2,:)))];
				cr = cross(d13,d12,1);%cross-product (vectorized)
				area = 0.5*sqrt(cr(1,:).^2+cr(2,:).^2+cr(3,:).^2);% Area of each triangle
				totalArea = sum(area);
				crNorm = sqrt(cr(1,:).^2+cr(2,:).^2+cr(3,:).^2);
				zMean = (p(3,t(1,:))+p(3,t(2,:))+p(3,t(3,:)))/3;
				nz = -cr(3,:)./crNorm;% z component of normal for each triangle
				volume = area.*zMean.*nz; % contribution of each triangle
				totalVolume = sum(volume);%divergence theorem
			end
		end
		
		function calcJCALParam(unitCell)
			x_train = [unitCell.cell_length unitCell.rel_density];
			sum_square = sum(x_train.^2,2);
			
			model = unitCell.CellArch.FlowResistivityModel;
			unitCell.sigma = model(x_train);
			
			unitCell.phi = (1-unitCell.rel_density) * ...
				unitCell.CellArch.phi_corr;
			
			model = unitCell.CellArch.TortuosityModel;
			unitCell.alpha_inf = model(x_train);
			
			model = unitCell.CellArch.ViscousLengthModel;
			unitCell.viscous_length = model(x_train);
			
			unitCell.thermal_length = 2*unitCell.volume./unitCell.surface_area * ...
				unitCell.CellArch.thermal_corr;
			
			model = unitCell.CellArch.ThermalPermeabilityModel;
			unitCell.k0_prime = predict(model,[x_train sum_square])*1e-9;
		end
		
		function changeUC(unitCell,label)
			load('Unit Cell Architecture.mat');
			cellArch = cellArchLib.findCellArch(label,network);
			unitCell.CellArch = cellArch;
			unitCell.calcAreaVolume();
			unitCell.calcJCALParam();
		end
		
		function setLcell(unitCell,lcell)
			unitCell.cell_length = lcell;
			unitCell.calcAreaVolume();
			unitCell.calcJCALParam();
		end
		
		function setRD(unitCell,RD)
			unitCell.rel_density = RD;
			unitCell.calcAreaVolume();
			unitCell.calcJCALParam();
		end
		
		function cp = copyUC(unitCell)
			cp = UnitCellTPMS(unitCell.CellArch.Name, ...
				unitCell.CellArch.Network, ...
				unitCell.cell_length,unitCell.rel_density);
		end
		
		function disp(unitCell)
			fprintf('S/N:		%d\n',unitCell.CellArch.SN);
            fprintf('Name:		%s\n',unitCell.CellArch.Name);
			fprintf('Cell Type:  %s\n',unitCell.CellArch.CellType);
			fprintf('Cell Length:	%.5f\n',unitCell.cell_length);
			fprintf('Rel Density:	%.5f\n',unitCell.rel_density);
			fprintf('Isovalue:		%.5f\n',unitCell.isovalue);
			fprintf('\n');
		end
    end
end