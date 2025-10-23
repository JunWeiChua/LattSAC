classdef CellArchLib < LinkedList
    methods
		function list = CellArchLib()
            list.Head = [];
            list.Tail = [];
            list.Length = 0;
        end
		
		function CellDesign = findCellArch(list,type,varargin)
			CellDesign = [];
			cur = list.Head;
			while isempty(CellDesign) && ~isempty(cur)
				cellArch = cur.Data;
				switch type
					case {'Strut','Plate'}
						if nargin == 3 && ...
						   cellArch.CellType == type && ...
						   cellArch.Name == varargin{1}
							CellDesign = cellArch;
						end
					case 'TPMS'
						if nargin == 4 && ...
						   cellArch.CellType == type && ...
						   cellArch.Name == varargin{1} && ...
						   cellArch.Network == varargin{2}
							CellDesign = cellArch;
						end
				end
				cur = cur.Next;
			end
		end
		
		% Displays list contents.
		function disp(list)
            disp('CellArchLib containing:');
            item = list.Head;
            while ~isempty(item)
                item.Data.disp();
                item = item.Next;
            end
        end
    end
end