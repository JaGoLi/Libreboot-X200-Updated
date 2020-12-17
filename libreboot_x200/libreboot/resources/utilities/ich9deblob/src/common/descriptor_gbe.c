/*
 *  descriptor_gbe.c
 *  This file is part of the ich9deblob utility from the libreboot project
 * 
 * Purpose: common descriptor/gbe functions used by ich9deblob
 *
 *  Copyright (C) 2014, 2015 Leah Rowe <info@minifree.org>
 *  Copyright (C) 2014 Steve Shenton <sgsit@libreboot.org>
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
 
#include "descriptor_gbe.h"

/* 
 * create 12KiB file with descriptor, and then gbe immediately after.
 */
int notCreatedDescriptorGbeFile(struct DESCRIPTORREGIONRECORD descriptorStruct, struct GBEREGIONRECORD_8K gbeStruct8k, char* fileName)
{
	FILE* fileStream = NULL;
	
	/* delete old file before continuing */
	remove(fileName);
	
	/* open new file for writing the descriptor+gbe */
	fileStream = fopen(fileName, "ab");
	
	/* write the descriptor region into the first part */
	if (DESCRIPTORREGIONSIZE != fwrite((uint8_t*)&descriptorStruct, 1, sizeof(descriptorStruct), fileStream))
	{
		printf("\nerror: writing descriptor region failed\n");
		return 1;
	}
	
	/* add gbe to the end of the file */
	if (GBEREGIONSIZE_8K != fwrite((uint8_t*)&gbeStruct8k, 1, sizeof(gbeStruct8k), fileStream))
	{
		printf("\nerror: writing GBe region failed\n");
		return 1;
	}
	
	fclose(fileStream);
	
	printf("descriptor and gbe successfully written to the file: %s\n", fileName);
	printf("Now do: dd if=%s of=libreboot.rom bs=1 count=12k conv=notrunc\n", fileName);
	printf("(in other words, add the modified descriptor+gbe to your ROM image)\n\n");
	
	return 0;
}

/* 
 * create 4KiB file with descriptor
 */
int notCreated4kDescriptorFile(struct DESCRIPTORREGIONRECORD descriptorStruct, char* fileName)
{
	FILE* fileStream = NULL;
	
	/* delete old file before continuing */
	remove(fileName);
	
	/* open new file for writing the descriptor+gbe */
	fileStream = fopen(fileName, "ab");
	
	/* write the descriptor region into the first part */
	if (DESCRIPTORREGIONSIZE != fwrite((uint8_t*)&descriptorStruct, 1, sizeof(descriptorStruct), fileStream))
	{
		printf("\nerror: writing descriptor region failed\n");
		return 1;
	}
	
	
	fclose(fileStream);
	
	printf("descriptor successfully written to the file: %s\n", fileName);
	printf("Now do: dd if=%s of=yourrom.rom bs=1 count=4k conv=notrunc\n", fileName);
	printf("(in other words, add the modified descriptor to your ROM image)\n\n");
	
	return 0;
}
