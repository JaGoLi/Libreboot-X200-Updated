# RomStage <--> QcLib interface specification

## Version 1

## Description:

- RomStage <--> QcLib interface table is used to pass input information from
RomStage to QcLib and receive information returned from QcLib to RomStage.

- Interface specification defines interface Table data structures: Table
header data structure and table's entry data structure.

- RomStage populates interface table with entries for DDR (dcb) settings, DDR
training data, power management IC (pmic) settings.

- RomStage passes this table to QcLib, QcLib processes this data and performs
SOC clock, DDR, PMIC configuration.

- QcLib updates interface table entries for the blobs which need to be saved
to storage.

- QcLib also adds ddr_information "Interface Table Entry" with DDR base_address
and size of ddr and returns to RomStage.

- After returning from QcLib, RomStage processes interface table to take action
for the blobs to be saved on storage and consumes returned ddr_information.

## [Interface Table Header Info]
| Description | Size (bytes) | Value |
| ----------- | ------------ | ----- |
| magic | 8 | "QCLIB_CB" |
| version | 4 | 1 |
| num_entries | 4 | <runtime> |
| max_entries | 4 | 16 |
| global_attributes | 4 | 0x1 : Enable Uart Logging |
| reserved | 8 | 0 |
| Interface Table Entry | 0x28 | <runtime> |
| Repeat last entry n times | 0x28 | <runtime |

## [Interface Table Entry Info]
| Description | Size (bytes) | Value |
| ----------- | ------------ | ----- |
| Name | 24 | "dcb_settings" OR |
| | | "pmic_settings" OR |
| | | "ddr_training" OR |
| | | "ddr_information" |
| blob_address | 8 | address of blob in memory |
| size | 4 | size of blob in memory |
| blob_attributes | 4 | 0x1 : Save to Storage |
