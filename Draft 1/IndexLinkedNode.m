classdef IndexLinkedNode < LinkedNode
    properties
        Index (1,1) {mustBeNumeric} = 0
    end
    methods
        function node = IndexLinkedNode(n)
            node.Index = n;
        end
        function node = setIndex(node,newValue)
            if isempty(node.Owner)
                node.Index = newValue; 
            else
                list = node.Owner;
                list.remove(node);
                node.Index = newValue;
                list.insert(node);
            end
        end 
        function res = gt(node1,node2)          % >
            res = node1.Index > node2.Index;
        end
        function res = ge(node1,node2)          % >=
            res = node1.Index >= node2.Index;
        end        
        function res = lt(node1,node2)          % <
            res = node1.Index < node2.Index;
        end        
        function res = le(node1,node2)          % <=
            res = node1.Index <= node2.Index;
        end        
        function res = eq(node1,node2)          % ==
            res = node1.Index == node2.Index;
        end        
        function res = ne(node1,node2)          % ~=
            res = node1.Index ~= node2.Index;
        end   
        function disp(node)
            disp(node.Index);
        end
    end
end
            