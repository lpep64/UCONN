def split_large_file(input_file, lines_per_file=10000):
    with open(input_file, 'r', encoding='utf-8') as source_file:
        line_count = 0
        file_number = 1
        output_file = None

        for line in source_file:
            if line_count % lines_per_file == 0:
                if output_file:
                    output_file.close()
                output_file = open(f'output_{file_number}.txt', 'w', encoding='utf-8')
                file_number += 1

            output_file.write(line)
            line_count += 1

        if output_file:
            output_file.close()

if __name__ == "__main__":
    input_file = 'Q2dictionary.txt'
    split_large_file(input_file)