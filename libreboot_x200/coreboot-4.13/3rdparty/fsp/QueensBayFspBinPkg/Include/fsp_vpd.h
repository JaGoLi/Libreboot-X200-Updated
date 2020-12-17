/** @file

Copyright (C) 2013, Intel Corporation

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright notice, this
  list of conditions and the following disclaimer in the documentation and/or
  other materials provided with the distribution.
* Neither the name of Intel Corporation nor the names of its contributors may
  be used to endorse or promote products derived from this software without
  specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
  THE POSSIBILITY OF SUCH DAMAGE.

  This file is automatically generated. Please do NOT modify !!!

**/

#ifndef __VPDHEADER_H__
#define __VPDHEADER_H__

#pragma pack(1)



typedef struct _UPD_DATA_REGION {
  UINT64                      Signature;                     /* Offset 0x0000 */
  UINT64                      Reserved;                      /* Offset 0x0008 */
  UINT8                       Dummy[240];                    /* Offset 0x0010 */
  UINT8                       HdaVerbTableHeader[12];        /* Offset 0x0100 */
  UINT32                      HdaVerbTableDataLength;        /* Offset 0x010C */
  UINT8                       HdaVerbTableData0[16];         /* Offset 0x0110 */
  UINT8                       HdaVerbTableData1[16];         /* Offset 0x0120 */
  UINT8                       HdaVerbTableData2[16];         /* Offset 0x0130 */
  UINT8                       HdaVerbTableData3[16];         /* Offset 0x0140 */
  UINT8                       HdaVerbTableData4[16];         /* Offset 0x0150 */
  UINT8                       HdaVerbTableData5[16];         /* Offset 0x0160 */
  UINT8                       HdaVerbTableData6[16];         /* Offset 0x0170 */
  UINT8                       HdaVerbTableData7[16];         /* Offset 0x0180 */
  UINT8                       HdaVerbTableData8[16];         /* Offset 0x0190 */
  UINT8                       HdaVerbTableData9[16];         /* Offset 0x01A0 */
  UINT8                       HdaVerbTableData10[16];        /* Offset 0x01B0 */
  UINT8                       HdaVerbTableData11[16];        /* Offset 0x01C0 */
  UINT8                       HdaVerbTableData12[16];        /* Offset 0x01D0 */
  UINT8                       HdaVerbTableData13[16];        /* Offset 0x01E0 */
  UINT8                       HdaVerbTableDataPad[47];       /* Offset 0x01F0 */
  UINT16                      PcdRegionTerminator;           /* Offset 0x021F */
} UPD_DATA_REGION;

#define VPD_IMAGE_ID    0x445056574F4E4E4D        /* 'MNNOWVPD' */
#define VPD_IMAGE_REV   0x00000301 

typedef struct _VPD_DATA_REGION {
  UINT64                      PcdVpdRegionSign;              /* Offset 0x0000 */
  UINT32                      PcdImageRevision;              /* Offset 0x0008 */
  UINT32                      PcdUpdRegionOffset;            /* Offset 0x000C */
  UINT8                       UnusedVpdSpace0[16];           /* Offset 0x0010 */
  UINT32                      PcdFspReservedMemoryLength;    /* Offset 0x0020 */
  UINT8                       PcdDisablePCIExpPort1;         /* Offset 0x0024 */
  UINT8                       PcdDisablePCIExpPort2;         /* Offset 0x0025 */
  UINT8                       PcdDisablePCIExpPort3;         /* Offset 0x0026 */
  UINT8                       PcdEnableAzalia;               /* Offset 0x0027 */
  UINT8                       PcdLegacySegDecode;            /* Offset 0x0028 */
  UINT8                       PcdPCIExpPortToIOH;            /* Offset 0x0029 */
} VPD_DATA_REGION;

#pragma pack()

#endif
