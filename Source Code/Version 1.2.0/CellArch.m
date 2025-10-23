classdef CellArch < handle
    properties (SetAccess = protected)
		SN		(1,1)	{mustBeNonnegative}	= 0
		Name	string 	{mustBeText}		= ""
    end
	
	properties (Abstract, Constant)
		CellType
	end
	
    methods
        function cellArch = CellArch(label)
			if nargin > 0
				cellArch.Name = label;
			end
		end
		
		function setSN(cellArch,idx)
			cellArch.SN = idx;
		end
		
		function disp(cellArch)
			fprintf('S/N:		%d\n',cellArch.SN);
            fprintf('Name:		%s\n',cellArch.Name);
            fprintf('Cell Type:	%s\n',cellArch.CellType);
			fprintf('\n');
		end
    end
end