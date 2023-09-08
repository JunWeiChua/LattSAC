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
	
	methods (Static)
		% Import the data of unit cell architectures and create the objects.
		function createLib()
			load('Experiment Unit Cell Layers.mat');

			LattLib = LatticeLib();
			LattLabel = LatticeLib();
			for idx_case = 1:length(labels)
				layer = ExptCases{idx_case};
				label = labels(idx_case);
				
				sample = Lattice('Circular',layer.Frequency);
				insertLayer(sample,layer,1);
				calcTMM(sample);
				calcSAC(sample);

				LattLib.insert(sample,idx_case);
				LattLabel.insert(label,idx_case);
			end
			save('Lattice Library.mat','LattLib','LattLabel');
			fprintf("Lattice Library created successfully.\n");
		end
	end
end