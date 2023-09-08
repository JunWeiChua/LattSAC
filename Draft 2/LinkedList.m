classdef LinkedList < handle
    % Doubly linked-list implementation.
	properties (SetAccess = protected) % Access by defining class and its subclasses
        Head
        Tail
        Length
    end
	
    methods
		function list = LinkedList()
            list.Head = [];
            list.Tail = [];
            list.Length = 0;
        end
		
		% Check if list is empty.
		function empty = isEmpty(list)
			if isempty(list.Head) && isempty(list.Tail)
				empty = true;
			else
				empty = false;
			end
		end
		
		% Obtain the length of the list.
		function lng = getLength(list)
            lng = list.Length;
        end
        
		% Get the node at a certain index.
		function node = getNode(list,index)
			if index < 1 || index > list.Length
				node = [];
			else
				cur = list.Head;
				while cur.Index ~= index
					cur = cur.Next;
				end
				node = cur;
			end
		end
		
		% Insert an object at a certain index.
        function insert(list,obj,idx)
            if idx < 1 || idx > list.Length + 1
				error('idx is invalid.');
            else
				node = LLNode(obj);
				if idx == 1
					node.setNext(list.Head);
					list.Head = node;
				else
					PrevNode = getNode(list,idx-1);
					node.setPrev(PrevNode);
					PrevNode.setNext(node);
				end
				if idx == list.Length + 1
					node.setPrev(list.Tail);
					list.Tail = node;
				else
					NextNode = getNode(list,idx);
					node.setNext(NextNode);
					NextNode.setPrev(node);
				end
				updateIdx(list);
			end
        end
		
		% Remove a node at a certain index.
        function remove(list,idx)
            if idx < 1 || idx > list.Length
				error('idx is invalid.');
            else
				node = getNode(list,idx);
				if idx == 1
					list.Head = node.Next;
				else
					PrevNode = node.Prev;
					PrevNode.setNext(node.Next);
				end
				if idx == list.Length
					list.Tail = node.Prev;
				else
					NextNode = node.Next;
					NextNode.setPrev(node.Prev);
				end
				node.setPrev([]); node.setNext([]);
				updateIdx(list);
			end
        end
		
		% Updates all the indices in the list.
		function updateIdx(list)
			count = 0; cur = list.Head;
			while ~isempty(cur)
				count = count + 1;
				cur.setIndex(count);
				cur = cur.Next;
			end
			list.Length = count;
		end
		
		% Swaps two nodes at specifc indices.
		function swap(list,idx_1,idx_2)
			if idx_1 < 1 || idx_1 > list.Length || idx_2 < 1 || idx_2 > list.Length
				error('idx is invalid.');
			end
			node1 = getNode(list,idx_1); node2 = getNode(list,idx_2);
			remove(list,idx_1); remove(list,idx_2);
			insert(list,node2.Data,idx_1); insert(list,node1.Data,idx_2);
			node1.delete(); node2.delete();
		end
		
		% Reverses the order of the list.
        function reverse(list)
			front = list.Head; back = list.Tail;
			while front < back
				swap(list,front.Index,back.Index);
				front = front.Next; back = back.Prev;
			end
		end
		
		% Displays list contents.
		function disp(list)
            disp('LinkedList containing:');
            item = list.Head;
            while ~isempty(item)
                item.disp();
                item = item.Next;
            end
        end
    end
end
            