#include "HCMS29xx_Util.h"

#define HCMS_CFG_USE_RPL_CHAR_EXTENSION

const unsigned char HCMS57FONT[] = {
        0x00, 0x00, 0x00, 0x00, 0x00,            // (0x20)
        0x00, 0x00, 0x5E, 0x00, 0x00,            // !
        0x00, 0x06, 0x00, 0x06, 0x00,            // "
        0x14, 0x3E, 0x14, 0x3E, 0x14,            // #
        0x2C, 0x2A, 0x7F, 0x2A, 0x1A,            // $
        0x4E, 0x2A, 0x3C, 0x54, 0x72,            // %
        0x78, 0x4E, 0x4E, 0x36, 0x56,            // &
        0x00, 0x00, 0x06, 0x00, 0x00,            // '
        0x00, 0x00, 0x3E, 0x41, 0x00,            // (
        0x00, 0x41, 0x3E, 0x00, 0x00,            // )
        0x2A, 0x1C, 0x3E, 0x1C, 0x2A,            // *
        0x08, 0x08, 0x3E, 0x08, 0x08,            // +
        0x00, 0x00, 0x60, 0x00, 0x00,            // ,
        0x00, 0x08, 0x08, 0x08, 0x00,            // -
        0x00, 0x00, 0x20, 0x00, 0x00,            // .
        0x00, 0x60, 0x1C, 0x03, 0x00,            // /
        0x3E, 0x42, 0x5A, 0x42, 0x7C,            // 0
        0x00, 0x04, 0x02, 0x7E, 0x00,            // 1
        0x66, 0x52, 0x52, 0x4A, 0x6E,            // 2
        0x66, 0x42, 0x4A, 0x4A, 0x76,            // 3
        0x18, 0x14, 0x12, 0x12, 0x7E,            // 4
        0x6E, 0x4A, 0x4A, 0x4A, 0x3A,            // 5
        0x7C, 0x4A, 0x4A, 0x4A, 0x7A,            // 6
        0x06, 0x02, 0x62, 0x1A, 0x06,            // 7
        0x76, 0x4A, 0x4A, 0x4A, 0x76,            // 8
        0x6E, 0x4A, 0x4A, 0x4A, 0x3E,            // 9
        0x00, 0x00, 0x24, 0x00, 0x00,            // :
        0x00, 0x00, 0x64, 0x00, 0x00,            // ;
        0x00, 0x18, 0x24, 0x42, 0x00,            // <
        0x14, 0x14, 0x14, 0x14, 0x14,            // =
        0x00, 0x42, 0x24, 0x18, 0x00,            // >
        0x00, 0x02, 0x52, 0x0A, 0x0E,            // ?
        0x3C, 0x42, 0x5A, 0x52, 0x5C,            // @
        0x7C, 0x0A, 0x0A, 0x0A, 0x7C,            // A
        0x7E, 0x4A, 0x4A, 0x4A, 0x7C,            // B
        0x7E, 0x42, 0x42, 0x42, 0x64,            // C
        0x7E, 0x42, 0x42, 0x42, 0x7C,            // D
        0x7E, 0x4A, 0x4A, 0x4A, 0x42,            // E
        0x7E, 0x0A, 0x0A, 0x0A, 0x02,            // F
        0x7E, 0x42, 0x42, 0x52, 0x76,            // G
        0x7E, 0x08, 0x08, 0x08, 0x7E,            // H
        0x00, 0x42, 0x7E, 0x42, 0x00,            // I
        0x00, 0x22, 0x42, 0x3E, 0x00,            // J
        0x7E, 0x18, 0x24, 0x42, 0x42,            // K
        0x7E, 0x40, 0x40, 0x40, 0x40,            // L
        0x7E, 0x08, 0x10, 0x08, 0x7E,            // M
        0x7E, 0x08, 0x10, 0x20, 0x7E,            // N
        0x3E, 0x42, 0x42, 0x42, 0x7C,            // O
        0x7E, 0x0A, 0x0A, 0x0A, 0x0E,            // P
        0x7E, 0x42, 0x52, 0x62, 0x7C,            // Q
        0x7E, 0x0A, 0x1A, 0x2A, 0x4E,            // R
        0x4E, 0x4A, 0x4A, 0x4A, 0x72,            // S
        0x02, 0x02, 0x7E, 0x02, 0x02,            // T
        0x3E, 0x40, 0x40, 0x40, 0x7E,            // U
        0x1E, 0x20, 0x40, 0x40, 0x7E,            // V
        0x7E, 0x20, 0x10, 0x20, 0x7E,            // W
        0x42, 0x24, 0x18, 0x24, 0x42,            // X
        0x4E, 0x48, 0x48, 0x48, 0x7E,            // Y
        0x42, 0x62, 0x5A, 0x46, 0x42,            // Z
        0x00, 0x00, 0x7F, 0x41, 0x00,            // [
        0x00, 0x03, 0x1C, 0x60, 0x00,            // BackSlash
        0x00, 0x41, 0x7F, 0x00, 0x00,            // ]
        0x00, 0x04, 0x02, 0x04, 0x00,            // ^
        0x00, 0x40, 0x40, 0x40, 0x00,            // _
        0x00, 0x02, 0x04, 0x00, 0x00,            // `
        0x00, 0x74, 0x54, 0x78, 0x00,            // a
        0x00, 0x7C, 0x48, 0x78, 0x00,            // b
        0x00, 0x7C, 0x44, 0x6C, 0x00,            // c
        0x00, 0x78, 0x48, 0x7C, 0x00,            // d
        0x00, 0x3C, 0x54, 0x4C, 0x00,            // e
        0x00, 0x10, 0x7C, 0x14, 0x00,            // f
        0x00, 0x5C, 0x54, 0x7C, 0x00,            // g
        0x00, 0x7C, 0x08, 0x78, 0x00,            // h
        0x00, 0x00, 0x74, 0x00, 0x00,            // i
        0x00, 0x40, 0x74, 0x00, 0x00,            // j
        0x00, 0x7C, 0x10, 0x68, 0x00,            // k
        0x00, 0x3F, 0x40, 0x40, 0x00,            // l
        0x78, 0x08, 0x78, 0x08, 0x70,            // m
        0x00, 0x78, 0x08, 0x70, 0x00,            // n
        0x00, 0x78, 0x48, 0x78, 0x00,            // o
        0x00, 0x7C, 0x24, 0x3C, 0x00,            // p
        0x00, 0x3C, 0x24, 0x7C, 0x00,            // q
        0x00, 0x00, 0x7C, 0x04, 0x00,            // r
        0x00, 0x58, 0x58, 0x68, 0x00,            // s
        0x00, 0x08, 0x7C, 0x48, 0x00,            // t
        0x00, 0x78, 0x40, 0x78, 0x00,            // u
        0x00, 0x38, 0x40, 0x38, 0x00,            // v
        0x18, 0x60, 0x18, 0x60, 0x18,            // w
        0x00, 0x48, 0x30, 0x48, 0x00,            // x
        0x00, 0x4C, 0x50, 0x3C, 0x00,            // y
        0x00, 0x68, 0x68, 0x58, 0x00,            // z
        0x00, 0x08, 0x77, 0x41, 0x00,            // {
        0x00, 0x00, 0x77, 0x00, 0x00,            // |
        0x00, 0x41, 0x77, 0x08, 0x00,            // }
        0x10, 0x08, 0x10, 0x08, 0x00,            // ~
        0xFF, 0xFF, 0xFF, 0xFF, 0xFF,            // 
		
#ifdef HCMS_CFG_USE_RPL_CHAR_EXTENSION
		0x20, 0x30, 0x28, 0x24, 0x22,            // Angle
        0x45, 0x2D, 0x11, 0x69, 0x45,            // Arithmetic mean
        0x06, 0x1A, 0x22, 0x1A, 0x06,            // Nabla
        0x20, 0x40, 0x7E, 0x02, 0x06,            // Square root
        0x20, 0x40, 0x3E, 0x01, 0x02,            // Integral
        0x63, 0x55, 0x49, 0x41, 0x63,            // Sigma
        0x00, 0x3E, 0x1C, 0x08, 0x00,            // Solid arrow to right
        0x44, 0x3C, 0x04, 0x7C, 0x44,            // Pi
        0x00, 0x30, 0x49, 0x4A, 0x3C,            // Partial dee
        0x50, 0x58, 0x54, 0x52, 0x51,            // <=
        0x51, 0x52, 0x54, 0x58, 0x50,            // >=
        0x28, 0x68, 0x38, 0x2C, 0x28,            // !=
        0x00, 0x70, 0x48, 0x30, 0x48,            // alpha
        0x08, 0x08, 0x3E, 0x1C, 0x08,            // Right arrow
        0x08, 0x1C, 0x3E, 0x08, 0x08,            // Letf arrow
        0x08, 0x18, 0x3E, 0x18, 0x08,            // Down arrow
	
        0x08, 0x0C, 0x3E, 0x0C, 0x08,            // Up arrow
        0x02, 0x34, 0x48, 0x34, 0x02,            // gamma
        0x00, 0x36, 0x4A, 0x32, 0x00,            // delta
        0x28, 0x54, 0x44, 0x28, 0x00,            // epsilon
        0x00, 0x0E, 0x42, 0x3C, 0x00,            // eta
        0x00, 0x3C, 0x4A, 0x3C, 0x00,            // theta
        0x00, 0x64, 0x18, 0x30, 0x40,            // lambda
        0x00, 0x78, 0x14, 0x08, 0x00,            // rho
        0x00, 0x30, 0x48, 0x38, 0x08,            // sigma
        0x00, 0x08, 0x38, 0x48, 0x08,            // tau
        0x30, 0x48, 0x20, 0x48, 0x30,            // omega
        0x60, 0x58, 0x44, 0x58, 0x60,            // Delta
        0x42, 0x7E, 0x02, 0x7E, 0x42,            // Pi
        0x58, 0x64, 0x04, 0x64, 0x58,            // Omega
        0x7E, 0x7E, 0x7E, 0x7E, 0x7E,            // Black square
        0x10, 0x28, 0x10, 0x28, 0x10,            // Infinity
		
        0x10, 0x38, 0x54, 0x44, 0x28,            // Euro
        0x00, 0x00, 0x7A, 0x00, 0x00,            // Inverted exclamation
        0x18, 0x64, 0x3C, 0x26, 0x14,            // Cent
        0x20, 0x68, 0x5E, 0x49, 0x42,            // Pound
        0x42, 0x3C, 0x24, 0x3C, 0x42,            // Currency
        0x15, 0x16, 0x7C, 0x16, 0x15,            // Yen
        0x00, 0x00, 0x77, 0x00, 0x00,            // Vertical bar
        0x20, 0x4C, 0x36, 0x19, 0x02,            // Section sign
        0x00, 0x00, 0x02, 0x00, 0x02,            // Diaeresis
        0x7F, 0x6D, 0x69, 0x75, 0x7F,            // Inv 3
        0x00, 0x00, 0x0D, 0x0B, 0x0E,            // Femine ordinal indicator
        0x08, 0x14, 0x2A, 0x14, 0x22,            // <<
        0x08, 0x08, 0x08, 0x08, 0x18,            // Negation
        0x00, 0x00, 0x00, 0x00, 0x00,            // SHY(NULL)
        0x7F, 0x6D, 0x65, 0x6B, 0x7F,            // Inv 2
        0x00, 0x04, 0x04, 0x04, 0x00,            // Macron
		
        0x00, 0x04, 0x0A, 0x04, 0x00,            // Degree symbol
        0x44, 0x44, 0x5F, 0x44, 0x44,            // Plus-minus
        0x00, 0x00, 0x09, 0x0D, 0x0A,            // ^2
        0x00, 0x00, 0x09, 0x0B, 0x0D,            // ^3
        0x00, 0x00, 0x04, 0x02, 0x00,            // Acute accent
        0x00, 0x7E, 0x10, 0x0E, 0x00,            // Mirco
        0x0C, 0x7E, 0x02, 0x7E, 0x02,            // Pilcrow
        0x00, 0x10, 0x38, 0x10, 0x00,            // Interpunct
        0x00, 0x00, 0x58, 0x28, 0x00,            // Cedilla
        0x00, 0x00, 0x02, 0x0F, 0x00,            // ^1
        0x00, 0x00, 0x02, 0x05, 0x02,            // Masculine ordinal indicator
        0x22, 0x14, 0x2A, 0x14, 0x08,            // >>
		/*
        0x47, 0x00, 0x20, 0x30, 0x69,            // 1/4
        0x47, 0x00, 0x48, 0x68, 0x51,            // 1/2
        0x49, 0x0B, 0x25, 0x30, 0x69,            // 3/4
        0x00, 0x30, 0x4A, 0x20, 0x00,            // Inverted question
		*/
#endif /* HCMS_CFG_USE_RPL_CHAR_EXTENSION */
};

