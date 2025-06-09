import heapq
import os

def calculate_nucleotide_frequency():
    #Create a dictionary with each nucleotide and its current frequency 
    frequency = {'A': 0, 'C': 0, 'G': 0, 'T': 0}
    
    with open("dna.txt", 'r') as file:
        dna = file.read()
        #for loop for each element in file
        
        for i in dna:
            #if statement to make sure element is a nucleotide
            
            if i in frequency:
                #add +1 nucleotide frequency
                frequency[i] += 1
                
    return frequency

def build_huffman_tree(nucleotide_frequency):
    #create a heap of tuples with the nucelotide and nucleotide_frequency
    heap = [(freq, char) for char, freq in nucleotide_frequency.items()]
    heapq.heapify(heap)
    
    #merge the nodes until it constructs a single tree
    while len(heap) > 1:
        left_freq, left_char = heapq.heappop(heap)
        right_freq, right_char = heapq.heappop(heap)
        merged_freq = left_freq + right_freq
        merged_node = (merged_freq, (left_char, right_char))
        heapq.heappush(heap, merged_node)
    
    #return single tree
    return heap[0][1]

def build_huffman_codes(node, current_code, huffman_codes):
    #recursive fuction that travels the tree and generates huffman codes
    #basecase if the node is a leaf assign the current code to character
    if isinstance(node, str):
        huffman_codes[node] = current_code
        return
    
    #if not repeat on each branch until a leaf is found
    build_huffman_codes(node[0], current_code + '0', huffman_codes)
    build_huffman_codes(node[1], current_code + '1', huffman_codes)

def huffman_coding():
    #makes use of the nuclotide_frequency function
    nucleotide_frequency = calculate_nucleotide_frequency()
    
    #bulid the tree with the frequency
    huffman_tree = build_huffman_tree(nucleotide_frequency)
    huffman_codes = {}
    build_huffman_codes(huffman_tree, '', huffman_codes)
    
    return huffman_codes

def encode_and_save_compressed(filename, huffman_codes, output_filename):
    #open the dna.txt filename for reusibility
    with open(filename, 'r') as file:
        sequence = file.read()
        #add the corresponding huffman_code nucleotide to sequence
        compressed_sequence = ''.join(huffman_codes[nucleotide] for nucleotide in sequence)
    
    #write the sequence to output_file compressed.txt
    with open(output_filename, 'w') as output_file:
        output_file.write(compressed_sequence)

if __name__ == '__main__':
    
    #calling the requried functions
    frequency = calculate_nucleotide_frequency()
    print("Nuclotide Frquency:")
    print(frequency)
    
    huffman_codes = huffman_coding()
    print("Huffman codes:")
    print(huffman_codes)
    
    encode_and_save_compressed('dna.txt', huffman_codes, 'compressed.txt')