classdef NormalNN < handle
    properties (SetAccess = protected)
		mean = []
		std = []
		NN = []
    end
    
    methods
        function NNModel = NormalNN(w_mean,w_std,w_NN)
			NNModel.mean = w_mean;
			NNModel.std = w_std;
			NNModel.NN = w_NN;
        end
	end
	
	methods (Static)
		% Function to create the library of NormalNN objects.
		function createNN()
			load('Delta Models.mat');
			
			% delta_1_NN_lib = cell(size(delta_1_model,2),1);
			delta_2_NN_lib = cell(size(delta_2_model,2),1);
			
			for i = 1:size(delta_2_model,2)
				% delta_1_NN_lib{i,:} = NormalNN(delta_mean,delta_std,delta_1_model(:,i));
				delta_2_NN_lib{i,:} = NormalNN(delta_mean,delta_std,delta_2_model(:,i));
			end
			save('NN Model Library.mat','delta_2_NN_lib');
		end
	end
end