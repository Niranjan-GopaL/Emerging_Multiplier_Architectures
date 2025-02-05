from collections import OrderedDict
from pprint import pprint

dummy_value = 0
def ordered_to_dict(ordered_dict):
    if isinstance(ordered_dict, OrderedDict):
        return {k: ordered_to_dict(v) for k, v in ordered_dict.items()}
    return ordered_dict

def parse_multiplier_string(s):
    global dummy_value
    dummy_value = 0  # Reset dummy value counter

    def parse_module(tokens, index):
        global dummy_value

        if index >= len(tokens):
            return OrderedDict(), index

        current_token = tokens[index]
        if not (current_token.startswith('rr') or current_token.startswith('nr')):
            return OrderedDict(), index

        is_recursive = current_token.startswith('rr')
        dims = current_token.split('x')
        x = int(dims[0][2:])
        y = int(dims[1])
        key = (dummy_value, x, y, 'rr' if is_recursive else 'nr')
        dummy_value += 1

        result = OrderedDict()
        result[key] = OrderedDict()
        index += 1

        if is_recursive and index < len(tokens) and tokens[index] == 'B':
            index += 1  # Skip 'B'

            for _ in range(4):
                if index >= len(tokens):
                    break
                submodule, new_index = parse_module(tokens, index)
                if submodule:
                    result[key].update(submodule)
                index = new_index

            if index < len(tokens) and tokens[index] == 'B':
                index += 1  # Skip closing 'B'

        return result, index

    tokens = s.strip('_').split('__')
    result, _ = parse_module(tokens, 0)
    return result

def main():
    test_strings = [
        "rr8x8__B__nr6x6__nr6x2__nr2x6__nr2x2__B__",
        "rr8x8__B__rr6x6__B__nr3x3__nr3x3__nr3x3__nr3x3__B__nr6x2__nr2x6__nr2x2__B__",
        "rr8x8__B__rr6x6__B__nr1x1__nr1x5__nr5x1__rr5x5__B__rr4x4__B__nr1x1__nr1x3__nr3x1__rr3x3__B__nr1x1__nr1x2__nr2x1__nr2x2__B__B__nr4x1__nr1x4__nr1x1__B__B__nr6x2__nr2x6__nr2x2__B__"
    ]
    for test in test_strings:
        ordered_result = parse_multiplier_string(test)
        pprint(ordered_result)                            # Print ordered dictionary
        normal_result = ordered_to_dict(ordered_result)  # Convert OrderedDict to dict
        pprint(normal_result)                            # Print normal dictionary ( again in sorted order )

if __name__ == "__main__":
    main()
