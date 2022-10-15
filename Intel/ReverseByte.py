#!/usr/bin/env python3
#  MIT License
#  
#  Copyright (c) 2022 andylithia
#  
#  Permission is hereby granted, free of charge, to any person obtaining a copy
#  of this software and associated documentation files (the "Software"), to deal
#  in the Software without restriction, including without limitation the rights
#  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#  copies of the Software, and to permit persons to whom the Software is
#  furnished to do so, subject to the following conditions:
#  
#  The above copyright notice and this permission notice shall be included in all
#  copies or substantial portions of the Software.
#  
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#  SOFTWARE.
#

# Arduino VIDOR4000 FPGA bitstream reverse utility

import os
import sys

def reverse_Bits(n, no_of_bits):
    result = 0
    for i in range(no_of_bits):
        result <<= 1
        result |= n & 1
        n >>= 1
    return result

if len(sys.argv)!=3:
    print('Expecting 2 arguments. Usage:');
    print('> python3 ',sys.argv[0].split('/')[-1],' [Input File] [Output File]')
    sys.exit()
fn_in = sys.argv[1]
fp=open(fn_in,'r')
strin = ''
strout = ''
count = 0
while fp.readable():
    strin += fp.read()
fp.close()
listin = strin.split(',')
for e in listin:
    e = int(e,0)
    er = reverse_Bits(e,8)
    strout+=f'0x{e:02X},'
    count += 1
print(f'{count} bytes processed')
strout=strout[:-1]
fn_out = sys.argv[2]
fp = open(fn_out,'w+')
fp.write(strout)
fp.close()
