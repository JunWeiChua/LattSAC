% Function to create Unit Cell Architecture Library.

function createCellLib()
	load('Strut Lattice.mat','unit_cell');
	cellArchLib = CellArchLib();
	cellArchList{1,1} = unit_cell;
	count = 0;
	for idx = 1:size(unit_cell,1)
		cellArch = CellArchStrut(unit_cell(idx));
		count = count + 1;
		cellArch.setSN(count);
		cellArchLib.insert(cellArch,count);
	end
	
	load('Plate Lattice.mat','unit_cell');
	cellArchList{2,1} = unit_cell;
	for idx = 1:size(unit_cell,1)
		cellArch = CellArchPlate(unit_cell(idx));
		count = count + 1;
		cellArch.setSN(count);
		cellArchLib.insert(cellArch,count);
	end
	
	load('TPMS Lattice.mat','TPMS_cell','TPMS_network');
	cellArchList{3,1} = TPMS_cell;
	cellArchList{3,2} = TPMS_network;
	cellArch = [];
	for idx_network = 1:length(TPMS_network)
		for idx_cell = 1:length(TPMS_cell)
			cell = TPMS_cell(idx_cell);
			net = TPMS_network(idx_network);
			cellArch = CellArchTPMS(cell,net);
			count = count + 1;
			cellArch.setSN(count);
			cellArchLib.insert(cellArch,count);
		end
	end
	
	save('Unit Cell Architecture','cellArchLib','cellArchList');
	fprintf("Unit Cell Architecture Library created successfully.\n");
end