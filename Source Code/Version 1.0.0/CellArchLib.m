classdef CellArchLib < LinkedList
    methods
		function list = CellArchLib()
            list.Head = [];
            list.Tail = [];
            list.Length = 0;
        end
		
		function CellDesign = findCellArch(list,label)
			CellDesign = [];
			cur = list.Head;
			while isempty(CellDesign) && ~isempty(cur)
				cellArch = cur.Data;
				if cellArch.Name == label
					CellDesign = cellArch;
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
	
	methods (Static)
		% Import the data of unit cell architectures and create the objects.
		function createLib()
			load('Strut Lattice.mat','unit_cell');
			cellArchLib = CellArchLib();
			for idx = 1:size(unit_cell,1)
				cellArch = CellArchStrut(unit_cell(idx));
				% Future provision for other cell types.
				cellArch.setSN(idx);
				cellArchLib.insert(cellArch,idx);
			end
			save('Unit Cell Architecture','cellArchLib','unit_cell');
			fprintf("Unit Cell Architecture Library created successfully.\n");
		end
	end
end