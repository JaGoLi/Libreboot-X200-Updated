/*
 *  x86compatibility.c
 *  This file is part of the ich9deblob utility from the libreboot project
 * 
 * Purpose: compiler/cpu compatibility checks. ich9deblob is not portable, yet.
 *
 *  Copyright (C) 2014 Steve Shenton <sgsit@libreboot.org>
 *                     Leah Rowe <info@minifree.org>
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "x86compatibility.h"

/*
 * ---------------------------------------------------------------------
 * x86 compatibility checking:
 * ---------------------------------------------------------------------
 */

/* fail if struct size is incorrect */
int structSizesIncorrect(struct DESCRIPTORREGIONRECORD descriptorDummy, struct GBEREGIONRECORD_8K gbe8kDummy) 
{
	unsigned int descriptorRegionStructSize = sizeof(descriptorDummy);
	unsigned int gbeRegion8kStructSize = sizeof(gbe8kDummy);
	
	/* check compiler bit-packs in a compatible way. basically, it is expected that this code will be used on x86 */
	if (DESCRIPTORREGIONSIZE != descriptorRegionStructSize){
		printf("\nerror: compiler incompatibility: descriptor struct length is %i bytes (should be %i)\n", descriptorRegionStructSize, DESCRIPTORREGIONSIZE);
		return 1;
	}
	if (GBEREGIONSIZE_8K != gbeRegion8kStructSize){
		printf("\nerror: compiler incompatibility: gbe struct length is %i bytes (should be %i)\n", gbeRegion8kStructSize, GBEREGIONSIZE_8K);
		return 1;
	}
	
	return 0;
}

/* fail if members are presented in the wrong order */
int structMembersWrongOrder()
{
	int i;
	struct DESCRIPTORREGIONRECORD descriptorDummy;
	uint8_t *meVsccTablePtr = (uint8_t*)&descriptorDummy.meVsccTable;
	
	/* These do not use bitfields.  */
	descriptorDummy.meVsccTable.jid0 = 0x01020304;  /* unsigned int 32-bit */
	descriptorDummy.meVsccTable.vscc0 = 0x10203040; /* unsigned int 32-bit */
	descriptorDummy.meVsccTable.jid1 = 0x11223344;  /* unsigned int 32-bit */
	descriptorDummy.meVsccTable.vscc1 = 0x05060708; /* unsigned int 32-bit */
	descriptorDummy.meVsccTable.jid2 = 0x50607080;  /* unsigned int 32-bit */
	descriptorDummy.meVsccTable.vscc2 = 0x55667788; /* unsigned int 32-bit */
	descriptorDummy.meVsccTable.padding[0] = 0xAA;  /* unsigned char 8-bit */
	descriptorDummy.meVsccTable.padding[1] = 0xBB;  /* unsigned char 8-bit */
	descriptorDummy.meVsccTable.padding[2] = 0xCC;  /* unsigned char 8-bit */
	descriptorDummy.meVsccTable.padding[3] = 0xDD;  /* unsigned char 8-bit */
	
	/*
	 * Look from the top down, and concatenate the unsigned ints but
	 * with each unsigned in little endian order. 
	 * Then, concatenate the unsigned chars in big endian order. (in the padding array)
	 *
	 * combined, these should become:
	 * 01020304 10203040 11223344 05060708 50607080 55667788 AA BB CC DD (ignore this. big endian. just working it out manually:)
	 * 04030201 40302010 44332211 08070605 80706050 88776655 AA BB CC DD (ignore this. not byte-separated, just working it out:)
	 * 04 03 02 01 40 30 20 10 44 33 22 11 08 07 06 05 80 70 60 50 88 77 66 55 AA BB CC DD <-- it should match this
	 */
	
	if (
			!
			(
				*meVsccTablePtr      == 0x04 && *(meVsccTablePtr+1)  == 0x03 && *(meVsccTablePtr+2)  == 0x02 && *(meVsccTablePtr+3)  == 0x01
			&& *(meVsccTablePtr+4)  == 0x40 && *(meVsccTablePtr+5)  == 0x30 && *(meVsccTablePtr+6)  == 0x20 && *(meVsccTablePtr+7)  == 0x10
			&& *(meVsccTablePtr+8)  == 0x44 && *(meVsccTablePtr+9)  == 0x33 && *(meVsccTablePtr+10) == 0x22 && *(meVsccTablePtr+11) == 0x11
			&& *(meVsccTablePtr+12) == 0x08 && *(meVsccTablePtr+13) == 0x07 && *(meVsccTablePtr+14) == 0x06 && *(meVsccTablePtr+15) == 0x05
			&& *(meVsccTablePtr+16) == 0x80 && *(meVsccTablePtr+17) == 0x70 && *(meVsccTablePtr+18) == 0x60 && *(meVsccTablePtr+19) == 0x50
			&& *(meVsccTablePtr+20) == 0x88 && *(meVsccTablePtr+21) == 0x77 && *(meVsccTablePtr+22) == 0x66 && *(meVsccTablePtr+23) == 0x55
			&& *(meVsccTablePtr+24) == 0xAA && *(meVsccTablePtr+25) == 0xBB && *(meVsccTablePtr+26) == 0xCC && *(meVsccTablePtr+27) == 0xDD
	      )
	   ) {
			
		printf("\nStruct member order check (descriptorDummy.meVsccTable) with junk/dummy data:");
		printf("\nShould be: 04 03 02 01 40 30 20 10 44 33 22 11 08 07 06 05 80 70 60 50 88 77 66 55 aa bb cc dd ");
		printf("\nAnd it is: ");
		
		for (i = 0; i < 28; i++) {
			printf("%02x ", *(meVsccTablePtr + i));	
		}
		printf("\nIncorrect order.\n");
		
		return 1;
	}
	
	return 0;
}

