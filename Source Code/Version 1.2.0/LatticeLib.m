classdef LatticeLib < LinkedList
    methods
		function list = LatticeLib()
            list.Head = [];
            list.Tail = [];
            list.Length = 0;
        end
		
		function latt = findLatt(list,label)
			latt = [];
			cur = list.Head;
			while isempty(latt) && ~isempty(cur)
				cellArch = cur.Data;
				if cellArch.Name == label
					latt = cellArch;
				end
				cur = cur.Next;
			end
		end
		
		% Displays list contents.
		function disp(list)
            disp('Lattice Library contains:');
            item = list.Head;
            while ~isempty(item)
                item.disp();
                item = item.Next;
            end
        end
    end
end