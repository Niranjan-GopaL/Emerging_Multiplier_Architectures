


def generate_temp_config(config_number, n_bits):
    
    temp_config = []
    H = config_number
    L = n_bits - config_number
    
    temp_config = [[H,H], [H,L], [L,H], [L,L]]
    return temp_config, H, L

def main():
    config_number = 2
    n_bits = 3
    config, _, _ = generate_temp_config(config_number, n_bits)
    # print(config)
    
if __name__ == "__main__":
    main()