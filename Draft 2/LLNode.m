classdef LLNode < handle
    % Doubly linked-list node.
	properties (SetAccess = protected)
		Index (1,1) {mustBeNumeric} = 0
		Data
		Next = []
		Prev = []
	end
	
    methods
        function node = LLNode(data)
			% Construct a LLNode object
			if nargin > 0
				node.Data = data;
			end
		end
		
		function setIndex(node,idx)
			node.Index = idx;
		end
		
		function setNext(node,next)
			node.Next = next;
		end
		
		function setPrev(node,prev)
			node.Prev = prev;
		end
		
        function disp(node)
            fprintf('Number:		%d\n',node.Index);
			disp(node.Data);
			fprintf('\n');
        end
    end
end
            