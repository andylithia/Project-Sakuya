#!/usr/bin/python3

import sys

if len(sys.argv) < 3:
    fname = sys.argv[0].split('/')[-1]
    print(f'Usage: python3 {fname} [depth] [prefix]') 
    sys.exit()
else:
    depth  = int(sys.argv[1])
    prefix = sys.argv[2]
    module_name = f'{prefix}_pyMUX{depth}'
    print('// Python Generated Module: ',module_name)
    fp_out = open(module_name+'.v', 'w+')
    olines = []

    copyright_lines = """// MIT License
// 
// Copyright (c) 2022 andylithia
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

// Autogenerated MUX tree
"""
    olines.append(copyright_lines)
    dwidth = 2**depth;
    # Generate module interface
    olines.append(f'module {module_name} (\n')
    olines.append(f'    input [{dwidth}-1:0] A,\n')
    olines.append(f'    input [{depth}-1:0] S,\n')
    olines.append(f'    output Y\n')
    olines.append(f');\n')
    
    for i in range(depth-1):
        i_depth = depth-i
        i_dwidth = 2**(i_depth-1)
        olines.append(f'wire [{i_dwidth}-1:0] mux_level{i_depth}/* synthesis keep */;\n')
    olines.append('wire mux_level1/* synthesis keep */;\n')
    olines.append('genvar gi;\n')
    olines.append('generate\n')
    for i in range(depth-1):
        i_depth = depth-i
        i_dwidth = 2**(i_depth-1)
        olines.append(f'    for(gi=0;gi<{i_dwidth};gi=gi+1) begin : gen_muxl{i_depth}\n')
        olines.append(f'        assign mux_level{i_depth}[gi] = S[{i}]?mux_level{(i_depth+1)}[2*gi+1]:mux_level{(i_depth+1)}[2*gi];\n')
        olines.append(f'    end\n')
    
    # Finish up
    olines.append('endgenerate\n')
    olines.append(f'assign mux_level1 = S[{(depth-1)}]?mux_level2[1]:mux_level2[0];\n')
    olines.append(f'assign mux_level{depth} = A;\n')
    olines.append( 'assign Y = mux_level1;\n')
    olines.append(f'endmodule /* {module_name} */')
    
    fp_out.writelines(olines)
    fp_out.close()
#  vim: set ts=4 sw=4 et 
