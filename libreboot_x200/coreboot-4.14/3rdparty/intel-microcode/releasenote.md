# Release Notes

## [microcode-20201118](https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/releases/tag/microcode-20201118)

### Purpose

- Removed TGL/06-8c-01/80 due to functional issues with some OEM platforms.

### New Platforms

None

### Updated Platforms

None

### Removed Platforms

| Processor      | Stepping | F-M-S/PI    | Old Ver  | New Ver  | Products
|:---------------|:---------|:------------|:---------|:---------|:---------
| TGL            | B1       | 06-8c-01/80 | 00000068 |          | Core Gen11 Mobile

## [microcode-20201112](https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/releases/tag/microcode-20201112)

### Purpose

- Security updates for [INTEL-SA-00381](https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00381.html).
- Security updates for [INTEL-SA-00389](https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00389.html).

### New Platforms

None

### Updated Platforms

| Processor      | Stepping | F-M-S/PI    | Old Ver  | New Ver  | Products
|:---------------|:---------|:------------|:---------|:---------|:---------
| GLK            | B0       | 06-7a-01/01 | 00000032 | 00000034 | Pentium Silver N/J5xxx, Celeron N/J4xxx

### Removed Platforms

None

## [microcode-20201110](https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/releases/tag/microcode-20201110)

### Purpose

