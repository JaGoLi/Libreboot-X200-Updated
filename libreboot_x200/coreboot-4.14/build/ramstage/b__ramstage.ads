pragma Warnings (Off);
pragma Ada_95;
pragma Restrictions (No_Exception_Handlers);
with System;
package ramstage_adamain is

   procedure ramstage_adainit;
   pragma Export (C, ramstage_adainit, "ramstage_adainit");
   pragma Linker_Constructor (ramstage_adainit);

   type Version_32 is mod 2 ** 32;
   u00001 : constant Version_32 := 16#962dade3#;
   pragma Export (C, u00001, "hw__gfx__gma__configB");
   u00002 : constant Version_32 := 16#8e58b9eb#;
   pragma Export (C, u00002, "hw__gfx__gma__configS");
   u00003 : constant Version_32 := 16#0bd5874c#;
   pragma Export (C, u00003, "hw__gfx__gma__connectorsB");
   u00004 : constant Version_32 := 16#ec83b2a0#;
   pragma Export (C, u00004, "hw__gfx__gma__connectorsS");
   u00005 : constant Version_32 := 16#a51db0e0#;
   pragma Export (C, u00005, "hw__gfx__gma__gmch__dpB");
   u00006 : constant Version_32 := 16#6fb9814e#;
   pragma Export (C, u00006, "hw__gfx__gma__gmch__dpS");
   u00007 : constant Version_32 := 16#e3cec8c2#;
   pragma Export (C, u00007, "hw__gfx__gma__gmch__hdmiB");
   u00008 : constant Version_32 := 16#d211b20f#;
   pragma Export (C, u00008, "hw__gfx__gma__gmch__hdmiS");
   u00009 : constant Version_32 := 16#3cf0154b#;
   pragma Export (C, u00009, "hw__gfx__gma__gmch__lvdsB");
   u00010 : constant Version_32 := 16#818fc528#;
   pragma Export (C, u00010, "hw__gfx__gma__gmch__lvdsS");
   u00011 : constant Version_32 := 16#9564f965#;
   pragma Export (C, u00011, "hw__gfx__gma__gmch__vgaB");
   u00012 : constant Version_32 := 16#1310e6e4#;
   pragma Export (C, u00012, "hw__gfx__gma__gmch__vgaS");
   u00013 : constant Version_32 := 16#d3c0fe8c#;
   pragma Export (C, u00013, "hw__gfx__gma__gmchS");
   u00014 : constant Version_32 := 16#ed6cef56#;
   pragma Export (C, u00014, "hw__gfx__gma__pllsB");
   u00015 : constant Version_32 := 16#07c6a0b0#;
   pragma Export (C, u00015, "hw__gfx__gma__pllsS");
   u00016 : constant Version_32 := 16#9b65550c#;
   pragma Export (C, u00016, "hw__gfx__gma__port_detectB");
   u00017 : constant Version_32 := 16#41c04848#;
   pragma Export (C, u00017, "hw__gfx__gma__port_detectS");
   u00018 : constant Version_32 := 16#437d49de#;
   pragma Export (C, u00018, "hw__gfx__gma__power_and_clocksB");
   u00019 : constant Version_32 := 16#e1f8fbf5#;
   pragma Export (C, u00019, "hw__gfx__gma__power_and_clocksS");
   u00020 : constant Version_32 := 16#914cdcce#;
   pragma Export (C, u00020, "hw__gfx__dp_aux_chB");
   u00021 : constant Version_32 := 16#ef5af001#;
   pragma Export (C, u00021, "hw__gfx__dp_aux_chS");
   u00022 : constant Version_32 := 16#e2948386#;
   pragma Export (C, u00022, "hw__gfx__dp_defsS");
   u00023 : constant Version_32 := 16#a7984cb7#;
   pragma Export (C, u00023, "hw__gfx__dp_infoB");
   u00024 : constant Version_32 := 16#7ebe2cde#;
   pragma Export (C, u00024, "hw__gfx__dp_infoS");
   u00025 : constant Version_32 := 16#85aed5af#;
   pragma Export (C, u00025, "hw__gfx__dp_trainingB");
   u00026 : constant Version_32 := 16#be38ed00#;
   pragma Export (C, u00026, "hw__gfx__dp_trainingS");
   u00027 : constant Version_32 := 16#cd05dfd3#;
   pragma Export (C, u00027, "hw__gfx__edidB");
   u00028 : constant Version_32 := 16#4bdfd417#;
   pragma Export (C, u00028, "hw__gfx__edidS");
   u00029 : constant Version_32 := 16#e8d38bf2#;
   pragma Export (C, u00029, "hw__gfx__framebuffer_fillerB");
   u00030 : constant Version_32 := 16#cc363673#;
   pragma Export (C, u00030, "hw__gfx__framebuffer_fillerS");
   u00031 : constant Version_32 := 16#fcad0896#;
   pragma Export (C, u00031, "hw__gfx__gma__config_helpersB");
   u00032 : constant Version_32 := 16#60f252af#;
   pragma Export (C, u00032, "hw__gfx__gma__config_helpersS");
   u00033 : constant Version_32 := 16#dc913eba#;
   pragma Export (C, u00033, "hw__gfx__gma__connector_infoB");
   u00034 : constant Version_32 := 16#0c4e0f94#;
   pragma Export (C, u00034, "hw__gfx__gma__connector_infoS");
   u00035 : constant Version_32 := 16#540dbb89#;
   pragma Export (C, u00035, "hw__gfx__gma__display_probingB");
   u00036 : constant Version_32 := 16#29f308f2#;
   pragma Export (C, u00036, "hw__gfx__gma__display_probingS");
   u00037 : constant Version_32 := 16#53944791#;
   pragma Export (C, u00037, "hw__gfx__gma__dp_aux_chB");
   u00038 : constant Version_32 := 16#4d4022ea#;
   pragma Export (C, u00038, "hw__gfx__gma__dp_aux_chS");
   u00039 : constant Version_32 := 16#5014510f#;
   pragma Export (C, u00039, "hw__gfx__gma__dp_aux_requestB");
   u00040 : constant Version_32 := 16#c6a79bd6#;
   pragma Export (C, u00040, "hw__gfx__gma__dp_aux_requestS");
   u00041 : constant Version_32 := 16#38def494#;
   pragma Export (C, u00041, "hw__gfx__gma__dp_infoB");
   u00042 : constant Version_32 := 16#0f30aae5#;
   pragma Export (C, u00042, "hw__gfx__gma__dp_infoS");
   u00043 : constant Version_32 := 16#dca2c91d#;
   pragma Export (C, u00043, "hw__gfx__gma__i2cB");
   u00044 : constant Version_32 := 16#19545f9a#;
   pragma Export (C, u00044, "hw__gfx__gma__i2cS");
   u00045 : constant Version_32 := 16#25a50bd1#;
   pragma Export (C, u00045, "hw__gfx__gma__panelB");
   u00046 : constant Version_32 := 16#37bc82a5#;
   pragma Export (C, u00046, "hw__gfx__gma__panelS");
   u00047 : constant Version_32 := 16#b67ce508#;
   pragma Export (C, u00047, "hw__gfx__gma__pch__fdiB");
   u00048 : constant Version_32 := 16#9accaa52#;
   pragma Export (C, u00048, "hw__gfx__gma__pch__fdiS");
   u00049 : constant Version_32 := 16#77a25d05#;
   pragma Export (C, u00049, "hw__gfx__gma__pch__sidebandB");
   u00050 : constant Version_32 := 16#d9724cc9#;
   pragma Export (C, u00050, "hw__gfx__gma__pch__sidebandS");
   u00051 : constant Version_32 := 16#3226b01c#;
   pragma Export (C, u00051, "hw__gfx__gma__pch__transcoderB");
   u00052 : constant Version_32 := 16#c8134541#;
   pragma Export (C, u00052, "hw__gfx__gma__pch__transcoderS");
   u00053 : constant Version_32 := 16#a8619164#;
   pragma Export (C, u00053, "hw__gfx__gma__pch__vgaB");
   u00054 : constant Version_32 := 16#65e1fddd#;
   pragma Export (C, u00054, "hw__gfx__gma__pch__vgaS");
   u00055 : constant Version_32 := 16#6884a6e4#;
   pragma Export (C, u00055, "hw__gfx__gma__pchS");
   u00056 : constant Version_32 := 16#e5bdebbd#;
   pragma Export (C, u00056, "hw__gfx__gma__pcodeB");
   u00057 : constant Version_32 := 16#55f241f8#;
   pragma Export (C, u00057, "hw__gfx__gma__pcodeS");
   u00058 : constant Version_32 := 16#1edcbab0#;
   pragma Export (C, u00058, "hw__gfx__gma__pipe_setupB");
   u00059 : constant Version_32 := 16#726a4531#;
   pragma Export (C, u00059, "hw__gfx__gma__pipe_setupS");
   u00060 : constant Version_32 := 16#c7417e68#;
   pragma Export (C, u00060, "hw__gfx__gma__registersB");
   u00061 : constant Version_32 := 16#fef2ec08#;
   pragma Export (C, u00061, "hw__gfx__gma__registersS");
   u00062 : constant Version_32 := 16#e653d8a2#;
   pragma Export (C, u00062, "hw__gfx__gma__transcoderB");
   u00063 : constant Version_32 := 16#1f0d94c0#;
   pragma Export (C, u00063, "hw__gfx__gma__transcoderS");
   u00064 : constant Version_32 := 16#490e4f89#;
   pragma Export (C, u00064, "hw__gfx__gmaB");
   u00065 : constant Version_32 := 16#ccaf5330#;
   pragma Export (C, u00065, "hw__gfx__gmaS");
   u00066 : constant Version_32 := 16#37290eac#;
   pragma Export (C, u00066, "hw__gfx__i2cS");
   u00067 : constant Version_32 := 16#d263ba5b#;
   pragma Export (C, u00067, "hw__gfxS");
   u00068 : constant Version_32 := 16#43f6a17e#;
   pragma Export (C, u00068, "hw__mmio_rangeB");
   u00069 : constant Version_32 := 16#ce9421df#;
   pragma Export (C, u00069, "hw__mmio_rangeS");
   u00070 : constant Version_32 := 16#ce716a67#;
   pragma Export (C, u00070, "hw__pci__devB");
   u00071 : constant Version_32 := 16#19713f06#;
   pragma Export (C, u00071, "hw__pci__devS");
   u00072 : constant Version_32 := 16#ff7aacc6#;
   pragma Export (C, u00072, "hw__mmio_regsB");
   u00073 : constant Version_32 := 16#f8568111#;
   pragma Export (C, u00073, "hw__mmio_regsS");
   u00074 : constant Version_32 := 16#d9a1d01d#;
   pragma Export (C, u00074, "hw__pci__mmconfB");
   u00075 : constant Version_32 := 16#1638822d#;
   pragma Export (C, u00075, "hw__pci__mmconfS");
   u00076 : constant Version_32 := 16#e63e29d4#;
   pragma Export (C, u00076, "hw__pciS");
   u00077 : constant Version_32 := 16#edda6f07#;
   pragma Export (C, u00077, "hw__port_ioB");
   u00078 : constant Version_32 := 16#7678d008#;
   pragma Export (C, u00078, "hw__port_ioS");
   u00079 : constant Version_32 := 16#ab5919c7#;
   pragma Export (C, u00079, "hw__sub_regsS");
   u00080 : constant Version_32 := 16#2ce84eaa#;
   pragma Export (C, u00080, "hw__timeB");
   u00081 : constant Version_32 := 16#ac96429c#;
   pragma Export (C, u00081, "hw__timeS");
   u00082 : constant Version_32 := 16#bd96d023#;
   pragma Export (C, u00082, "hwS");
   u00083 : constant Version_32 := 16#ef0875fc#;
   pragma Export (C, u00083, "hw__debugB");
   u00084 : constant Version_32 := 16#27b64be9#;
   pragma Export (C, u00084, "hw__debugS");
   u00085 : constant Version_32 := 16#09662dc7#;
   pragma Export (C, u00085, "hw__configS");
   u00086 : constant Version_32 := 16#b0797d3f#;
   pragma Export (C, u00086, "hw__debug_sinkB");
   u00087 : constant Version_32 := 16#1b7207ae#;
   pragma Export (C, u00087, "hw__debug_sinkS");
   u00088 : constant Version_32 := 16#bc33d79b#;
   pragma Export (C, u00088, "gmaB");
   u00089 : constant Version_32 := 16#f765cb3d#;
   pragma Export (C, u00089, "gmaS");
   u00090 : constant Version_32 := 16#88466b59#;
   pragma Export (C, u00090, "gma__gfx_initB");
   u00091 : constant Version_32 := 16#cd05678f#;
   pragma Export (C, u00091, "gma__gfx_initS");
   u00092 : constant Version_32 := 16#e6df39c3#;
   pragma Export (C, u00092, "cbS");
   u00093 : constant Version_32 := 16#6fbaf8d3#;
   pragma Export (C, u00093, "hw__time__timerB");
   u00094 : constant Version_32 := 16#3e460172#;
   pragma Export (C, u00094, "hw__time__timerS");
   u00095 : constant Version_32 := 16#d08e6f34#;
   pragma Export (C, u00095, "gma__mainboardS");
   u00096 : constant Version_32 := 16#7cfc82db#;
   pragma Export (C, u00096, "cb__configS");

   --  BEGIN ELABORATION ORDER
   --  ada%s
   --  gnat%s
   --  gnat.source_info%s
   --  interfaces%s
   --  system%s
   --  system.machine_code%s
   --  system.parameters%s
   --  interfaces.c%s
   --  interfaces.c%b
   --  system.storage_elements%s
   --  system.storage_elements%b
   --  system.unsigned_types%s
   --  cb%s
   --  cb.config%s
   --  hw%s
   --  hw.config%s
   --  hw.debug_sink%s
   --  hw.debug_sink%b
   --  hw.gfx%s
   --  hw.gfx.dp_defs%s
   --  hw.gfx.i2c%s
   --  hw.pci%s
   --  hw.port_io%s
   --  hw.port_io%b
   --  hw.sub_regs%s
   --  hw.time%s
   --  hw.time.timer%s
   --  hw.time.timer%b
   --  hw.time%b
   --  hw.debug%s
   --  hw.debug%b
   --  hw.gfx.dp_aux_ch%s
   --  hw.gfx.dp_aux_ch%b
   --  hw.gfx.dp_info%s
   --  hw.gfx.dp_info%b
   --  hw.gfx.dp_training%s
   --  hw.gfx.dp_training%b
   --  hw.gfx.edid%s
   --  hw.gfx.edid%b
   --  hw.mmio_range%s
   --  hw.mmio_range%b
   --  hw.gfx.framebuffer_filler%s
   --  hw.gfx.framebuffer_filler%b
   --  hw.mmio_regs%s
   --  hw.mmio_regs%b
   --  hw.pci.mmconf%s
   --  hw.pci.mmconf%b
   --  hw.pci.dev%s
   --  hw.pci.dev%b
   --  hw.gfx.gma%s
   --  hw.gfx.gma.config%s
   --  hw.gfx.gma.registers%s
   --  hw.gfx.gma.registers%b
   --  hw.gfx.gma.pcode%s
   --  hw.gfx.gma.pcode%b
   --  hw.gfx.gma.panel%s
   --  hw.gfx.gma.panel%b
   --  hw.gfx.gma.connector_info%s
   --  hw.gfx.gma.config_helpers%s
   --  hw.gfx.gma.power_and_clocks%s
   --  hw.gfx.gma.dp_aux_request%s
   --  hw.gfx.gma.dp_aux_ch%s
   --  hw.gfx.gma.dp_aux_ch%b
   --  hw.gfx.gma.dp_info%s
   --  hw.gfx.gma.dp_info%b
   --  hw.gfx.gma.connectors%s
   --  hw.gfx.gma.power_and_clocks%b
   --  hw.gfx.gma.port_detect%s
   --  hw.gfx.gma.plls%s
   --  hw.gfx.gma.gmch%s
   --  hw.gfx.gma.config%b
   --  hw.gfx.gma.transcoder%s
   --  hw.gfx.gma.transcoder%b
   --  hw.gfx.gma.pipe_setup%s
   --  hw.gfx.gma.connector_info%b
   --  hw.gfx.gma.config_helpers%b
   --  hw.gfx.gma.dp_aux_request%b
   --  hw.gfx.gma.gmch.dp%s
   --  hw.gfx.gma.port_detect%b
   --  hw.gfx.gma.plls%b
   --  hw.gfx.gma.gmch.vga%s
   --  hw.gfx.gma.gmch.lvds%s
   --  hw.gfx.gma.gmch.hdmi%s
   --  hw.gfx.gma%b
   --  hw.gfx.gma.pipe_setup%b
   --  hw.gfx.gma.gmch.dp%b
   --  hw.gfx.gma.connectors%b
   --  hw.gfx.gma.gmch.vga%b
   --  hw.gfx.gma.gmch.lvds%b
   --  hw.gfx.gma.gmch.hdmi%b
   --  hw.gfx.gma.i2c%s
   --  hw.gfx.gma.i2c%b
   --  hw.gfx.gma.display_probing%s
   --  hw.gfx.gma.display_probing%b
   --  gma%s
   --  gma%b
   --  gma.mainboard%s
   --  gma.gfx_init%s
   --  gma.gfx_init%b
   --  hw.gfx.gma.pch%s
   --  hw.gfx.gma.pch.fdi%s
   --  hw.gfx.gma.pch.fdi%b
   --  hw.gfx.gma.pch.sideband%s
   --  hw.gfx.gma.pch.sideband%b
   --  hw.gfx.gma.pch.transcoder%s
   --  hw.gfx.gma.pch.transcoder%b
   --  hw.gfx.gma.pch.vga%s
   --  hw.gfx.gma.pch.vga%b
   --  END ELABORATION ORDER

end ramstage_adamain;
