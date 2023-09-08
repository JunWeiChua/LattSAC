classdef LinkedNode < handle       % LinkedNode_v9
    properties
        Prev
        Next
        Owner
    end
    methods (Abstract)
        gt(a,b)
        ge(a,b)
        lt(a,b)
        le(a,b)
        eq(a,b)
        ne(a,b)
        disp(a)
    end
    methods
        function node = LinkedNode()
            node.Prev = [];
            node.Next = [];
            node.Owner = [];
        end
        function delete(node)
            if ~isempty(node.Owner)
                node.Owner.remove(node);
            end
        end
    end
    methods (Access = protected)
        function reposition(obj)
            if ~isempty(obj.Owner)
                list = obj.Owner;
                list.remove(obj);
                list.insert(obj);
            end
        end
    end
end
      