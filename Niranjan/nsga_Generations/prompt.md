open a file called config_name.dat and read each line, and pass the string to a function called generate_mult_dict. the result is a dictionary that you need to pass to another function called tree_to_array. 

if at any point any line of the file's processing envoke an error have a try except block and write the error log to an error.txt in log folder

def tree_to_array(tree, array, index=0):
def generate_mult_dict(s):