uint8_t* HCMS29xx_fetchChar(uint8_t ASCII, uint8_t* outBuffer){
    for(int i=0;i<5;i++)
      outBuffer[i]=HCMS57FONT[5*(ASCII-' ')+i];
	return outBuffer;
}

uint8_t* HCMS29xx_stringBuilder(uint8_t* string, int len, uint8_t* outBuffer){
	for(int i=0;i<len;i++){
		if(string[i]=='\0')
			break;
		HCMS29xx_fetchChar(string[i],outBuffer+5*i);
	}
	return outBuffer;
}

/* Vitrual Buffer:
*   Group
*	#row 0 1 2 3 4 5 6 7 8
*        |-------|     | |
*        \    DATA     / Properity
*
*	Properity:
*		 7 6 5 4 3 2 1 0
*              | | | | |
*              | | | \Shade Level
*              | \Blink Duty
*              \Inv?
*/
uint8_t* HCMS29xx_VirtualBuffer_2Physical(uint8_t* vBuffer, uint8_t* pBuffer, uint8_t blank, uint8_t shadeLevel){
	// note: to do partial copy, use (vBuffer+9*BEGINNING) in place of vBuffer
	for(int group=0; group<4; group++){
		// if argument shadeLevel > Group shade level properity val
		// fill corresponding pBuffer group with 0
		if(blank|(shadeLevel>(0x03&vBuffer[group*9+8]))){
			for(int row=0; row<5; row++)
				pBuffer[group*5+row]=0;
			continue;
		}
		// Else, do copy row 0~5 from virtual buffer to physical buffer
		// Inverted
		if(vBuffer[group*9+8]&0x10)
			for(int row=0; row<5; row++)
				pBuffer[group*5+row]=~vBuffer[group*9+row];		
		else
			for(int row=0; row<5; row++)
				pBuffer[group*5+row]=vBuffer[group*9+row];	
	}
	return vBuffer;
}

