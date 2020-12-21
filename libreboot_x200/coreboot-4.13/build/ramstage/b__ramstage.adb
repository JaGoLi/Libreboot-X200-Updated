pragma Warnings (Off);
pragma Ada_95;
pragma Source_File_Name (ramstage_adamain, Spec_File_Name => "b__ramstage.ads");
pragma Source_File_Name (ramstage_adamain, Body_File_Name => "b__ramstage.adb");
pragma Suppress (Overflow_Check);

package body ramstage_adamain is

   E087 : Short_Integer; pragma Import (Ada, E087, "hw__debug_sink_E");
   E078 : Short_Integer; pragma Import (Ada, E078, "hw__port_io_E");
   E081 : Short_Integer; pragma Import (Ada, E081, "hw__time_E");
   E094 : Short_Integer; pragma Import (Ada, E094, "hw__time__timer_E");
   E084 : Short_Integer; pragma Import (Ada, E084, "hw__debug_E");
   E021 : Short_Integer; pragma Import (Ada, E021, "hw__gfx__dp_aux_ch_E");
   E024 : Short_Integer; pragma Import (Ada, E024, "hw__gfx__dp_info_E");
   E026 : Short_Integer; pragma Import (Ada, E026, "hw__gfx__dp_training_E");
   E028 : Short_Integer; pragma Import (Ada, E028, "hw__gfx__edid_E");
   E069 : Short_Integer; pragma Import (Ada, E069, "hw__mmio_range_E");
   E030 : Short_Integer; pragma Import (Ada, E030, "hw__gfx__framebuffer_filler_E");
   E073 : Short_Integer; pragma Import (Ada, E073, "hw__mmio_regs_E");
   E075 : Short_Integer; pragma Import (Ada, E075, "hw__pci__mmconf_E");
   E071 : Short_Integer; pragma Import (Ada, E071, "hw__pci__dev_E");
   E065 : Short_Integer; pragma Import (Ada, E065, "hw__gfx__gma_E");
   E061 : Short_Integer; pragma Import (Ada, E061, "hw__gfx__gma__registers_E");
   E057 : Short_Integer; pragma Import (Ada, E057, "hw__gfx__gma__pcode_E");
   E046 : Short_Integer; pragma Import (Ada, E046, "hw__gfx__gma__panel_E");
   E034 : Short_Integer; pragma Import (Ada, E034, "hw__gfx__gma__connector_info_E");
   E032 : Short_Integer; pragma Import (Ada, E032, "hw__gfx__gma__config_helpers_E");
   E019 : Short_Integer; pragma Import (Ada, E019, "hw__gfx__gma__power_and_clocks_E");
   E040 : Short_Integer; pragma Import (Ada, E040, "hw__gfx__gma__dp_aux_request_E");
   E004 : Short_Integer; pragma Import (Ada, E004, "hw__gfx__gma__connectors_E");
   E017 : Short_Integer; pragma Import (Ada, E017, "hw__gfx__gma__port_detect_E");
   E015 : Short_Integer; pragma Import (Ada, E015, "hw__gfx__gma__plls_E");
   E063 : Short_Integer; pragma Import (Ada, E063, "hw__gfx__gma__transcoder_E");
   E059 : Short_Integer; pragma Import (Ada, E059, "hw__gfx__gma__pipe_setup_E");
   E006 : Short_Integer; pragma Import (Ada, E006, "hw__gfx__gma__gmch__dp_E");
   E012 : Short_Integer; pragma Import (Ada, E012, "hw__gfx__gma__gmch__vga_E");
   E010 : Short_Integer; pragma Import (Ada, E010, "hw__gfx__gma__gmch__lvds_E");
   E008 : Short_Integer; pragma Import (Ada, E008, "hw__gfx__gma__gmch__hdmi_E");
   E044 : Short_Integer; pragma Import (Ada, E044, "hw__gfx__gma__i2c_E");
   E036 : Short_Integer; pragma Import (Ada, E036, "hw__gfx__gma__display_probing_E");
   E089 : Short_Integer; pragma Import (Ada, E089, "gma_E");
   E091 : Short_Integer; pragma Import (Ada, E091, "gma__gfx_init_E");
   E048 : Short_Integer; pragma Import (Ada, E048, "hw__gfx__gma__pch__fdi_E");
   E050 : Short_Integer; pragma Import (Ada, E050, "hw__gfx__gma__pch__sideband_E");
   E052 : Short_Integer; pragma Import (Ada, E052, "hw__gfx__gma__pch__transcoder_E");
   E054 : Short_Integer; pragma Import (Ada, E054, "hw__gfx__gma__pch__vga_E");


   procedure ramstage_adainit is
   begin
      null;

      E087 := E087 + 1;
      E078 := E078 + 1;
      E094 := E094 + 1;
      E081 := E081 + 1;
      E084 := E084 + 1;
      E021 := E021 + 1;
      E024 := E024 + 1;
      E026 := E026 + 1;
      E028 := E028 + 1;
      E069 := E069 + 1;
      E030 := E030 + 1;
      E073 := E073 + 1;
      E075 := E075 + 1;
      E071 := E071 + 1;
      E061 := E061 + 1;
      E057 := E057 + 1;
      E046 := E046 + 1;
      E019 := E019 + 1;
      E063 := E063 + 1;
      E034 := E034 + 1;
      E032 := E032 + 1;
      E040 := E040 + 1;
      E017 := E017 + 1;
      E015 := E015 + 1;
      if E065 = 0 then
         HW.GFX.GMA'ELAB_BODY;
      end if;
      E065 := E065 + 1;
      E059 := E059 + 1;
      E006 := E006 + 1;
      E004 := E004 + 1;
      E012 := E012 + 1;
      E010 := E010 + 1;
      E008 := E008 + 1;
      E044 := E044 + 1;
      E036 := E036 + 1;
      E089 := E089 + 1;
      E091 := E091 + 1;
      E048 := E048 + 1;
      E050 := E050 + 1;
      E052 := E052 + 1;
      E054 := E054 + 1;
   end ramstage_adainit;

