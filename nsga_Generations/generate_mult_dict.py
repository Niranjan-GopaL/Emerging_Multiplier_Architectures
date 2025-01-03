"""
Author: Niranjan Gopal, IIITB, under guidance of Prof. Madhav Rao.


Given a string (name of multiplier that has all information on how to construct such a multiplier ) 
I want to make a tree like structure ( using dictionary ) 


r means recursive, and is always following by B...B, where B represents brackets and will describe the structure of the recursive module.
1 recursive module will always have 4 sub-modules, that could be either non-recursive or recursive
nr means non recursive multiplier.

Example 1 :-

rr8x8,__B__nr6x6__nr6x2__nr2x6__nr2x2__B__
=> so it's a recursive 8x8 multiplier that is built using 1 non-recursive 6x6, 1 non recursive 6x2 and 2x6, 1 non-recursive 2x2


This is the dicitonary I want to make
{
    [8,8,rr] : {
            [6,6,nr] : {} ,
            [6,2,nr] : {} ,
            [2,6,nr] : {} ,
            [2,2,nr] : {} ,
    }
}  

Example 2 :- 

rr8x8__B__rr6x6__B__nr3x3__nr3x3__nr3x3__nr3x3__B__nr6x2__nr2x6__nr2x2__B__

{
    [8,8,rr] : {
        [6, 6,rr] : {
                    [3, 3,nr] : {} ,
                    [3, 3,nr] : {} ,
                    [3, 3,nr] : {} ,
                    [3, 3,nr] : {} ,                
                } ,  
        [6, 2, nr] : {} , 
        [2, 6, nr] : {} , 
        [2, 2, nr] : {} ,
    }
}

Example 3 :- 

rr8x8__B__rr6x6__B__nr1x1__nr1x5__nr5x1__rr5x5__B__rr4x4__B__nr1x1__nr1x3__nr3x1__rr3x3__B__nr1x1__nr1x2__nr2x1__nr2x2__B__B__nr4x1__nr1x4__nr1x1__B__B__nr6x2__nr2x6__nr2x2__B__

{
    [8,8,r] : {
        [6,6,r] : {
                [1, 1, nr] : {} ,  
                [1, 5, nr] : {} ,  
                [5, 1, nr] : {} , 
                [5, 5, r] : {
                    [4, 4, r] : {
                        [1, 1, nr] : {} ,
                        [1, 3, nr] : {} ,
                        [3, 1, nr] : {} ,
                        [3, 3,  r] : {
                            [1, 1 , nr] : {},
                            [1, 2 , nr] : {},
                            [2, 1 , nr] : {},
                            [2, 2 , nr] : {},
                        } ,
                    }
                    [4, 1, nr] : {} , 
                    [1, 4, nr] : {} , 
                    [1, 1, nr] : {} ,
                } ,
        [6, 2, r] : {} , 
        [2, 6, r] : {} , 
        [2, 2, r] : {} ,

        }
    
    }

}

Key point is that whenever you see a `rr` you need to open a new bracket in the dictionary corresponding that key 
becuase it will be immediately be followed by the body of the the resursive module

These are other examples of the name

rr8x8__B__rr6x6__B__nr1x1__nr1x5__nr5x1__rr5x5__B__nr4x4__nr4x1__nr1x4__nr1x1__B__B__nr6x2__nr2x6__nr2x2__B__
rr8x8__B__rr6x6__B__nr1x1__nr1x5__nr5x1__rr5x5__B__nr2x2__nr2x3__nr3x2__nr3x3__B__B__nr6x2__nr2x6__nr2x2__B__
rr8x8__B__rr6x6__B__nr1x1__nr1x5__nr5x1__rr5x5__B__nr3x3__nr3x2__nr2x3__nr2x2__B__B__nr6x2__nr2x6__nr2x2__B__
rr8x8__B__rr6x6__B__nr1x1__nr1x5__nr5x1__rr5x5__B__nr1x1__nr1x4__nr4x1__nr4x4__B__B__nr6x2__nr2x6__nr2x2__B__
rr8x8__B__rr6x6__B__nr1x1__nr1x5__nr5x1__rr5x5__B__rr4x4__B__nr2x2__nr2x2__nr2x2__nr2x2__B__nr4x1__nr1x4__nr1x1__B__B__nr6x2__nr2x6__nr2x2__B__
rr8x8__B__rr6x6__B__nr1x1__nr1x5__nr5x1__rr5x5__B__rr4x4__B__nr1x1__nr1x3__nr3x1__nr3x3__B__nr4x1__nr1x4__nr1x1__B__B__nr6x2__nr2x6__nr2x2__B__
rr8x8__B__rr6x6__B__nr1x1__nr1x5__nr5x1__rr5x5__B__rr4x4__B__nr3x3__nr3x1__nr1x3__nr1x1__B__nr4x1__nr1x4__nr1x1__B__B__nr6x2__nr2x6__nr2x2__B__
rr8x8__B__rr6x6__B__nr1x1__nr1x5__nr5x1__rr5x5__B__rr4x4__B__nr1x1__nr1x3__nr3x1__rr3x3__B__nr1x1__nr1x2__nr2x1__nr2x2__B__B__nr4x1__nr1x4__nr1x1__B__B__nr6x2__nr2x6__nr2x2__B__
rr8x8__B__rr6x6__B__nr1x1__nr1x5__nr5x1__rr5x5__B__rr4x4__B__nr1x1__nr1x3__nr3x1__rr3x3__B__nr2x2__nr2x1__nr1x2__nr1x1__B__B__nr4x1__nr1x4__nr1x1__B__B__nr6x2__nr2x6__nr2x2__B__
rr8x8__B__rr6x6__B__nr1x1__nr1x5__nr5x1__rr5x5__B__rr4x4__B__rr3x3__B__nr1x1__nr1x2__nr2x1__nr2x2__B__nr3x1__nr1x3__nr1x1__B__nr4x1__nr1x4__nr1x1__B__B__nr6x2__nr2x6__nr2x2__B__
rr8x8__B__rr6x6__B__nr1x1__nr1x5__nr5x1__rr5x5__B__rr4x4__B__rr3x3__B__nr2x2__nr2x1__nr1x2__nr1x1__B__nr3x1__nr1x3__nr1x1__B__nr4x1__nr1x4__nr1x1__B__B__nr6x2__nr2x6__nr2x2__B__
rr8x8__B__rr6x6__B__nr1x1__nr1x5__nr5x1__rr5x5__B__nr2x2__nr2x3__nr3x2__rr3x3__B__nr1x1__nr1x2__nr2x1__nr2x2__B__B__B__nr6x2__nr2x6__nr2x2__B__
rr8x8__B__rr6x6__B__nr1x1__nr1x5__nr5x1__rr5x5__B__nr2x2__nr2x3__nr3x2__rr3x3__B__nr2x2__nr2x1__nr1x2__nr1x1__B__B__B__nr6x2__nr2x6__nr2x2__B__
rr8x8__B__rr6x6__B__nr1x1__nr1x5__nr5x1__rr5x5__B__rr3x3__B__nr1x1__nr1x2__nr2x1__nr2x2__B__nr3x2__nr2x3__nr2x2__B__B__nr6x2__nr2x6__nr2x2__B__
rr8x8__B__rr6x6__B__nr1x1__nr1x5__nr5x1__rr5x5__B__rr3x3__B__nr2x2__nr2x1__nr1x2__nr1x1__B__nr3x2__nr2x3__nr2x2__B__B__nr6x2__nr2x6__nr2x2__B__
rr8x8__B__rr6x6__B__nr1x1__nr1x5__nr5x1__rr5x5__B__nr1x1__nr1x4__nr4x1__rr4x4__B__nr2x2__nr2x2__nr2x2__nr2x2__B__B__B__nr6x2__nr2x6__nr2x2__B__
rr8x8__B__rr6x6__B__nr1x1__nr1x5__nr5x1__rr5x5__B__nr1x1__nr1x4__nr4x1__rr4x4__B__nr1x1__nr1x3__nr3x1__nr3x3__B__B__B__nr6x2__nr2x6__nr2x2__B__
rr8x8__B__rr6x6__B__nr1x1__nr1x5__nr5x1__rr5x5__B__nr1x1__nr1x4__nr4x1__rr4x4__B__nr3x3__nr3x1__nr1x3__nr1x1__B__B__B__nr6x2__nr2x6__nr2x2__B__
rr8x8__B__rr6x6__B__nr1x1__nr1x5__nr5x1__rr5x5__B__nr1x1__nr1x4__nr4x1__rr4x4__B__nr1x1__nr1x3__nr3x1__rr3x3__B__nr1x1__nr1x2__nr2x1__nr2x2__B__B__B__B__nr6x2__nr2x6__nr2x2__B__
rr8x8__B__rr6x6__B__nr1x1__nr1x5__nr5x1__rr5x5__B__nr1x1__nr1x4__nr4x1__rr4x4__B__nr1x1__nr1x3__nr3x1__rr3x3__B__nr2x2__nr2x1__nr1x2__nr1x1__B__B__B__B__nr6x2__nr2x6__nr2x2__B__
rr8x8__B__rr6x6__B__nr1x1__nr1x5__nr5x1__rr5x5__B__nr1x1__nr1x4__nr4x1__rr4x4__B__rr3x3__B__nr1x1__nr1x2__nr2x1__nr2x2__B__nr3x1__nr1x3__nr1x1__B__B__B__nr6x2__nr2x6__nr2x2__B__

"""

