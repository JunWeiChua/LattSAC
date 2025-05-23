% Sample validation cases (Strut Lattices).
clc; clear all; close all;
load('Strut Lattice.mat','unit_cell');
section = "Circle";
frequency = 100:10:6300;

cell_length = 4:0.5:8;
rel_density = 0.1:0.05:0.4;
num_samples = 4;
count = 0;

UC_val = [4 3 5 2 7; ...
		  5 6 3 7 1; ...
		  5 7 3 1 6; ...
		  6 3 5 2 1];
Lcell_val = [7.0 4.0 6.0 7.5 8.0; ...
			 7.5 4.5 6.0 5.5 4.0; ...
			 4.5 7.5 5.0 8.0 6.0; ...
			 4.0 6.0 5.5 4.5 6.5];
RD_val = [0.40 0.35 0.25 0.20 0.10; ...
		  0.30 0.35 0.25 0.40 0.10; ...
		  0.35 0.10 0.40 0.15 0.20; ...
		  0.10 0.25 0.20 0.30 0.35];
Nlayer_val = [2 4 2 2 2; ...
			  2 3 2 2 3; ...
			  3 2 3 2 2; ...
			  4 2 2 3 2];
SR_val = [1.0 0.5 0.5 0.1 0.9; ...
		  1.0 0.5 0.5 0.2 0.8; ...
		  1.0 0.5 0.5 0.8 0.2; ...
		  1.0 0.5 0.5 0.2 0.8];
layerType_val = [2 3 1; 3 1 2; 1 3 2; 3 1 2];

%% 3 layers in series, 1 homogeneous layer, 2 heterogeneous with 2 parts.
for idx_sample = 1:num_samples
    count = count + 1;
    sample{count} = Lattice('Circle',frequency);
    idx_cell = UC_val(idx_sample,:);
    Lcell = Lcell_val(idx_sample,:);
    RD = RD_val(idx_sample,:);
	SR = SR_val(idx_sample,:);
	layer_type = layerType_val(idx_sample,:);
    for idx_layer = 1:3
        layer = LattLayer(section,frequency);
        switch layer_type(idx_layer)
            case 1 % Homogeneous
                part = LattPartStrut(unit_cell(idx_cell(1)), ...
                    Lcell(1),RD(1), ...
                    section,30,30, ...
                    floor(16/Lcell(1)));
                layer.insertPart(part,1);
            case 2 % 2 Parts, each surface ratio 0.5
                for idx_part = 1:2
                    part = LattPartStrut(unit_cell(idx_cell(idx_part+1)), ...
                        Lcell(idx_part+1),RD(idx_part+1), ...
                        section,30,30, ...
                        floor(16/Lcell(idx_part+1)));
                    layer.insertPart(part,1/2);
                end
            case 3 % 2 Parts, surface ratio random
                for idx_part = 1:2
                    part = LattPartStrut(unit_cell(idx_cell(idx_part+3)), ...
                        Lcell(idx_part+3),RD(idx_part+3), ...
                        section,30,30, ...
                        floor(16/Lcell(idx_part+3)));
                    layer.insertPart(part,SR(idx_part+3));
                end
        end
        insertLayer(sample{count},layer,idx_layer);
    end
    sample{count}.updateThickness(1);
    calcTMM(sample{count});
    calcSAC(sample{count});
	fprintf('SAMPLE NUMBER %d\n',idx_sample);
    disp(sample{idx_sample})
end
save('Validation_Strut.mat','sample');