uint8_t* HCMS29xx_VirtualBuffer_LeftShift(uint8_t* vBuffer, uint8_t count){
	uint8_t tmp0=vBuffer[0];
	
	for(int group=0; group<count-1; group++){
		for(int row=0; row<8-1; row++)
			vBuffer[group*9+row]=vBuffer[group*9+row+1];	
		vBuffer[group*9+7]=vBuffer[(group+1)*9+0];
	}
	
	for(int row=0; row<8-1; row++)
		vBuffer[(count-1)*9+row]=vBuffer[(count-1)*9+row+1];
	vBuffer[(count-1)*9+7]=tmp0;
	return vBuffer;
}

uint8_t* HCMS29xx_VirtualBuffer_StringBuilder(uint8_t* string, int len, uint8_t* vBuffer){
	for(int i=0;i<len;i++){
		if(string[i]=='\0')
			break;
		HCMS29xx_fetchChar(string[i],vBuffer+9*i);
		vBuffer[9*i+5]=0x00;
		vBuffer[9*i+6]=0x00;
		vBuffer[9*i+7]=0x00;
	}
	return vBuffer;
}

uint8_t* HCMS29xx_VirtualBuffer_SetShadePattern(uint8_t* vBuffer,uint8_t bufferLen, int pattern){
	for(int i=0;i<bufferLen;i++){
		vBuffer[i*9+8]=(pattern&0x01)?0x03:0x00;
		pattern>>=1;
	}
	return vBuffer;
}