/*
 *  demefactory.c
 *  This file is part of the demefactory utility from the libreboot project
 * 
 * Purpose: disable ME on GM45 factory firmware, but leave region intact
 * 			enable read-write on all regions
 *
 *	 Copyright (C) 2014, 2015 Leah Rowe <info@minifree.org>
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
 
/* 
 * demfactory utility - main
 */

#include "demefactory.h"

int main()
{
	struct DESCRIPTORREGIONRECORD descriptorStruct;
	uint8_t* descriptorBuffer = (uint8_t*)&descriptorStruct;
	
	struct GBEREGIONRECORD_8K gbeStruct8k; /* not needed, except for compatibility checking */
	
	char* romFilename = "factory.rom";
	char* descriptorFilename = "demefactory_4kdescriptor.bin";
	
	unsigned int bufferLength;
	unsigned int romSize;
	
	/*
	 * ------------------------------------------------------------------
	 * Compatibility checks. This version of ich9deblob is not yet portable.
	 * ------------------------------------------------------------------
	 */

	if (systemOrCompilerIncompatible(descriptorStruct, gbeStruct8k)) return 1;
	/* If true, fail with error message */
	
	/*
	 * ------------------------------------------------------------------
	 * Extract the descriptor region from the factory.rom dump
	 * ------------------------------------------------------------------
	 */
	FILE* fp = NULL;
	fp = fopen(romFilename, "rb"); /* open factory.rom */
	if (NULL == fp)
	{
		printf("\nerror: could not open %s\n", romFilename);
		fclose(fp);
		return 1;
	}
	printf("\n%s opened successfully\n", romFilename);
	
	/* 
	 * Get the descriptor region dump from the factory.rom
	 * (goes in factoryDescriptorBuffer variable)
	 */
	bufferLength = fread(descriptorBuffer, 1, DESCRIPTORREGIONSIZE, fp);
	if (DESCRIPTORREGIONSIZE != bufferLength) // 
	{
		printf("\nerror: could not read descriptor from %s (%i) bytes read\n", romFilename, bufferLength);
		fclose(fp);
		return 1;
	}
	printf("\ndescriptor region read successfully\n");
	
	/* ------------------------------------------------- */

	fseek(fp, 0L, SEEK_END);
	romSize = ftell(fp);
	printf("\n%s size: [%i] bytes\n", romFilename, romSize);
	
	/* -------------------------------------------------- */

	fclose(fp);
	
	/* Debugging (before modification) */
	printDescriptorRegionLocations(descriptorStruct, "Original");
	
	/*
	 * ------------------------------------------------------------------
	 * Modify the descriptor region, ready to go in the modified factory.rom
	 * ------------------------------------------------------------------
	 */

	// Disable the ME/TPM:
	descriptorStruct = descriptorDisableMe(descriptorStruct);
	descriptorStruct = descriptorDisableTpm(descriptorStruct);
	
	/* Host/CPU is allowed to read/write all regions. */
	descriptorStruct = descriptorHostRegionsUnlocked(descriptorStruct);
	/* The ME is disallowed read-write access to all regions
	 * (this is probably redundant, since the ME is already removed from libreboot) */
	descriptorStruct = descriptorMeRegionsForbidden(descriptorStruct);

	/* Debugging (after modifying the descriptor region) */
	printDescriptorRegionLocations(descriptorStruct, "Modified");

	/*
	 * ------------------------------------------------------------------
	 * Create the file with the modified descriptor inside
	 * ------------------------------------------------------------------
	 */

	printf("\n");
	if (notCreated4kDescriptorFile(descriptorStruct, descriptorFilename)) {
		return 1;
	}
	
	/*
	 * ------------------------------------------------------------------
	 * Generate ich9gen data (C code that will recreate the deactivatedME descriptor from scratch)
	 * ------------------------------------------------------------------
	 */
	/* Code for generating the Descriptor struct */
	/* mkdescriptor.h */
	if (notCreatedHFileForDescriptorCFile("mkdescriptor.h", "mkdescriptor.c")) {
		return 1;
	} /* and now mkdescriptor.c */
	if (notCreatedCFileFromDescriptorStruct(descriptorStruct, "mkdescriptor.c", "mkdescriptor.h")) {
		return 1;
	}
	
	printf("The modified descriptor region has also been dumped as src files: mkdescriptor.c, mkdescriptor.h\n\n");

	return 0;
}
