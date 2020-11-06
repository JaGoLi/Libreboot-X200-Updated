/* SPDX-License-Identifier: GPL-2.0-only */

Device(AZHD) {
	Name(_ADR, 0x00140002)
	OperationRegion(AZPD, PCI_Config, 0x00, 0x100)
		Field(AZPD, AnyAcc, NoLock, Preserve) {
		offset (0x42),
		NSDI, 1,
		NSDO, 1,
		NSEN, 1,
		offset (0x44),
		IPCR, 4,
		offset (0x54),
		PWST, 2,
		, 6,
		PMEB, 1,
		, 6,
		PMST, 1,
		offset (0x62),
		MMCR, 1,
		offset (0x64),
		MMLA, 32,
		offset (0x68),
		MMHA, 32,
		offset (0x6C),
		MMDT, 16,
	}
} /* end AZHD */