--  BEGIN Object file/option list
   --   lib/cb.o
   --   ./cb-config.o
   --   libhwbase/common/hw.o
   --   libhwbase/common/hw-config.o
   --   console/hw-debug_sink.o
   --   libgfxinit/common/hw-gfx.o
   --   libgfxinit/common/hw-gfx-dp_defs.o
   --   libgfxinit/common/hw-gfx-i2c.o
   --   libhwbase/common/hw-pci.o
   --   libhwbase/common/hw-port_io.o
   --   libhwbase/common/hw-sub_regs.o
   --   lib/hw-time-timer.o
   --   libhwbase/common/hw-time.o
   --   libhwbase/debug/hw-debug.o
   --   libgfxinit/common/hw-gfx-dp_aux_ch.o
   --   libgfxinit/common/hw-gfx-dp_info.o
   --   libgfxinit/common/hw-gfx-dp_training.o
   --   libgfxinit/common/hw-gfx-edid.o
   --   libhwbase/ada/dynamic_mmio/hw-mmio_range.o
   --   libgfxinit/common/hw-gfx-framebuffer_filler.o
   --   libhwbase/common/hw-mmio_regs.o
   --   libhwbase/common/hw-pci-mmconf.o
   --   libhwbase/common/direct/hw-pci-dev.o
   --   libgfxinit/common/hw-gfx-gma-registers.o
   --   libgfxinit/common/hw-gfx-gma-pcode.o
   --   libgfxinit/common/hw-gfx-gma-panel.o
   --   libgfxinit/common/hw-gfx-gma-dp_aux_ch.o
   --   libgfxinit/common/hw-gfx-gma-dp_info.o
   --   libgfxinit/common/g45/hw-gfx-gma-power_and_clocks.o
   --   libgfxinit/common/g45/hw-gfx-gma-gmch.o
   --   libgfxinit/common/dyncpu/hw-gfx-gma-config.o
   --   libgfxinit/common/hw-gfx-gma-transcoder.o
   --   libgfxinit/common/hw-gfx-gma-connector_info.o
   --   libgfxinit/common/hw-gfx-gma-config_helpers.o
   --   libgfxinit/common/hw-gfx-gma-dp_aux_request.o
   --   libgfxinit/common/g45/hw-gfx-gma-port_detect.o
   --   libgfxinit/common/g45/hw-gfx-gma-plls.o
   --   libgfxinit/common/hw-gfx-gma.o
   --   libgfxinit/common/hw-gfx-gma-pipe_setup.o
   --   libgfxinit/common/g45/hw-gfx-gma-gmch-dp.o
   --   libgfxinit/common/g45/hw-gfx-gma-connectors.o
   --   libgfxinit/common/g45/hw-gfx-gma-gmch-vga.o
   --   libgfxinit/common/g45/hw-gfx-gma-gmch-lvds.o
   --   libgfxinit/common/g45/hw-gfx-gma-gmch-hdmi.o
   --   libgfxinit/common/hw-gfx-gma-i2c.o
   --   libgfxinit/common/hw-gfx-gma-display_probing.o
   --   drivers/intel/gma/gma.o
   --   mainboard/lenovo/x200/gma-mainboard.o
   --   drivers/intel/gma/hires_fb/gma-gfx_init.o
   --   libgfxinit/common/hw-gfx-gma-pch.o
   --   libgfxinit/common/hw-gfx-gma-pch-fdi.o
   --   libgfxinit/common/hw-gfx-gma-pch-sideband.o
   --   libgfxinit/common/hw-gfx-gma-pch-transcoder.o
   --   libgfxinit/common/hw-gfx-gma-pch-vga.o
   --   -L./
   --   -L/home/jason/libreboot-repo/libreboot_x200/coreboot-4.13/build/libgnat-x86_32/adalib/
   --   -static
   --   -lgnat
--  END Object file/option list   

end ramstage_adamain;
