# Author: Joel Klint

import sys

lines = []
for line in sys.stdin:
    lines.append(line.strip())

splitted_lines = []
for line in lines:
    splitted_lines.append(line.split(','))

transposed_lines = []
for i in range(len(splitted_lines[0])):
    new_line = []
    for j in range(len(splitted_lines)):
        new_line.append(splitted_lines[j][i])
    transposed_lines.append(new_line)

for line in transposed_lines:
    print(",".join(line))
