from collections import deque
from pprint import pprint

class MultiplierParser:
    def __init__(self):
        self.bfs_index = 0
    
    def parse_multiplier_string(self, s):
        """Parse a multiplier string into a tree structure with BFS indexing."""
        self.bfs_index = 0
        tokens = s.strip('_').split('__')
        
        # First pass: Build the tree structure
        result, _ = self._parse_module(tokens, 0)
        
        # Second pass: Assign BFS indices
        self._assign_bfs_indices(result)
        
        return result
    
    def _parse_module(self, tokens, index):
        """Parse a single module and its submodules."""
        if index >= len(tokens):
            return {}, index
        
        current_token = tokens[index]
        if not (current_token.startswith('rr') or current_token.startswith('nr')):
            return {}, index
        
        # Parse dimensions and type
        is_recursive = current_token.startswith('rr')
        dims = current_token.split('x')
        x = int(dims[0][2:])
        y = int(dims[1])
        
        # Create key with temporary index (-1)
        key = [x, y, 'rr' if is_recursive else 'nr', -1]
        result = {tuple(key): {}}
        index += 1
        
        # Parse submodules if recursive
        if is_recursive and index < len(tokens) and tokens[index] == 'B':
            index += 1
            
            for _ in range(4):
                if index >= len(tokens):
                    break
                submodule, new_index = self._parse_module(tokens, index)
                if submodule:
                    result[tuple(key)].update(submodule)
                index = new_index
            
            if index < len(tokens) and tokens[index] == 'B':
                index += 1
        
        return result, index
    
    def _assign_bfs_indices(self, tree):
        """Assign BFS indices to all nodes in the tree."""
        if not tree:
            return
        
        queue = deque([(None, tree)])
        while queue:
            parent_key, current_dict = queue.popleft()
            
            for key in list(current_dict.keys()):
                # Create new key with correct BFS index
                new_key = list(key)
                new_key[3] = self.bfs_index
                self.bfs_index += 1
                
                # Update the key in the dictionary
                value = current_dict.pop(key)
                current_dict[tuple(new_key)] = value
                
                # Add children to queue
                if value:  # if has children
                    queue.append((new_key, value))

def main():
    parser = MultiplierParser()
    
    test_strings = [
        "rr4x4__B__nr2x2__nr2x2__nr2x2__nr2x2__B__",
        "rr8x8__B__rr6x6__B__nr3x3__nr3x3__nr3x3__nr3x3__B__nr6x2__nr2x6__nr2x2__B__",
        "rr8x8__B__rr6x6__B__nr1x1__nr1x5__nr5x1__rr5x5__B__rr4x4__B__rr3x3__B__nr1x1__nr1x2__nr2x1__nr2x2__B__nr3x1__nr1x3__nr1x1__B__nr4x1__nr1x4__nr1x1__B__B__nr6x2__nr2x6__nr2x2__B__"
    ]
    
    for test in test_strings:
        print(f"\nInput: {test}\n")
        result = parser.parse_multiplier_string(test)
        pprint(result)

if __name__ == "__main__":
    main()