/* fail if bit fields are presented in the wrong order */
int structBitfieldWrongOrder() 
{
	int i;
	struct DESCRIPTORREGIONRECORD descriptorDummy;
	uint8_t *flMap0Ptr = (uint8_t*)&descriptorDummy.flMaps.flMap0;
	
	descriptorDummy.flMaps.flMap0.FCBA = 0xA2;      /* :8 --> 10100010 */
	descriptorDummy.flMaps.flMap0.NC = 0x02;        /* :2 --> 10       */
	descriptorDummy.flMaps.flMap0.reserved1 = 0x38; /* :6 --> 111000   */
	descriptorDummy.flMaps.flMap0.FRBA = 0xD2;      /* :8 --> 11010010 */
	descriptorDummy.flMaps.flMap0.NR = 0x05;        /* :3 --> 101      */
	descriptorDummy.flMaps.flMap0.reserved2 = 0x1C; /* :5 --> 11100    */
	
	/*
	 * Look from the top bottom up, and concatenate the binary strings.
	 * Then, convert the 8-bit groups to hex and reverse the (8-bit)byte order
	 * 
	 * combined, these should become (in memory), in binary:
	 * 10100010 11100010 11010010 11100101
	 * or in hex:
	 * A2 E2 D2 E5
	 */
		
	if (!(*flMap0Ptr == 0xA2 && *(flMap0Ptr+1) == 0xE2 && *(flMap0Ptr+2) == 0xD2 && *(flMap0Ptr+3) == 0xE5)) 
	{
		printf("\nBitfield order check (descriptorDummy.flMaps.flMaps0) with junk/dummy data:");
		printf("\nShould be: a2 e2 d2 e5 ");
		printf("\nAnd it is: ");

		for (i = 0; i < 4; i++) {
			printf("%02x ", *(flMap0Ptr + i));	
		}
		printf("\nIncorrect order.\n");
		
		return 1;
	}
	
	return 0;
}

/* Compatibility checks. This version of ich9deblob is not yet porable. */
int systemOrCompilerIncompatible(struct DESCRIPTORREGIONRECORD descriptorStruct, struct GBEREGIONRECORD_8K gbeStruct8k) 
{
	if (structSizesIncorrect(descriptorStruct, gbeStruct8k)) return 1;
	if (IS_BIG_ENDIAN) {
		printf("big endian not supported\n");
		return 1;
	}
	if (structBitfieldWrongOrder()) return 1;
	if (structMembersWrongOrder()) return 1; 
	return 0;
}
