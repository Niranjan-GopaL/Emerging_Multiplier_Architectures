"""
Author: Yash Sengupta, IIITB, under guidance of Prof. Madhav Rao.
This code is used to generate any non-recursive multiplier configuration given the multiplier configuration
"""

from __future__ import absolute_import
from __future__ import print_function
import  pyverilog.vparser.ast as vast
from    pyverilog.ast_code_generator.codegen import ASTCodeGenerator


def generate_partial_product_array(a_width, b_width):
    
    list_of_partial_products = {}
    
    for i in range (a_width + b_width - 1):
        list_of_partial_products[i] = []
        
    
    for i in range(a_width):
        for j in range(b_width):
            
            list_of_partial_products[i+j].append([i, j])
            
    return list_of_partial_products
            


def generate_multiplier(a_width, b_width):
    

    # print(f"RTL generated for exact_{a_width}_{b_width} architecutre ")
    params = vast.Paramlist( [] )
    
    max_width = max(a_width, b_width)
    sum_width = a_width + b_width
    
    partial_product_array = generate_partial_product_array(a_width, b_width)
    
    sum_width_1 = sum_width + 0
    a_width_1 = a_width + 0
    b_width_1 = b_width + 0
    
    
    a_width = vast.Width( vast.IntConst(f'{a_width - 1}'), vast.IntConst('0') )
    b_width = vast.Width( vast.IntConst(f'{b_width - 1}'), vast.IntConst('0') )
    
    if a_width_1 == 1 or b_width_1 == 1:
        sum_width = vast.Width( vast.IntConst(f'{sum_width - 2}'), vast.IntConst('0') )
    else:
        sum_width = vast.Width( vast.IntConst(f'{sum_width - 1}'), vast.IntConst('0') )
    
    a = vast.Ioport( vast.Input('A', width=a_width) )
    b = vast.Ioport( vast.Input('B', width=b_width) )
    
    res_out = vast.Ioport( vast.Output('P', width=sum_width) )
    
    # Create a list to hold the ports
    ports = vast.Portlist( [a, b, res_out] )
    
    # Create a list to hold the items of the verilog code
    items = []
    
    
    carry_current_array = []
    carry_next_array = []
    
    for i in range(sum_width_1 - 1):
        
        partial_product_array_Wires = []

        for item in partial_product_array[i]:
            j, k = tuple(item)
            
            partial_product_array_Wires.append(vast.Wire(f'PP_{j}{k}'))
            
            partial_product_assign = vast.Assign(
                vast.Lvalue(vast.Identifier(f'PP_{j}{k}')), 
                vast.Rvalue(vast.And(vast.Identifier(f"A[{j}]"), vast.Identifier(f"B[{k}]")))
                )
            items.append(partial_product_assign)
            
        if len(partial_product_array_Wires) == 1 and len(carry_current_array) == 0:
            
            a_0, b_0 = partial_product_array[i][0]
            first_assign = vast.Assign(
                vast.Lvalue(vast.Identifier(f"P[{i}]")),
                vast.Rvalue(vast.Identifier(f"PP_{a_0}{b_0}"))
            )
            
            items.append(first_assign)
            
            
        elif ((len(partial_product_array_Wires) == 1) and (len(carry_current_array) != 0)):

            a_2, b_2 = partial_product_array[i][0]
            final_sum_assign = vast.Assign(
                vast.Lvalue(vast.Identifier(f'sum{i}_0')), 
                vast.Rvalue(vast.Xor(vast.Identifier(f"PP_{a_2}{b_2}"), vast.Identifier(f"carry{i-1}_0")))
                )
            final_carry = vast.Wire(f"carry{i}_0")
            carry_next_array.append(final_carry)
            final_carry_assign = vast.Assign(
                vast.Lvalue(vast.Identifier(f'carry{i}_0')), 
                vast.Rvalue(vast.And(vast.Identifier(f"PP_{a_2}{b_2}"), vast.Identifier(f"carry{i-1}_0")))
                )
            
            items.append(final_sum_assign)
            items.append(final_carry_assign)
            
            for x in range(1, len(carry_current_array)):
                sum_assign = vast.Assign(
                vast.Lvalue(vast.Identifier(f'sum{i}_{x}')), 
                vast.Rvalue(vast.Xor(vast.Identifier(f"sum{i}_{x-1}"), vast.Identifier(f"carry{i-1}_{x}")))
                )
                final_carry = vast.Wire(f"carry{i}_{x}")
                carry_next_array.append(final_carry)
                carry_assign = vast.Assign(
                    vast.Lvalue(vast.Identifier(f'carry{i}_{x}')), 
                    vast.Rvalue(vast.And(vast.Identifier(f"sum{i}_{x-1}"), vast.Identifier(f"carry{i-1}_{x}")))
                    )
                
                items.append(sum_assign)
                items.append(carry_assign)
            
            first_assign = vast.Assign(
                vast.Lvalue(vast.Identifier(f"P[{i}]")),
                vast.Rvalue(vast.Identifier(f"sum{i}_{len(carry_current_array) - 1}"))
            )
            
            items.append(first_assign)
            
            if carry_next_array:  # Ensure there are items to OR together
                or_expression = vast.Identifier(f'carry{i}_{0}')

                # Iterate through the rest of the carries and OR them together
                for y in range(1, len(carry_next_array)):
                    or_expression = vast.Or(or_expression, vast.Identifier(f"carry{i}_{y}"))
                
                # Create the assignment
                assign_node = vast.Assign(
                    vast.Lvalue(vast.Identifier(f"P[{i+1}]")),  # LHS of assignment
                    vast.Rvalue(or_expression)                   # RHS of assignment (OR expression)
                )
                
                items.append(assign_node)
            
            
        else:
            
            len_of_sums = len(partial_product_array_Wires)
            len_of_carry = len(carry_current_array)
            
            
            # FIrst add the parital products to the sum

            a, b = partial_product_array[i][0]
            c, d = partial_product_array[i][1]
            
            sum_initial = vast.Wire(f"sum{i}_0")
            initial_sum_assign = vast.Assign(
                vast.Lvalue(vast.Identifier(f"sum{i}_0")),
                vast.Rvalue(vast.Xor(vast.Identifier(f"PP_{a}{b}"), vast.Identifier(f"PP_{c}{d}")))
            )
            
            carry_initial = vast.Wire(f"carry{i}_0")
            carry_next_array.append(carry_initial)
            
            
            initial_carry_assign = vast.Assign(
                vast.Lvalue(vast.Identifier(f"carry{i}_0")),
                vast.Rvalue(vast.And(vast.Identifier(f"PP_{a}{b}"), vast.Identifier(f"PP_{c}{d}")))
            )
            
            
            items.append(initial_sum_assign)
            items.append(initial_carry_assign)
            
            
            
            for x in range(2, len_of_sums):
                
                a_1, b_1 = partial_product_array[i][x]
                sum_wire = vast.Wire(f"sum{i}_{x-1}")
                sum_assign = vast.Assign(
                    vast.Lvalue(vast.Identifier(f"sum{i}_{x-1}")),
                    vast.Rvalue(vast.Xor(vast.Identifier(f"PP_{a_1}{b_1}"), vast.Identifier(f"sum{i}_{x-2}")))
                    )
                
                
                carry_wire = vast.Wire(f"carry{i}_{x-1}")
                carry_next_array.append(carry_wire)
                carry_assign = vast.Assign(
                    vast.Lvalue(vast.Identifier(f"carry{i}_{x-1}")),
                    vast.Rvalue(vast.And(vast.Identifier(f"PP_{a_1}{b_1}"), vast.Identifier(f"sum{i}_{x-2}")))
                    )
                
                items.append(sum_assign)
                items.append(carry_assign)
                
            # Now we need to add the carry of the previous stages to the sum
            
            if i != 1:
            
                sum_second_assign = vast.Assign(
                    vast.Lvalue(vast.Identifier(f"sum{i}_{len_of_sums - 1}")),
                    vast.Rvalue(vast.Xor(vast.Identifier(f"carry{i-1}_0"), vast.Identifier(f"sum{i}_{len_of_sums-2}")))
                    )
                
                
                second_initial_carry = vast.Wire(f"carry{i}_{len_of_sums - 1}")
                carry_next_array.append(second_initial_carry)
                
                carry_second_assign = vast.Assign(
                    vast.Lvalue(vast.Identifier(f"carry{i}_{len_of_sums - 1}")),
                    vast.Rvalue(vast.And(vast.Identifier(f"carry{i-1}_0"), vast.Identifier(f"sum{i}_{len_of_sums-2}")))
                )
            
                items.append(sum_second_assign)
                items.append(carry_second_assign)
                
            count = 1
            
            for x in range(len_of_sums, len_of_sums + len_of_carry - 1):
                
                sum_assign = vast.Assign(
                    vast.Lvalue(vast.Identifier(f"sum{i}_{x}")),
                    vast.Rvalue(vast.Xor(vast.Identifier(f"carry{i - 1}_{count}"), vast.Identifier(f"sum{i}_{x-1}")))
                    )
                
                
                
                carry_wire = vast.Wire(f"carry{i}_{x}")
                carry_next_array.append(carry_wire)
                
                carry_assign = vast.Assign(
                    vast.Lvalue(vast.Identifier(f"carry{i}_{x}")),
                    vast.Rvalue(vast.And(vast.Identifier(f"carry{i - 1}_{count}"), vast.Identifier(f"sum{i}_{x-1}")))
                    )
                
                count += 1
                
                items.append(sum_assign)
                items.append(carry_assign)
            
            first_assign = vast.Assign(
                vast.Lvalue(vast.Identifier(f"P[{i}]")),
                vast.Rvalue(vast.Identifier(f"sum{i}_{len_of_sums + len_of_carry - 2}"))
            )
            
            items.append(first_assign)
        
            carry_current_array = carry_next_array + []
            carry_next_array = []
        
    ast = vast.ModuleDef(f"exact_nr_{a_width_1}x{b_width_1}", params, ports, items)   
        
    
    
    codegen = ASTCodeGenerator()
    rslt = codegen.visit(ast)
    # print(rslt)
    return str(rslt)
    
def main():
    a_width = 6
    b_width = 6
    
    # print(generate_partial_product_array(a_width, b_width))
    generate_multiplier(a_width, b_width)
    
if __name__=="__main__":
    main()
