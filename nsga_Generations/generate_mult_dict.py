"""
Author: Niranjan Gopal, IIITB, under guidance of Prof. Madhav Rao.


Given a string (name of multiplier that has all information on how to construct such a multiplier ) 
I want to make a tree like structure ( using dictionary ) 


r means recursive, and is always following by B...B, where B represents brackets and will describe the structure of the recursive module.
1 recursive module will always have 4 sub-modules, that could be either non-recursive or recursive
nr means non recursive multiplier.


1rr8x8__B__1nr6x6__1nr6x2__1nr2x6__1nr2x2__B__
=> so it's a recursive 8x8 multiplier that is built using 1 non-recursive 6x6, 1 non recursive 6x2 and 2x6, 1 non-recursive 2x2


This is the dicitonary I want to make
{
    [8,8,r] : {
            [6,6,nr] : {} ,
            [6,2,nr] : {} ,
            [2,6,nr] : {} ,
            [2,2,nr] : {} ,
    }
}  

Other examples :- 

1rr8x8__B__1rr6x6__B__1nr3x3__1nr3x3__1nr3x3__1nr3x3__B__1nr6x2__1nr2x6__1nr2x2__B__

{
    [8,8,r] : {

        [6, 6,r] : {
                    [3, 3,nr] : {} ,
                    [3, 3,nr] : {} ,
                    [3, 3,nr] : {} ,
                    [3, 3,nr] : {} ,                
                  } ,  
        [6, 2,nr] : {} , 
        [2, 6,nr] : {} , 
        [2, 2,nr] : {} ,
    }
}


1r8x8__B__1rr6x6__B__1nr1x1__1nr1x5__1nr5x1__1r5x5__B__1r4x4__B__1nr1x1__1nr1x3__1nr3x1__1r3x3__B__1nr1x1__1nr1x2__1nr2x1__1nr2x2__B___1nr4x1__1nr1x4__1nr1x1__B___B__1_nr_6x2_1_nr_2x6_1_nr_2x2__B__

{
    [8,8,r] : {

        [6,6,r] : {
                [1, 1, nr] : {} ,  
                [1, 5, nr] : {} ,  
                [5, 1, nr] : {} , 
                [5, 5, r] : {
                    [4,4,r] : {
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
                    [4, 1] : {} , 
                    [1, 4] : {} , 
                    [1, 1] : {} ,
                } ,
        [6, 2, r] : {} , 
        [2, 6, r] : {} , 
        [2, 2, r] : {} ,

        }
    
    }

}

"""



# Main 
def parse_multiplier_string(input_string):

    def parse_module(module_str):
        """
        Parse a single module string (e.g., "1nr6x6" or "1rr8x8")
        
        Returns:
            tuple: (count, is_recursive, dims) where dims is [width, height]
        """
        count = 1
        is_recursive = module_str[1:2] == 'rr'
        dims =[module_str[3], module_str[5] ] 
        return count, is_recursive, dims


    def create_module_dict(dims, is_recursive):
        """
        Create a key for the dictionary representing a module
        
        Returns:
            tuple: (width, height, type) where type is 'r' or 'nr'
        """
        return tuple(dims + ['rr' if is_recursive else 'nr'])



    # Recursive Constructing Engine 
    def process_recursive_structure(s, start_idx):
        """
        Process a recursive structure starting from an opening bracket
        
        Returns:
            tuple: (dictionary representing the structure, index after closing bracket)
        """
        result = {}
        current_str = ""
        i = start_idx
        
        # or <= ?
        while i+2 <= len(s):
            print(f"condition = {i+2} <= {len(s)-1}; i is {i}, string is '{current_str}' result is {result}")
            if s[i:i+2] == '__':  # Found delimiter
                if current_str:
                    _ , is_recursive, dims = parse_module(current_str)
                    key = create_module_dict(dims, is_recursive)
                    
                    if is_recursive:  # If recursive, we expect brackets after this
                        print("Found recursive module at {i}")
                        sub_dict, new_i = process_recursive_structure(s, i+5)  # Skip __B__
                        print(f"ke {key} at {i}")
                        result[key] = sub_dict
                        i = new_i
                    else:
                        result[key] = {}
                    
                current_str = ""
                i+=2
                continue
                
            current_str += s[i]
            i += 1
            
        return result, i

    # Start processing from the first module
    result, _ = process_recursive_structure(input_string, 0)
    return result



# Example usage and testing
def pretty_print_nested_dict(d, indent=0):
    for key, value in d.items():
        print("    " * indent + f"{list(key)}: {{")
        if value:
            pretty_print_nested_dict(value, indent + 1)
        print("    " * indent + "}")




test_strings = [
    "1nr8x8__",
    "1rr8x8__B__1nr6x6__1nr6x2__1nr2x6__1nr2x2__B__",
    # "1_r_8x8__B__1_r_6x6__B__1_nr_3x3_1_nr_3x3_1_nr_3x3_1_nr_3x3__B__1_nr_6x2_1_nr_2x6_1_nr_2x2__B__"
]

for test_string in test_strings:
    print("\nProcessing string:")
    print(test_string)
    print("\nResulting structure:")
    result = parse_multiplier_string(test_string)
    pretty_print_nested_dict(result)
