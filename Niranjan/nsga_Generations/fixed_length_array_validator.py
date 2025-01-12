import os
from generate_mult_dict import parse_multiplier_string as generate_dict


error_log_file = os.path.join('log', 'error.txt')



def tree_to_array(tree, array, index=0):

    if not tree:
        return
    
    for key, children in tree.items():
        print(f"key : {key}, index : {index}")
        m, n, is_rec, _ = key
        # Debug this small error later, the index is not being updated correctly
        print(array)
        array[index] = (m, n)


        if is_rec == 'rr':
            
            child_indices = [4 * index + j for j in range(1, 5)]

            for idx, (child_key, child_tree) in zip(child_indices, children.items()):
                tree_to_array({child_key: child_tree}, array, idx)



def main_():
    multiplier = 8
    array_length = (4**(multiplier-2) - 1) // 3  

    array = [0] * array_length

    tree_to_array(tree, array, 0)

    for i in range(array_length):
        if array[i] :
            print(i, array[i])
    
    # read each line of the file config_name_new.dat and pass it to generate_mult_dict
    # read tree (which is a dictionary from the generate_mult_dict


def main():

    multiplier = 8
    array_length = (4**(multiplier-1) - 1) // 3  

    
    with open("configs_name.dat", 'r') as file:
        lines = file.readlines()

    for line_number, line in enumerate(lines, start=1):
        try:
            line = line.strip()
            if not line:
                continue

            mult_dict = generate_dict(line)

            array = [0] * array_length
            array_result = tree_to_array(mult_dict,array,0)

            d = {}
            for i in range(array_length):
                if array[i] :
                    d[i] = array[i]

            with open("configs_const_array.dat","a") as f:
                f.write(str(d)+"\n")

            print(f"Processed Line {line_number}: {line}")
            print(f"Resulting Array: {array_result}\n")

        except Exception as e:
            # Log the error
            with open(error_log_file, 'a') as error_file:
                error_file.write(f"Error processing line {line_number}: {line}\n")
                error_file.write(f"{str(e)}\n\n")



if __name__ == "__main__":
    main()