- Security updates for [INTEL-SA-00381](https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00381.html).
- Security updates for [INTEL-SA-00389](https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00389.html).
- Update for functional issues. Refer to [Second Generation Intel® Xeon® Processor Scalable Family Specification Update](https://cdrdv2.intel.com/v1/dl/getContent/338848) for details.
- Update for functional issues. Refer to [Intel® Xeon® Processor Scalable Family Specification Update](https://cdrdv2.intel.com/v1/dl/getContent/613537) for details.
- Update for functional issues. Refer to [Intel® Xeon® Processor E5 v3 Product Family Specification Update](https://www.intel.com/content/www/us/en/processors/xeon/xeon-e5-v3-spec-update.html?wapkw=processor+spec+update+e5) for details.
- Update for functional issues. Refer to [10th Gen Intel® Core™ Processor Families Specification Update](https://www.intel.com/content/www/us/en/products/docs/processors/core/10th-gen-core-families-specification-update.html) for details.
- Update for functional issues. Refer to [8th and 9th Gen Intel® Core™ Processor Family Spec Update](https://www.intel.com/content/www/us/en/products/docs/processors/core/8th-gen-core-spec-update.html) for details.
- Update for functional issues. Refer to [7th Gen and 8th Gen (U Quad-Core) Intel® Processor Families Specification Update](https://www.intel.com/content/www/us/en/processors/core/7th-gen-core-family-spec-update.html) for details.
- Update for functional issues. Refer to [6th Gen Intel® Processor Family Specification Update](https://cdrdv2.intel.com/v1/dl/getContent/332689) for details.
- Update for functional issues. Refer to [Intel® Xeon® E3-1200 v6 Processor Family Specification Update](https://www.intel.com/content/www/us/en/processors/xeon/xeon-e3-1200v6-spec-update.html) for details.
- Update for functional issues. Refer to [Intel® Xeon® E-2100 and E-2200 Processor Family Specification Update](https://www.intel.com/content/www/us/en/products/docs/processors/xeon/xeon-e-2100-specification-update.html) for details.


### New Platforms

| Processor      | Stepping | F-M-S/PI    | Old Ver  | New Ver  | Products
|:---------------|:---------|:------------|:---------|:---------|:---------
| CPX-SP         | A1       | 06-55-0b/bf |          | 0700001e | Xeon Scalable Gen3
| LKF            | B2/B3    | 06-8a-01/10 |          | 00000028 | Core w/Hybrid Technology
| TGL            | B1       | 06-8c-01/80 |          | 00000068 | Core Gen11 Mobile
| CML-H          | R1       | 06-a5-02/20 |          | 000000e0 | Core Gen10 Mobile
| CML-S62        | G1       | 06-a5-03/22 |          | 000000e0 | Core Gen10
| CML-S102       | Q0       | 06-a5-05/22 |          | 000000e0 | Core Gen10 
| CML-U62 V2     | K0       | 06-a6-01/80 |          | 000000e0 | Core Gen10 Mobile

### Updated Platforms

| Processor      | Stepping | F-M-S/PI    | Old Ver  | New Ver  | Products
|:---------------|:---------|:------------|:---------|:---------|:---------
| HSX-E/EP       | Cx/M1    | 06-3f-02/6f | 00000043 | 00000044 | Core Gen4 X series; Xeon E5 v3
| SKL-U/Y        | D0       | 06-4e-03/c0 | 000000d6 | 000000e2 | Core Gen6 Mobile
| SKL-U23e       | K1       | 06-4e-03/c0 | 000000d6 | 000000e2 | Core Gen6 Mobile
| SKX-SP         | B1       | 06-55-03/97 | 01000157 | 01000159 | Xeon Scalable
| SKX-SP         | H0/M0/U0 | 06-55-04/b7 | 02006906 | 02006a08 | Xeon Scalable
| SKX-D          | M1       | 06-55-04/b7 | 02006906 | 02006a08 | Xeon D-21xx
| CLX-SP         | B0       | 06-55-06/bf | 04002f01 | 04003003 | Xeon Scalable Gen2
| CLX-SP         | B1       | 06-55-07/bf | 05002f01 | 05003003 | Xeon Scalable Gen2
| APL            | D0       | 06-5c-09/03 | 00000038 | 00000040 | Pentium N/J4xxx, Celeron N/J3xxx, Atom x5/7-E39xx
| APL            | E0       | 06-5c-0a/03 | 00000016 | 0000001e | Atom x5-E39xx
| SKL-H/S        | R0/N0    | 06-5e-03/36 | 000000d6 | 000000e2 | Core Gen6; Xeon E3 v5
| GKL-R          | R0       | 06-7a-08/01 | 00000016 | 00000018 | Pentium J5040/N5030, Celeron J4125/J4025/N4020/N4120
| ICL-U/Y        | D1       | 06-7e-05/80 | 00000078 | 000000a0 | Core Gen10 Mobile
| AML-Y22        | H0       | 06-8e-09/10 | 000000d6 | 000000de | Core Gen8 Mobile
| KBL-U/Y        | H0       | 06-8e-09/c0 | 000000d6 | 000000de | Core Gen7 Mobile
| CFL-U43e       | D0       | 06-8e-0a/c0 | 000000d6 | 000000e0 | Core Gen8 Mobile
| WHL-U          | W0       | 06-8e-0b/d0 | 000000d6 | 000000de | Core Gen8 Mobile
| AML-Y42        | V0       | 06-8e-0c/94 | 000000d6 | 000000de | Core Gen10 Mobile
| CML-Y42        | V0       | 06-8e-0c/94 | 000000d6 | 000000de | Core Gen10 Mobile
| WHL-U          | V0       | 06-8e-0c/94 | 000000d6 | 000000de | Core Gen8 Mobile
| KBL-G/H/S/E3   | B0       | 06-9e-09/2a | 000000d6 | 000000de | Core Gen7; Xeon E3 v6
| CFL-H/S/E3     | U0       | 06-9e-0a/22 | 000000d6 | 000000de | Core Gen8 Desktop, Mobile, Xeon E
| CFL-S          | B0       | 06-9e-0b/02 | 000000d6 | 000000de | Core Gen8
| CFL-H/S        | P0       | 06-9e-0c/22 | 000000d6 | 000000de | Core Gen9
| CFL-H          | R0       | 06-9e-0d/22 | 000000d6 | 000000de | Core Gen9 Mobile
| CML-U62        | A0       | 06-a6-00/80 | 000000ca | 000000e0 | Core Gen10 Mobile

### Removed Platforms

None

## [microcode-20200616](https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/releases/tag/microcode-20200616)

### Purpose

- Revert to previous versions due to reported system hang.

### New Platforms

None

### Updated Platforms

| Processor      | Stepping | F-M-S/PI    | Old Ver  | New Ver  | Products
|:---------------|:---------|:------------|:---------|:---------|:---------
| SKL-U/Y        | D0       | 06-4e-03/c0 | 000000dc | 000000d6 | Core Gen6 Mobile
| SKL-U23e       | K1       | 06-4e-03/c0 | 000000dc | 000000d6 | Core Gen6 Mobile
| SKL-H/S        | R0/N0    | 06-5e-03/36 | 000000dc | 000000d6 | Core Gen6; Xeon E3 v5

### Removed Platforms

None

## [microcode-20200609](https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/releases/tag/microcode-20200609)

### Purpose

- Security updates for [INTEL-SA-00329](https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00329.html).

### New Platforms

None

### Updated Platforms

| Processor      | Stepping | F-M-S/PI    | Old Ver  | New Ver  | Products
|:---------------|:---------|:------------|:---------|:---------|:---------
| HSW            | C0       | 06-3c-03/32 | 00000027 | 00000028 | Core Gen4
| BDW-U/Y        | E0/F0    | 06-3d-04/c0 | 0000002e | 0000002f | Core Gen5
| HSW-U          | C0/D0    | 06-45-01/72 | 00000025 | 00000026 | Core Gen4
| HSW-H          | C0       | 06-46-01/32 | 0000001b | 0000001c | Core Gen4
| BDW-H/E3       | E0/G0    | 06-47-01/22 | 00000021 | 00000022 | Core Gen5
| SKL-U/Y        | D0       | 06-4e-03/c0 | 000000d6 | 000000dc | Core Gen6 Mobile
| SKL-U23e       | K1       | 06-4e-03/c0 | 000000d6 | 000000dc | Core Gen6 Mobile
| SKX-SP         | B1       | 06-55-03/97 | 01000151 | 01000157 | Xeon Scalable
| SKX-SP         | H0/M0/U0 | 06-55-04/b7 | 02000065 | 02006906 | Xeon Scalable
| SKX-D          | M1       | 06-55-04/b7 | 02000065 | 02006906 | Xeon D-21xx
| CLX-SP         | B0       | 06-55-06/bf | 0400002c | 04002f01 | Xeon Scalable Gen2
| CLX-SP         | B1       | 06-55-07/bf | 0500002c | 05002f01 | Xeon Scalable Gen2
| SKL-H/S        | R0/N0    | 06-5e-03/36 | 000000d6 | 000000dc | Core Gen6; Xeon E3 v5
| AML-Y22        | H0       | 06-8e-09/10 | 000000ca | 000000d6 | Core Gen8 Mobile
| KBL-U/Y        | H0       | 06-8e-09/c0 | 000000ca | 000000d6 | Core Gen7 Mobile
| CFL-U43e       | D0       | 06-8e-0a/c0 | 000000ca | 000000d6 | Core Gen8 Mobile
| WHL-U          | W0       | 06-8e-0b/d0 | 000000ca | 000000d6 | Core Gen8 Mobile
| AML-Y42        | V0       | 06-8e-0c/94 | 000000ca | 000000d6 | Core Gen10 Mobile
| CML-Y42        | V0       | 06-8e-0c/94 | 000000ca | 000000d6 | Core Gen10 Mobile
| WHL-U          | V0       | 06-8e-0c/94 | 000000ca | 000000d6 | Core Gen8 Mobile
| KBL-G/H/S/E3   | B0       | 06-9e-09/2a | 000000ca | 000000d6 | Core Gen7; Xeon E3 v6
| CFL-H/S/E3     | U0       | 06-9e-0a/22 | 000000ca | 000000d6 | Core Gen8 Desktop, Mobile, Xeon E
| CFL-S          | B0       | 06-9e-0b/02 | 000000ca | 000000d6 | Core Gen8
| CFL-H/S        | P0       | 06-9e-0c/22 | 000000ca | 000000d6 | Core Gen9
| CFL-H          | R0       | 06-9e-0d/22 | 000000ca | 000000d6 | Core Gen9 Mobile

### Removed Platforms

None

## [microcode-20200520](https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/releases/tag/microcode-20200520)

### Purpose

- Update to SA00233.

### New Platforms

None

### Updated Platforms

| Processor      | Stepping | F-M-S/PI    | Old Ver  | New Ver  | Products
|:---------------|:---------|:------------|:---------|:---------|:---------
| SNB-E/EN/EP    | C1/M0    | 06-2d-06/6d | 0000061f | 00000621 | Xeon E3/E5, Core X
| SNB-E/EN/EP    | C2/M1    | 06-2d-07/6d | 00000718 | 0000071a | Xeon E3/E5, Core X

### Removed Platforms

None

## [microcode-20200508](https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/releases/tag/microcode-20200508)

### Purpose

- Update for functional issues. Refer to [10th Gen Intel® Core™ Processor Families Specification Update](https://www.intel.com/content/www/us/en/products/docs/processors/core/10th-gen-core-families-specification-update.html) for details.

### New Platforms

None

### Updated Platforms

| Processor      | Stepping | F-M-S/PI    | Old Ver  | New Ver  | Products
|:---------------|:---------|:------------|:---------|:---------|:---------
| ICL-U/Y        | D1       | 06-7e-05/80 | 00000046 | 00000078 | Core Gen10 Mobile

### Removed Platforms

None

## [microcode-20191115](https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/releases/tag/microcode-20191115)

### Purpose

- Update for functional issues. Refer to [10th Gen Intel® Core™ Processor Families Specification Update](https://www.intel.com/content/www/us/en/products/docs/processors/core/10th-gen-core-families-specification-update.html) for details.
- Update for functional issues. Refer to [8th and 9th Gen Intel® Core™ Processor Family Spec Update](https://www.intel.com/content/www/us/en/products/docs/processors/core/8th-gen-core-spec-update.html) for details.
- Update for functional issues. Refer to [7th Gen and 8th Gen (U Quad-Core) Intel® Processor Families Specification Update](https://www.intel.com/content/www/us/en/processors/core/7th-gen-core-family-spec-update.html) for details.
- Update for functional issues. Refer to [6th Gen Intel® Processor Family Specification Update](https://cdrdv2.intel.com/v1/dl/getContent/332689) for details.
- Update for functional issues. Refer to [Intel® Xeon® E3-1200 v6 Processor Family Specification Update](https://www.intel.com/content/www/us/en/processors/xeon/xeon-e3-1200v6-spec-update.html) for details.
- Update for functional issues. Refer to [Intel® Xeon® E-2100 and E-2200 Processor Family Specification Update](https://www.intel.com/content/www/us/en/products/docs/processors/xeon/xeon-e-2100-specification-update.html) for details.

### New Platforms

None

### Updated Platforms

| Processor      | Stepping | F-M-S/PI    | Old Ver  | New Ver  | Products
|:---------------|:---------|:------------|:---------|:---------|:---------
| SKL-U/Y        | D0       | 06-4e-03/c0 | 000000d4 | 000000d6 | Core Gen6 Mobile
| SKL-U23e       | K1       | 06-4e-03/c0 | 000000d4 | 000000d6 | Core Gen6 Mobile
| SKL-H/S/E3     | N0/R0/S0 | 06-5e-03/36 | 000000d4 | 000000d6 | Core Gen6
| AML-Y22        | H0       | 06-8e-09/10 | 000000c6 | 000000ca | Core Gen8 Mobile
| KBL-U/Y        | H0       | 06-8e-09/c0 | 000000c6 | 000000ca | Core Gen7 Mobile
| KBL-U23e       | J1       | 06-8e-09/c0 | 000000c6 | 000000ca | Core Gen7 Mobile
| CFL-U43e       | D0       | 06-8e-0a/c0 | 000000c6 | 000000ca | Core Gen8 Mobile
| KBL-R U        | Y0       | 06-8e-0a/c0 | 000000c6 | 000000ca | Core Gen8 Mobile
| WHL-U          | W0       | 06-8e-0b/d0 | 000000c6 | 000000ca | Core Gen8 Mobile
| AML-Y42        | V0       | 06-8e-0c/94 | 000000c6 | 000000ca | Core Gen10 Mobile
| WHL-U          | V0       | 06-8e-0c/94 | 000000c6 | 000000ca | Core Gen8 Mobile
| CML-U42        | V0       | 06-8e-0c/94 | 000000c6 | 000000ca | Core Gen10 Mobile
| KBL-G/H/S/X/E3 | B0       | 06-9e-09/2a | 000000c6 | 000000ca | Core Gen7 Desktop, Mobile, Xeon E3 v6
| CFL-H/S/E3     | U0       | 06-9e-0a/22 | 000000c6 | 000000ca | Core Gen8 Desktop, Mobile, Xeon E
| CFL-S          | B0       | 06-9e-0b/02 | 000000c6 | 000000ca | Core Gen8
| CFL-S          | P0       | 06-9e-0c/22 | 000000c6 | 000000ca | Core Gen9 Desktop
| CFL-H/S/E3     | R0       | 06-9e-0d/22 | 000000c6 | 000000ca | Core Gen9 Desktop, Mobile, Xeon E
| CML-U62        | A0       | 06-a6-00/80 | 000000c6 | 000000ca | Core Gen10 Mobile

### Removed Platforms

None

## [microcode-20191113](https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/releases/tag/microcode-20191113)

### Purpose

- Security updates for [INTEL-SA-00270](https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00270.html).
- Correction in release notes for specific processor to CFL-S only.  Prior release showed as CFL-H/S.

### New Platforms

None

### Updated Platforms

| Processor      | Stepping | F-M-S/PI    | Old Ver  | New Ver  | Products
|:---------------|:---------|:------------|:---------|:---------|:---------
| CFL-S          | P0       | 06-9e-0c/22 | 000000ae | 000000c6 | Core Gen9 Desktop

### Removed Platforms

None

## [microcode-20191112](https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/releases/tag/microcode-20191112)

### Purpose

- Security updates for [INTEL-SA-00233](https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00233.html).
- Security updates for [INTEL-SA-00270](https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00270.html).
- Update to SA00270.

### New Platforms

| Processor      | Stepping | F-M-S/PI    | Old Ver  | New Ver  | Products
|:---------------|:---------|:------------|:---------|:---------|:---------
| AVN            | B0/C0    | 06-4d-08/01 |          | 0000012D | Atom C2xxx
| CML-U62        | A0       | 06-a6-00/80 |          | 000000c6 | Core Gen10 Mobile
| CNL-U          | D0       | 06-66-03/80 |          | 0000002a | Core Gen8 Mobile
| SKX-SP         | B1       | 06-55-03/97 |          | 01000151 | Xeon Scalable
| GKL            | B0       | 06-7a-01/01 |          | 00000032 | Pentium J5005/N5000, Celeron J4005/J4105/N4000/N4100
| GKL-R          | R0       | 06-7a-08/01 |          | 00000016 | Pentium J5040/N5030, Celeron J4125/J4025/N4020/N4120
| ICL U/Y        | D1       | 06-7e-05/80 |          | 00000046 | Core Gen10 Mobile

### Updated Platforms

| Processor      | Stepping | F-M-S/PI    | Old Ver  | New Ver  | Products
|:---------------|:---------|:------------|:---------|:---------|:---------
| SKL U/Y        | D0       | 06-4e-03/c0 | 000000cc | 000000d4 | Core Gen6 Mobile
| SKX-SP         | H0/M0/U0 | 06-55-04/b7 | 02000064 | 00000065 | Xeon Scalable
| SKX-D          | M1       | 06-55-04/b7 | 02000064 | 00000065 | Xeon D-21xx
| CLX-SP         | B0       | 06-55-06/bf | 0400002b | 0400002c | Xeon Scalable Gen2
| CLX-SP         | B1       | 06-55-07/bf | 0500002b | 0500002c | Xeon Scalable Gen2
| SKL H/S/E3     | R0/N0    | 06-5e-03/36 | 000000cc | 000000d4 | Core Gen6
| AML-Y22        | H0       | 06-8e-09/10 | 000000b4 | 000000c6 | Core Gen8 Mobile
| KBL-U/Y        | H0       | 06-8e-09/c0 | 000000b4 | 000000c6 | Core Gen7 Mobile
| CFL-U43e       | D0       | 06-8e-0a/c0 | 000000b4 | 000000c6 | Core Gen8 Mobile
| WHL-U          | W0       | 06-8e-0b/d0 | 000000b8 | 000000c6 | Core Gen8 Mobile
| AML-Y          | V0       | 06-8e-0c/94 | 000000b8 | 000000c6 | Core Gen10 Mobile
| CML-U42        | V0       | 06-8e-0c/94 | 000000b8 | 000000c6 | Core Gen10 Mobile
| WHL-U          | V0       | 06-8e-0c/94 | 000000b8 | 000000c6 | Core Gen8 Mobile
| KBL-G/X        | H0       | 06-9e-09/2a | 000000b4 | 000000c6 | Core Gen7/Gen8
| KBL-H/S/E3     | B0       | 06-9e-09/2a | 000000b4 | 000000c6 | Core Gen7; Xeon E3 v6
| CFL-H/S/E3     | U0       | 06-9e-0a/22 | 000000b4 | 000000c6 | Core Gen8 Desktop, Mobile, Xeon E
| CFL-S          | B0       | 06-9e-0b/02 | 000000b4 | 000000c6 | Core Gen8
| CFL-H          | R0       | 06-9e-0d/22 | 000000b8 | 000000c6 | Core Gen9 Mobile

### Removed Platforms

None

## [microcode-20190918](https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/releases/tag/microcode-20190918)

### Purpose

- Update for functional issues. Refer to [Intel® Xeon® Processor D-1500, D-1500 NS and D-1600 NS Spec Update](https://www.intel.com/content/www/us/en/products/docs/processors/xeon/xeon-d-1500-specification-update.html) for details.
- Update for functional issues. Refer to [Intel® Xeon® E7-8800 and E7-4800 v3 Processor Specification Update](https://www.intel.com/content/www/us/en/processors/xeon/xeon-e7-v3-spec-update.html) for details.
- Security updates for [INTEL-SA-00270](https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00270.html).

### New Platforms

None

### Updated Platforms

| Processor      | Stepping | F-M-S/PI    | Old Ver  | New Ver  | Products
|:---------------|:---------|:------------|:---------|:---------|:---------
| BDW-U/Y        | E0/F0    | 06-3d-04/c0 | 0000002d | 0000002e | Core Gen5
| HSX-EX         | E0       | 06-3f-04/80 | 00000014 | 00000016 | Xeon E7 v3
| BDW-H/E3       | E0/G0    | 06-47-01/22 | 00000020 | 00000021 | Core Gen5
| BDX-ML         | B0/M0/R0 | 06-4f-01/ef | 0b000036 | 0b000038 | Xeon E5/E7 v4; Core i7-69xx/68xx
| BDX-DE         | V1       | 06-56-02/10 | 0000001a | 0000001c | Xeon D-1520/40
| BDX-DE         | V2/3     | 06-56-03/10 | 07000017 | 07000019 | Xeon D-1518/19/21/27/28/31/33/37/41/48, Pentium D1507/08/09/17/19
| BDX-DE         | Y0       | 06-56-04/10 | 0f000015 | 0f000017 | Xeon D-1557/59/67/71/77/81/87
| BDX-NS         | A0       | 06-56-05/10 | 0e00000d | 0e00000f | Xeon D-1513N/23/33/43/53
| SKX-SP         | H0/M0/U0 | 06-55-04/b7 | 0200005e | 00000064 | Xeon Scalable
| SKX-D          | M1       | 06-55-04/b7 | 0200005e | 00000064 | Xeon D-21xx
| CLX-SP         | B1       | 06-55-07/bf | 05000021 | 0500002b | Xeon Scalable Gen2

### Removed Platforms

None

## [microcode-20190618](https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/releases/tag/microcode-20190618)

### Purpose

- Security updates for [INTEL-SA-00233](https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00233.html).

### New Platforms

None

### Updated Platforms0

| Processor      | Stepping | F-M-S/PI    | Old Ver  | New Ver  | Products
|:---------------|:---------|:------------|:---------|:---------|:---------
| SNB-E/EN/EP    | C1/M0    | 06-2d-06/6d | 0000061d | 0000061f | Xeon E3/E5, Core X
| SNB-E/EN/EP    | C2/M1    | 06-2d-07/6d | 00000714 | 00000718 | Xeon E3/E5, Core X

### Removed Platforms

None

## [microcode-20190514a](https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/releases/tag/microcode-20190514a)

### Purpose

- Resolved errors in releasenote from microcode-20190514a.

### New Platforms

| Processor      | Stepping | F-M-S/PI    | Old Ver  | New Ver  | Products
|:---------------|:---------|:------------|:---------|:---------|:---------
| VLV            | C0       | 06-37-08/02 |          | 00000838 | Atom Z series
| VLV            | C0       | 06-37-08/0C |          | 00000838 | Celeron N2xxx, Pentium N35xx
| VLV            | D0       | 06-37-09/0F |          | 0000090c | Atom E38xx
| CHV            | C0       | 06-4c-03/01 |          | 00000368 | Atom X series
| CHV            | D0       | 06-4c-04/01 |          | 00000411 | Atom X series
| CLX-SP         | B1       | 06-55-07/bf |          | 05000021 | Xeon Scalable Gen2

### Updated Platforms

| Processor      | Stepping | F-M-S/PI    | Old Ver  | New Ver  | Products
|:---------------|:---------|:------------|:---------|:---------|:---------
| SNB            | D2/G1/Q0 | 06-2a-07/12 | 0000002e | 0000002f | Core Gen2
| IVB            | E1/L1    | 06-3a-09/12 | 00000020 | 00000021 | Core Gen3
| HSW            | C0       | 06-3c-03/32 | 00000025 | 00000027 | Core Gen4
| BDW-U/Y        | E0/F0    | 06-3d-04/c0 | 0000002b | 0000002d | Core Gen5
| IVB-E/EP       | C1/M1/S1 | 06-3e-04/ed | 0000042d | 0000042e | Core Gen3 X Series; Xeon E5 v2
| IVB-EX         | D1       | 06-3e-07/ed | 00000714 | 00000715 | Xeon E7 v2
| HSX-E/EP       | Cx/M1    | 06-3f-02/6f | 00000041 | 00000043 | Core Gen4 X series; Xeon E5 v3
| HSX-EX         | E0       | 06-3f-04/80 | 00000013 | 00000014 | Xeon E7 v3
| HSW-U          | C0/D0    | 06-45-01/72 | 00000024 | 00000025 | Core Gen4
| HSW-H          | C0       | 06-46-01/32 | 0000001a | 0000001b | Core Gen4
| BDW-H/E3       | E0/G0    | 06-47-01/22 | 0000001e | 00000020 | Core Gen5
| SKL-U/Y        | D0/K1    | 06-4e-03/c0 | 000000c6 | 000000cc | Core Gen6
| BDX-ML         | B0/M0/R0 | 06-4f-01/ef | 0b00002e | 0b000036 | Xeon E5/E7 v4; Core i7-69xx/68xx
| SKX-SP         | H0/M0/U0 | 06-55-04/b7 | 0200005a | 0000005e | Xeon Scalable
| SKX-D          | M1       | 06-55-04/b7 | 0200005a | 0000005e | Xeon D-21xx
| BDX-DE         | V1       | 06-56-02/10 | 00000019 | 0000001a | Xeon D-1520/40
| BDX-DE         | V2/3     | 06-56-03/10 | 07000016 | 07000017 | Xeon D-1518/19/21/27/28/31/33/37/41/48, Pentium D1507/08/09/17/19
| BDX-DE         | Y0       | 06-56-04/10 | 0f000014 | 0f000015 | Xeon D-1557/59/67/71/77/81/87
| BDX-NS         | A0       | 06-56-05/10 | 0e00000c | 0e00000d | Xeon D-1513N/23/33/43/53
| APL            | D0       | 06-5c-09/03 | 00000036 | 00000038 | Pentium N/J4xxx, Celeron N/J3xxx, Atom x5/7-E39xx
| APL            | E0       | 06-5c-0a/03 | 0000000c | 00000016 | Atom x5-E39xx
| SKL-H/S        | R0/N0    | 06-5e-03/36 | 000000c6 | 000000cc | Core Gen6; Xeon E3 v5
| DNV            | B0       | 06-5f-01/01 | 00000024 | 0000002e | Atom C Series
| GLK            | B0       | 06-7a-01/01 | 0000002c | 0000002e | Pentium Silver N/J5xxx, Celeron N/J4xxx
| AML-Y22        | H0       | 06-8e-09/10 | 0000009e | 000000b4 | Core Gen8 Mobile
| KBL-U/Y        | H0       | 06-8e-09/c0 | 0000009a | 000000b4 | Core Gen7 Mobile
| CFL-U43e       | D0       | 06-8e-0a/c0 | 0000009e | 000000b4 | Core Gen8 Mobile
| WHL-U          | W0       | 06-8e-0b/d0 | 000000a4 | 000000b8 | Core Gen8 Mobile
| WHL-U          | V0       | 06-8e-0d/94 | 000000b2 | 000000b8 | Core Gen8 Mobile
| KBL-G/H/S/E3   | B0       | 06-9e-09/2a | 0000009a | 000000b4 | Core Gen7; Xeon E3 v6
| CFL-H/S/E3     | U0       | 06-9e-0a/22 | 000000aa | 000000b4 | Core Gen8 Desktop, Mobile, Xeon E
| CFL-S          | B0       | 06-9e-0b/02 | 000000aa | 000000b4 | Core Gen8
| CFL-H/S        | P0       | 06-9e-0c/22 | 000000a2 | 000000ae | Core Gen9
| CFL-H          | R0       | 06-9e-0d/22 | 000000b0 | 000000b8 | Core Gen9 Mobile

### Removed Platforms

None

## [microcode-20190514](https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/releases/tag/microcode-20190514)

### Purpose

- Security updates for [INTEL-SA-00233](https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00233.html).

### New Platforms

| Processor      | Stepping | F-M-S/PI    | Old Ver  | New Ver  | Products
|:---------------|:---------|:------------|:---------|:---------|:---------
| VLV            | C0       | 06-37-08/02 |          | 00000838 | Atom Z series
| VLV            | C0       | 06-37-08/0C |          | 00000838 | Celeron N2xxx, Pentium N35xx
| VLV            | D0       | 06-37-09/0F |          | 0000090c | Atom E38xx
| CHV            | C0       | 06-4c-03/01 |          | 00000368 | Atom X series
| CHV            | D0       | 06-4c-04/01 |          | 00000411 | Atom X series
| CLX-SP         | B1       | 06-55-07/bf |          | 05000021 | Xeon Scalable Gen2

### Updated Platforms

| Processor      | Stepping | F-M-S/PI    | Old Ver  | New Ver  | Products
|:---------------|:---------|:------------|:---------|:---------|:---------
| SNB            | D2/G1/Q0 | 06-2a-07/12 | 0000002e | 0000002f | Core Gen2
| IVB            | E1/L1    | 06-3a-09/12 | 00000020 | 00000021 | Core Gen3
| HSW            | C0       | 06-3c-03/32 | 00000025 | 00000027 | Core Gen4
| BDW-U/Y        | E0/F0    | 06-3d-04/c0 | 0000002b | 0000002d | Core Gen5
| IVB-E/EP       | C1/M1/S1 | 06-3e-04/ed | 0000042e | 0000042f | Core Gen3 X Series; Xeon E5 v2
| IVB-EX         | D1       | 06-3e-07/ed | 00000714 | 00000715 | Xeon E7 v2
| HSX-E/EP       | Cx/M1    | 06-3f-02/6f | 00000041 | 00000043 | Core Gen4 X series; Xeon E5 v3
| HSX-EX         | E0       | 06-3f-04/80 | 00000013 | 00000014 | Xeon E7 v3
| HSW-U          | C0/D0    | 06-45-01/72 | 00000024 | 00000025 | Core Gen4
| HSW-H          | C0       | 06-46-01/32 | 0000001a | 0000001b | Core Gen4
| BDW-H/E3       | E0/G0    | 06-47-01/22 | 0000001e | 00000020 | Core Gen5
| SKL-U/Y        | D0/K1    | 06-4e-03/c0 | 000000c6 | 000000cc | Core Gen6
| BDX-ML         | B0/M0/R0 | 06-4f-01/ef | 0b00002e | 00000036 | Xeon E5/E7 v4; Core i7-69xx/68xx
| SKX-SP         | H0/M0/U0 | 06-55-04/b7 | 0200005a | 0000005e | Xeon Scalable
| SKX-D          | M1       | 06-55-04/b7 | 0200005a | 0000005e | Xeon D-21xx
| BDX-DE         | V1       | 06-56-02/10 | 00000019 | 0000001a | Xeon D-1520/40
| BDX-DE         | V2/3     | 06-56-03/10 | 07000016 | 07000017 | Xeon D-1518/19/21/27/28/31/33/37/41/48, Pentium D1507/08/09/17/19
| BDX-DE         | Y0       | 06-56-04/10 | 0f000014 | 0f000015 | Xeon D-1557/59/67/71/77/81/87
| BDX-NS         | A0       | 06-56-05/10 | 0e00000c | 0e00000d | Xeon D-1513N/23/33/43/53
| APL            | D0       | 06-5c-09/03 | 00000036 | 00000038 | Pentium N/J4xxx, Celeron N/J3xxx, Atom x5/7-E39xx
| SKL-H/S        | R0/N0    | 06-5e-03/36 | 000000c6 | 000000cc | Core Gen6; Xeon E3 v5
| DNV            | B0       | 06-5f-01/01 | 00000024 | 0000002e | Atom C Series
| GLK            | B0       | 06-7a-01/01 | 0000002c | 0000002e | Pentium Silver N/J5xxx, Celeron N/J4xxx
| AML-Y22        | H0       | 06-8e-09/10 | 0000009e | 000000b4 | Core Gen8 Mobile
| KBL-U/Y        | H0       | 06-8e-09/c0 | 0000009a | 000000b4 | Core Gen7 Mobile
| CFL-U43e       | D0       | 06-8e-0a/c0 | 0000009e | 000000b4 | Core Gen8 Mobile
| WHL-U          | W0       | 06-8e-0b/d0 | 000000a4 | 000000b8 | Core Gen8 Mobile
| WHL-U          | V0       | 06-8e-0d/94 | 000000b2 | 000000b8 | Core Gen8 Mobile
| KBL-G/H/S/E3   | B0       | 06-9e-09/2a | 0000009a | 000000b4 | Core Gen7; Xeon E3 v6
| CFL-H/S/E3     | U0       | 06-9e-0a/22 | 000000aa | 000000b4 | Core Gen8 Desktop, Mobile, Xeon E
| CFL-S          | B0       | 06-9e-0b/02 | 000000aa | 000000b4 | Core Gen8
| CFL-H/S        | P0       | 06-9e-0c/22 | 000000a2 | 000000ae | Core Gen9
| CFL-H          | R0       | 06-9e-0d/22 | 000000b0 | 000000b8 | Core Gen9 Mobile

### Removed Platforms

None

## [microcode-20190312](https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/releases/tag/microcode-20190312)

### Purpose

- Security updates for [INTEL-SA-00088](https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00088.html).

### New Platforms

| Processor      | Stepping | F-M-S/PI    | Old Ver  | New Ver  | Products
|:---------------|:---------|:------------|:---------|:---------|:---------
| AML-Y22        | H0       | 06-8e-09/10 |          | 0000009e | Core Gen8 Mobile
| WHL-U          | W0       | 06-8e-0b/d0 |          | 000000a4 | Core Gen8 Mobile
| WHL-U          | V0       | 06-8e-0d/94 |          | 000000b2 | Core Gen8 Mobile
| CFL-S          | P0       | 06-9e-0c/22 |          | 000000a2 | Core Gen9 Desktop
| CFL-H          | R0       | 06-9e-0d/22 |          | 000000b0 | Core Gen9 Mobile

### Updated Platforms

| Processor      | Stepping | F-M-S/PI    | Old Ver  | New Ver  | Products
|:---------------|:---------|:------------|:---------|:---------|:---------
| HSX-E/EP       | Cx/M1    | 06-3f-02/6f | 0000003d | 00000041 | Core Gen4 X series; Xeon E5 v3
| HSX-EX         | E0       | 06-3f-04/80 | 00000012 | 00000013 | Xeon E7 v3
| SKX-SP         | H0/M0/U0 | 06-55-04/b7 | 0200004d | 0000005a | Xeon Scalable
| SKX-D          | M1       | 06-55-04/b7 | 0200004d | 0000005a | Xeon D-21xx
| BDX-DE         | V1       | 06-56-02/10 | 00000017 | 00000019 | Xeon D-1520/40
| BDX-DE         | V2/3     | 06-56-03/10 | 07000013 | 07000016 | Xeon D-1518/19/21/27/28/31/33/37/41/48, Pentium D1507/08/09/17/19
| BDX-DE         | Y0       | 06-56-04/10 | 0f000012 | 0f000014 | Xeon D-1557/59/67/71/77/81/87
| BDX-NS         | A0       | 06-56-05/10 | 0e00000a | 0e00000c | Xeon D-1513N/23/33/43/53
| APL            | D0       | 06-5c-09/03 | 00000032 | 00000036 | Pentium N/J4xxx, Celeron N/J3xxx, Atom x5/7-E39xx
| APL            | E0       | 06-5c-0a/03 | 0000000c | 00000010 | Atom x5/7-E39xx
| GLK            | B0       | 06-7a-01/01 | 00000028 | 0000002c | Pentium Silver N/J5xxx, Celeron N/J4xxx
| KBL-U/Y        | H0       | 06-8e-09/c0 | 0000008e | 0000009a | Core Gen7 Mobile
| CFL-U43e       | D0       | 06-8e-0a/c0 | 00000096 | 0000009e | Core Gen8 Mobile
| KBL-H/S/E3     | B0       | 06-9e-09/2a | 0000008e | 0000009a | Core Gen7; Xeon E3 v6
| CFL-H/S/E3     | U0       | 06-9e-0a/22 | 00000096 | 000000aa | Core Gen8 Desktop, Mobile, Xeon E
| CFL-S          | B0       | 06-9e-0b/02 | 0000008e | 000000aa | Core Gen8

### Removed Platforms

None
