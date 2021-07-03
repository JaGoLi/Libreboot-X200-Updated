/* SPDX-License-Identifier: GPL-2.0-only */

#include <device/mmio.h>
#include <soc/iocfg.h>
#include <soc/pll.h>
#include <soc/pmif_spmi.h>

/* IOCFG_BM, DRV_CFG2 */
DEFINE_BITFIELD(SPMI_SCL, 8, 6)
DEFINE_BITFIELD(SPMI_SDA, 11, 9)
DEFINE_BIT(SPMI_SCL_IN, 20)
DEFINE_BIT(SPMI_SDA_IN, 21)
DEFINE_BIT(SPMI_SCL_PU, 21)
DEFINE_BIT(SPMI_SDA_PD, 22)
DEFINE_BIT(SPMI_SCL_SMT, 25)
DEFINE_BIT(SPMI_SDA_SMT, 26)
DEFINE_BITFIELD(SPMI_TD, 11, 8)
DEFINE_BITFIELD(SPMI_RD, 23, 22)
DEFINE_BITFIELD(SPMI_DRI, 5, 0)

/* TOPRGU, WDT_SWSYSRST2 */
DEFINE_BIT(SPMI_MST_RST, 23)
DEFINE_BITFIELD(UNLOCK_KEY, 31, 24)

/* TOPCKGEN, CLK_CFG_17 */
DEFINE_BITFIELD(CLK_SPMI_MST_SEL, 10, 8)
DEFINE_BIT(CLK_SPMI_MST_INT, 12)
DEFINE_BIT(PDN_SPMI_MST, 15)

/* TOPCKGEN, CLK_CFG_UPDATE2 */
DEFINE_BIT(SPMI_MST_CK_UPDATE, 5)

int spmi_config_master(void)
{
	/* Software reset */
	SET32_BITFIELDS(&mtk_rug->wdt_swsysrst2, SPMI_MST_RST, 1, UNLOCK_KEY, 0x88);

	SET32_BITFIELDS(&mtk_topckgen->clk_cfg_17,
			CLK_SPMI_MST_SEL, 0x3,
			CLK_SPMI_MST_INT, 0,
			PDN_SPMI_MST, 0);
	SET32_BITFIELDS(&mtk_topckgen->clk_cfg_update2, SPMI_MST_CK_UPDATE, 1);

	/* Software reset */
	SET32_BITFIELDS(&mtk_rug->wdt_swsysrst2, SPMI_MST_RST, 0, UNLOCK_KEY, 0x88);

	/* Enable SPMI */
	write32(&mtk_spmi_mst->mst_req_en, 1);
	write32(&mtk_spmi_mst->rcs_ctrl, 0x15);

	return 0;
}

void pmif_spmi_iocfg(void)
{
	SET32_BITFIELDS(&mtk_iocfg_bm->eh_cfg_clr, SPMI_SCL, 0x7, SPMI_SDA, 0x7);
	SET32_BITFIELDS(&mtk_iocfg_bm->ies_cfg1_clr, SPMI_SCL_IN, 0x1);
	SET32_BITFIELDS(&mtk_iocfg_bm->ies_cfg1_set, SPMI_SDA_IN, 0x1);
	SET32_BITFIELDS(&mtk_iocfg_bm->pu_cfg1_clr, SPMI_SCL_PU, 0x1,
			SPMI_SDA_PD, 0x1);
	SET32_BITFIELDS(&mtk_iocfg_bm->pd_cfg1_clr, SPMI_SCL_PU, 0x1,
			SPMI_SDA_PD, 0x1);
	SET32_BITFIELDS(&mtk_iocfg_bm->smt_cfg0_set, SPMI_SCL_SMT, 0x1,
			SPMI_SDA_SMT, 0x1);
	SET32_BITFIELDS(&mtk_iocfg_bm->tdsel_cfg1_clr, SPMI_TD, 0xF);
	SET32_BITFIELDS(&mtk_iocfg_bm->rdsel_cfg0_clr, SPMI_RD, 0x3);
	SET32_BITFIELDS(&mtk_iocfg_bm->drv_cfg3_clr, SPMI_DRI, 0x2D);
	SET32_BITFIELDS(&mtk_iocfg_bm->drv_cfg3_set, SPMI_DRI, 0x12);
}