from pprint import pprint




def parse_multiplier_string(s):

    def parse_module(tokens, index):

        if index >= len(tokens):
            return {}, index
        
        current_token = tokens[index]
        if not (current_token.startswith('rr') or current_token.startswith('nr')):
            return {}, index
            
        is_recursive = current_token.startswith('rr')
        dims = current_token.split('x')
        x = int(dims[0][2:]) 
        y = int(dims[1])
        key = [x, y, 'rr' if is_recursive else 'nr']
        
        result = {tuple(key): {}}
        index += 1
        
        if is_recursive and index < len(tokens) and tokens[index] == 'B':
            index += 1 
            
            for _ in range(4):
                if index >= len(tokens):
                    break
                submodule, new_index = parse_module(tokens, index)
                if submodule:
                    result[tuple(key)].update(submodule)
                index = new_index
                
            if index < len(tokens) and tokens[index] == 'B':
                index += 1 
                
        return result, index

    # Parse tokens
    tokens = s.strip('_').split('__')
    result, _ = parse_module(tokens, 0)
    return result


def main():

    test_strings = [
        "rr4x4__B__nr2x2__nr2x2__nr2x2__nr2x2__B__",
        "rr8x8__B__rr6x6__B__nr3x3__nr3x3__nr3x3__nr3x3__B__nr6x2__nr2x6__nr2x2__B__",
        "rr8x8__B__rr6x6__B__nr1x1__nr1x5__nr5x1__rr5x5__B__rr4x4__B__rr3x3__B__nr1x1__nr1x2__nr2x1__nr2x2__B__nr3x1__nr1x3__nr1x1__B__nr4x1__nr1x4__nr1x1__B__B__nr6x2__nr2x6__nr2x2__B__",
        "rr8x8__B__nr3x3__nr3x5__nr5x3__rr5x5__B__nr1x1__nr1x4__nr4x1__rr4x4__B__nr1x1__nr1x3__nr3x1__nr3x3__B__B__B__",
        "rr8x8__B__nr3x3__nr3x5__nr5x3__rr5x5__B__rr4x4__B__rr3x3__B__nr2x2__nr2x1__nr1x2__nr1x1__B__nr3x1__nr1x3__nr1x1__B__nr4x1__nr1x4__nr1x1__B__B__",
    ]

    for test in test_strings:
        result = parse_multiplier_string(test)
        print(f"\nInput: {test}")
        print("Output:\n")
        pprint(result)
        
if __name__=="__main__":
    main()