% Function to create Sample Lattice Library.

function createLattLib()
	load('Experiment Unit Cell Layers - Strut.mat');

	LattLib = LatticeLib();
	LattLabel = LatticeLib();
	count = 0;
	for idx_case = 1:length(labels)
		layer = ExptCases{idx_case};
		label = labels(idx_case);
		count = count + 1;
		
		sample = Lattice('Circle',layer.Frequency);
		insertLayer(sample,layer,1);
		calcTMM(sample);
		calcSAC(sample);

		LattLib.insert(sample,count);
		LattLabel.insert(label,count);
	end
	
	load('Experiment Unit Cell Layers - Plate.mat');
	for idx_case = 1:length(labels)
		layer = ExptCases{idx_case};
		label = labels(idx_case);
		count = count + 1;
		
		sample = Lattice('Circle',layer.Frequency);
		insertLayer(sample,layer,1);
		calcTMM(sample);
		calcSAC(sample);

		LattLib.insert(sample,count);
		LattLabel.insert(label,count);
	end
	
	load('Experiment Unit Cell Layers - TPMS.mat');
	for idx_case = 1:length(labels)
		layer = ExptCases{idx_case};
		label = labels(idx_case);
		count = count + 1;
		
		sample = Lattice('Circle',layer.Frequency);
		insertLayer(sample,layer,1);
		calcTMM(sample);
		calcSAC(sample);

		LattLib.insert(sample,count);
		LattLabel.insert(label,count);
	end
	
	load('Validation_Strut.mat');
	for idx_sample = 1:length(sample)
		fprintf('SAMPLE NUMBER %d\n',idx_sample);
		disp(sample{idx_sample})
		LattLib.insert(sample{idx_sample},LattLib.Length+1);
		LattLabel.insert(sprintf('Strut - Validation Sample %d',idx_sample),LattLabel.Length+1);
	end
	
	load('Validation_Plate.mat');
	for idx_sample = 1:length(Sample_Plate)
		fprintf('SAMPLE NUMBER %d\n',idx_sample);
		disp(Sample_Plate{idx_sample})
		LattLib.insert(Sample_Plate{idx_sample},LattLib.Length+1);
		LattLabel.insert(sprintf('Plate - Validation Sample %d',idx_sample),LattLabel.Length+1);
	end
	save('Lattice Library.mat','LattLib','LattLabel');
	fprintf("Lattice Library created successfully.\n");
end