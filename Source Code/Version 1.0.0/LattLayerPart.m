classdef LattLayerPart < handle
    properties (SetAccess = protected)
		UnitCell		% UnitCell Object
		CrossSection	string						= ""
		N_x				(1,1)	{mustBeInteger}		= 0
		N_y				(1,1)	{mustBeInteger}		= 0
		N_z				(1,1)	{mustBeInteger}		= 0
		l_part			(1,1)	{mustBeNonnegative}	= 0
		w_part			(1,1)	{mustBeNonnegative}	= 0	
		t_part			(1,1)	{mustBeNonnegative}	= 0
		SurfaceRatio	(1,1)	{mustBeNonnegative}	= 1
    end
    
	methods (Abstract)
		changeUC(part,label)
		copyPart(part)
		calcTMM(part,freq)
		disp(part)
    end
	
    methods
		function setCS(part,shape)
			part.CrossSection = shape;
		end
		
		function setL(part,l)
			part.l_part = l;
			part.updateXYZ();
		end
		
		function setW(part,w)
			part.w_part = w;
			part.updateXYZ();
		end
		
		function setT(part,t)
			part.t_part = t;
			part.N_z = floor(t/part.UnitCell.cell_length);
		end
		
		function setNz(part,Nz)
			part.N_z = Nz;
			part.updateXYZ();
		end
		
		function updateXYZ(part)
			part.N_x = ceil(part.l_part/part.UnitCell.cell_length);
			part.N_y = ceil(part.w_part/part.UnitCell.cell_length);
			part.t_part = part.N_z * part.UnitCell.cell_length;
		end
		
		function setSR(part,newSR)
			part.SurfaceRatio = newSR;
		end
    end
end