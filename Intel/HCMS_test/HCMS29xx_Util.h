// MIT License
// 
// Copyright (c) 2016 andylithia
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

#ifndef __HCMS29XX_UTIL_H
#define __HCMS29XX_UTIL_H

#include "arduino.h"

uint8_t* HCMS29xx_fetchChar(uint8_t ASCII, uint8_t* outBuffer);
uint8_t* HCMS29xx_stringBuilder(uint8_t* string, int len, uint8_t* outBuffer);

// Vitrual Buffer extension
#define m_HCMS29xx_VirtualBuffer_Create(NAME,LENGTH) \
				uint8_t NAME[LENGTH*9]
uint8_t* HCMS29xx_VirtualBuffer_2Physical(uint8_t* vBuffer, uint8_t* pBuffer, uint8_t blank, uint8_t shadeLevel);
uint8_t* HCMS29xx_VirtualBuffer_LeftShift(uint8_t* vBuffer, uint8_t count);
uint8_t* HCMS29xx_VirtualBuffer_StringBuilder(uint8_t* string, int len, uint8_t* vBuffer);
uint8_t* HCMS29xx_VirtualBuffer_SetShadePattern(uint8_t* vBuffer,uint8_t bufferLen, int pattern);

#endif /* __HCMS29XX_UTIL_H */