classdef IndexList < DList
    methods        
        function insert(list,node)
            if ~isempty(node.Owner)
                if node.Owner ~= list
                    node.Owner.remove(node);
                else
                    return;
                end
            end
            node.Owner = list;
            list.Length = list.Length + 1;
            if isempty(list.Head)
                list.Head = node;
                list.Tail = node;
                node.Prev = [];
                node.Next = [];
            else
                cur = list.Head;
                prev = [];
                while ~isempty(cur) && node > cur
                    prev = cur;
                    cur = cur.Next;
                end
                if isempty(prev)
                    node.Next = list.Head;
                    node.Prev = [];
                    list.Head.Prev = node;
                    list.Head = node;
                else
                    prev.Next = node;
                    node.Prev = prev;
                    node.Next = cur;
                    if isempty(cur)
                        list.Tail = node;
                    else
                        cur.Prev = node;
                    end
                end
            end
        end
		
		function insertNode(list,node,idx)
			setIndex(node,idx);
			insert(list,node);
			updateIdx(list);
		end
		
		function removeNode(list,idx)
			node = find(list,idx);
			remove(list,node);
			setIndex(node,0);
			if ~isempty(list.Head) || list.Length ~= 0
				updateIdx(list);
			end
		end
		
		% Updates all the indices in the list.
		function updateIdx(list)
			if isempty(list.Head) || list.Length == 0
                error('List is empty.');
			else
				count = 0; cur = list.Head;
				while ~isempty(cur)
					count = count + 1;
					setIndex(cur,count);
					cur = cur.Next;
				end
				list.Length = count;
			end
		end
		
		% Finds the node at a specific index.
		function node = find(list,idx)
			node = [];
			if isempty(list.Head) || list.Length == 0
                error('List is empty.');
			end
			if list.Length < idx || mod(idx,1) ~= 0
                error('idx is invalid.');
			end
            cur = list.Head;
			while ~isempty(cur) && cur.Index ~= idx
				cur = cur.Next;
			end
			node = cur;
		end
		
		% Swaps two nodes at specifc indices.
		function swap(list,idx_1,idx_2)
			if isempty(list.Head) || list.Length == 0
                error('List is empty.');
			end
			node1 = find(list,idx_1); node2 = find(list,idx_2);
			removeNode(list,idx_1); removeNode(list,idx_2);
			insertNode(list,node2,idx_1); insertNode(list,node1,idx_2);
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
            disp('IndexList containing:');
            item = list.Head;
            while ~isempty(item)
                item.disp();
                item = item.Next;
            end
        end
    end
end
