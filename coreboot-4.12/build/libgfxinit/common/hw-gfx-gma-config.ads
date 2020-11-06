--
-- Copyright (C) 2015-2019 secunet Security Networks AG
--
-- This program is free software; you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation; either version 2 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--

pragma Restrictions (No_Elaboration_Code);

private package HW.GFX.GMA.Config is

   Gen : constant Generation := G45;

   CPU_First : constant CPU_Type :=
     (case Gen is
         when G45       => G45,
         when Ironlake  => Ironlake,
         when Haswell   => Haswell,
         when Broxton   => Broxton,
         when Skylake   => Skylake);
   CPU_Last : constant CPU_Type :=
     (case Gen is
         when G45       => GM45,
         when Ironlake  => Ivybridge,
         when Haswell   => Broadwell,
         when Broxton   => Broxton,
         when Skylake   => Kabylake);
   CPU_Var_Last : constant CPU_Variant :=
     (case Gen is
         when Haswell | Skylake  => ULX,
         when others             => Normal);
   subtype Gen_CPU_Type is CPU_Type range CPU_First .. CPU_Last;
   subtype Gen_CPU_Variant is CPU_Variant range Normal .. CPU_Var_Last;



   Panel_Ports : constant array (Valid_Panels) of Port_Type :=
     (Panel_1 => LVDS,
      Panel_2 => Disabled);

   Analog_I2C_Port : constant PCH_Port := PCH_DAC;

   EDP_Low_Voltage_Swing : constant Boolean := False;

   DDI_HDMI_Buffer_Translation : constant Integer := -1;

   Default_MMIO_Base : constant := 0 ;

   LVDS_Dual_Threshold : constant := 95_000_000;

   ----------------------------------------------------------------------------

   -- On older generations dot clocks are limited to 90% of
   -- the CDClk rate. To ease proofs, we limit CDClk's range.
   CDClk_Min : constant Frequency_Type :=
     (case Gen is
         when G45 .. Ironlake => Frequency_Type'First * 100 / 90 + 1,
         when others          => Frequency_Type'First);
   subtype CDClk_Range is Frequency_Type range CDClk_Min .. Frequency_Type'Last;

   ----------------------------------------------------------------------------

   type Valid_Port_Array is array (Port_Type) of Boolean;
   type Variable_Config is record
      Valid_Port     : Valid_Port_Array;
      CDClk          : CDClk_Range;
      Max_CDClk      : CDClk_Range;
      Raw_Clock      : Frequency_Type;
      Dyn_CPU        : Gen_CPU_Type;
      Dyn_CPU_Var    : Gen_CPU_Variant;
   end record;

   Initial_Settings : constant Variable_Config :=
     (Valid_Port     => (others => False),
      CDClk          => CDClk_Range'First,
      Max_CDClk      => CDClk_Range'First,
      Raw_Clock      => Frequency_Type'First,
      Dyn_CPU        => Gen_CPU_Type'First,
      Dyn_CPU_Var    => Gen_CPU_Variant'First);

   Variable : Variable_Config with Part_Of => GMA.State;

   Valid_Port  : Valid_Port_Array renames Variable.Valid_Port;
   CDClk       : CDClk_Range renames Variable.CDClk;
   Max_CDClk   : CDClk_Range renames Variable.Max_CDClk;
   Raw_Clock   : Frequency_Type renames Variable.Raw_Clock;
   CPU         : Gen_CPU_Type renames Variable.Dyn_CPU;
   CPU_Var     : Gen_CPU_Variant renames Variable.Dyn_CPU_Var;

   ----------------------------------------------------------------------------

   -- To support both static configurations, that are compiled for a
   -- fixed CPU, and dynamic configurations, where the CPU and its
   -- variant are detected at runtime, all derived config values are
   -- tagged based on their dependencies.
   --
   -- Booleans that only depend on the generation should be tagged
   -- constant Boolean. Those that may depend on the CPU are tagged with the
   -- generations where that is the case. For instance `CPU_Ivybridge`
   -- can be decided purely based on the generation unless the gene-
   -- ration is Ironlake, thus, it is tagged <cpufunc>  Boolean.
   --
   -- For non-boolean constants, per generation tags <...var> are
   -- used (e.g. <cpufunc> ).
   --
   -- To ease parsing, all multiline expressions of tagged config
   -- values start after a line break.

   Gen_G45           : constant Boolean := Gen = G45;
   Gen_Ironlake      : constant Boolean := Gen = Ironlake;
   Gen_Haswell       : constant Boolean := Gen = Haswell;
   Gen_Broxton       : constant Boolean := Gen = Broxton;
   Gen_Skylake       : constant Boolean := Gen = Skylake;

   Up_To_Ironlake    : constant Boolean := Gen <= Ironlake;
   Ironlake_On       : constant Boolean := Gen >= Ironlake;
   Haswell_On        : constant Boolean := Gen >= Haswell;
   Broxton_On        : constant Boolean := Gen >= Broxton;
   Skylake_On        : constant Boolean := Gen >= Skylake;

   function GMCH_GM45 return Boolean is
     (Gen_G45 and then CPU = GM45);
   function CPU_Ironlake return Boolean is
     (Gen_Ironlake and then CPU = Ironlake);
   function CPU_Sandybridge return Boolean is
     (Gen_Ironlake and then CPU = Sandybridge);
   function CPU_Ivybridge return Boolean is
     (Gen_Ironlake and then CPU = Ivybridge);
   function CPU_Haswell return Boolean is
     (Gen_Haswell and then CPU = Haswell);
   function CPU_Broadwell return Boolean is
     (Gen_Haswell and then CPU = Broadwell);
   function CPU_Skylake return Boolean is
     (Gen_Skylake and then CPU = Skylake);
   function CPU_Kabylake return Boolean is
     (Gen_Skylake and then CPU = Kabylake);

   function Sandybridge_On return Boolean is
     ((Gen_Ironlake and then CPU >= Sandybridge) or Haswell_On);
   function Ivybridge_On return Boolean is
     ((Gen_Ironlake and then CPU >= Ivybridge) or Haswell_On);
   function Broadwell_On return Boolean is
     ((Gen_Haswell and then CPU >= Broadwell) or Broxton_On);

   ----------------------------------------------------------------------------

   Have_HDMI_Buf_Override  : constant Boolean := DDI_HDMI_Buffer_Translation >= 0;
   Default_MMIO_Base_Set   : constant Boolean := Default_MMIO_Base /= 0;

   Have_DVI_I              : constant Boolean := Analog_I2C_Port /= PCH_DAC;

   Has_Presence_Straps           : constant Boolean := not Gen_Broxton;
   function Is_ULT return Boolean is
     ((Gen_Haswell or Gen_Skylake) and then CPU_Var = ULT);
   function Is_ULX return Boolean is
     ((Gen_Haswell or Gen_Skylake) and then CPU_Var = ULX);
   function Is_LP return Boolean is
     (Is_ULT or Is_ULX);

   ---------- CPU pipe: ---------
   function Has_Tertiary_Pipe return Boolean is
     (Ivybridge_On);
   Disable_Trickle_Feed          : constant Boolean := not Gen_Haswell;
   function Pipe_Enabled_Workaround return Boolean is
     (CPU_Broadwell);
   Has_EDP_Transcoder            : constant Boolean := Haswell_On;
   function Use_PDW_For_EDP_Scaling return Boolean is
     (CPU_Haswell);
   Has_Pipe_DDI_Func             : constant Boolean := Haswell_On;
   Has_Trans_Clk_Sel             : constant Boolean := Haswell_On;
   Has_Pipe_MSA_Misc             : constant Boolean := Haswell_On;
   function Has_Pipeconf_Misc return Boolean is
     (Broadwell_On);
   function Has_Pipeconf_BPC return Boolean is
     (not CPU_Haswell);
   Has_Plane_Control             : constant Boolean := Broxton_On;
   Has_DSP_Linoff                : constant Boolean := Up_To_Ironlake;
   function Has_PF_Pipe_Select return Boolean is
     (CPU_Ivybridge or CPU_Haswell);
   function Has_Ivybridge_Cursors return Boolean is
     (Ivybridge_On);
   function VGA_Plane_Workaround return Boolean is
     (CPU_Ivybridge);
   Has_GMCH_DP_Transcoder        : constant Boolean := Gen_G45;
   Has_GMCH_VGACNTRL             : constant Boolean := Gen_G45;
   Has_GMCH_PFIT_CONTROL         : constant Boolean := Gen_G45;

   --------- Panel power: -------
   Has_PP_Write_Protection       : constant Boolean := Up_To_Ironlake;
   Has_PP_Port_Select            : constant Boolean := Up_To_Ironlake;
   Use_PP_VDD_Override           : constant Boolean := Up_To_Ironlake;
   Has_PCH_Panel_Power           : constant Boolean := Ironlake_On;
   Has_PP_Divisor_Reg            : constant Boolean := not Gen_Broxton;
   Has_New_Backlight_Control     : constant Boolean := Gen_Broxton;

   ----------- PCH/FDI: ---------
   Has_PCH                       : constant Boolean := not Gen_Broxton and not Gen_G45;
   function Has_PCH_DAC return Boolean is
     (Gen_Ironlake or (Gen_Haswell and then not Is_LP));

   Has_PCH_Aux_Channels          : constant Boolean := Gen_Ironlake or Gen_Haswell;

   VGA_Has_Sync_Disable          : constant Boolean := Up_To_Ironlake;

   function Has_Trans_Timing_Ovrrde return Boolean is
     (Sandybridge_On);

   Has_DPLL_SEL                  : constant Boolean := Gen_Ironlake;
   Has_FDI_BPC                   : constant Boolean := Gen_Ironlake;
   function Has_FDI_Composite_Sel return Boolean is
     (CPU_Ivybridge);
   function Has_New_FDI_Sink return Boolean is
     (Sandybridge_On);
   function Has_New_FDI_Source return Boolean is
     (Ivybridge_On);
   function Has_Trans_DP_Ctl return Boolean is
     (CPU_Sandybridge or CPU_Ivybridge);
   function Has_FDI_C return Boolean is
     (CPU_Ivybridge);

   Has_FDI_RX_Power_Down         : constant Boolean := Gen_Haswell;

   ---------- Clocks: -----------
   Has_GMCH_RawClk               : constant Boolean := Gen_G45;
   function Has_GMCH_Mobile_VCO return Boolean is
     (GMCH_GM45);
   function Has_Broadwell_CDClk return Boolean is
     (CPU_Broadwell);
   function Can_Switch_CDClk return Boolean is
     (Broadwell_On);

   ----------- DDI: -------------
   End_EDP_Training_Late         : constant Boolean := Gen_Haswell;
   Has_Per_DDI_Clock_Sel         : constant Boolean := Gen_Haswell;
   Has_HOTPLUG_CTL               : constant Boolean := Gen_Haswell;
   function Has_SHOTPLUG_CTL_A return Boolean is
     ((Gen_Haswell and then Is_LP) or Skylake_On);

   Has_DDI_PHYs                  : constant Boolean := Gen_Broxton;

   function Has_DDI_D return Boolean is
     ((Gen_Haswell or Gen_Skylake) and then not Is_LP);
   -- might be disabled by x4 eDP:
   function Has_DDI_E return Boolean is
     (Has_DDI_D);

   Has_DDI_Buffer_Trans          : constant Boolean := Haswell_On and not Has_DDI_PHYs;
   Has_Low_Voltage_Swing         : constant Boolean := Broxton_On;
   Has_Iboost_Config             : constant Boolean := Skylake_On;
   function Use_KBL_DDI_Buf_Trans return Boolean is
     (CPU_Kabylake);

   Need_DP_Aux_Mutex             : constant Boolean := False; -- Skylake & (PSR | GTC)

   ----- DP: --------------------
   function DP_Max_2_7_GHz return Boolean is
     (not Haswell_On or else (CPU_Haswell and Is_ULX));

   ----------- GMBUS: -----------
   Ungate_GMBUS_Unit_Level       : constant Boolean := Skylake_On;
   GMBUS_Alternative_Pins        : constant Boolean := Gen_Broxton;
   Has_PCH_GMBUS                 : constant Boolean := Ironlake_On;

   ----------- Power: -----------
   function Has_IPS return Boolean is
     (Gen_Haswell and then
      ((CPU_Haswell and Is_LP) or CPU_Broadwell));
   function Has_IPS_CTL_Mailbox return Boolean is
     (CPU_Broadwell);

   function Has_Per_Pipe_SRD return Boolean is
     (Broadwell_On);

   ----------- GTT: -------------
   function Has_64bit_GTT return Boolean is
     (Broadwell_On);

   ----------------------------------------------------------------------------

   function Max_Pipe return Pipe_Index is
     (if Has_Tertiary_Pipe then Tertiary else Secondary);

   function Last_Digital_Port return Digital_Port is
     (if Has_DDI_E then DIGI_E else DIGI_C);

   ----------------------------------------------------------------------------

   type FDI_Per_Port is array (Port_Type) of Boolean;
   function Is_FDI_Port return FDI_Per_Port is
     (Disabled       => False,
      eDP            => False,
      LVDS           => Gen_Ironlake,
      DP1 .. HDMI3   => Gen_Ironlake,
      Analog         => Has_PCH_DAC);

   type FDI_Lanes_Per_Port is array (GPU_Port) of DP_Lane_Count;
   FDI_Lane_Count : constant FDI_Lanes_Per_Port :=
     (DIGI_D => DP_Lane_Count_2,
      others => (if Gen_Ironlake then DP_Lane_Count_4 else DP_Lane_Count_2));

   function FDI_Training return FDI_Training_Type is
     (if    CPU_Ironlake      then Simple_Training
      elsif CPU_Sandybridge   then Full_Training
                              else Auto_Training);

   ----------------------------------------------------------------------------

   function DDI_Buffer_Iboost return Natural is
     (if Is_ULX or (CPU_Kabylake and Is_ULT) then 3 else 1);

   function Default_DDI_HDMI_Buffer_Translation return DDI_HDMI_Buf_Trans_Range is
     (if    CPU_Haswell    then 6
      elsif CPU_Broadwell  then 7
      elsif Broxton_On     then 8
                           else 0);

   ----------------------------------------------------------------------------

   function Default_CDClk_Freq return CDClk_Range is
     (if    Gen_G45                          then 320_000_000  -- unused
      elsif CPU_Ironlake                     then 450_000_000
      elsif CPU_Sandybridge or CPU_Ivybridge then 400_000_000
      elsif Gen_Haswell and then Is_ULX      then 337_500_000
      elsif Gen_Haswell                      then 450_000_000
      elsif Gen_Broxton                      then 288_000_000
      elsif Gen_Skylake                      then 337_500_000
                                             else CDClk_Range'First);

   function Default_RawClk_Freq return Frequency_Type is
     (if    Gen_G45        then 100_000_000  -- unused, depends on FSB
      elsif Gen_Ironlake   then 125_000_000
      elsif Gen_Haswell    then (if Is_LP then 24_000_000 else 125_000_000)
      elsif Gen_Broxton    then Frequency_Type'First  -- none needed
      elsif Gen_Skylake    then 24_000_000
                           else Frequency_Type'First);

   ----------------------------------------------------------------------------

   -- Maximum source width with enabled scaler. This only accounts
   -- for simple 1:1 pipe:scaler mappings.

   type Width_Per_Pipe is array (Pipe_Index) of Width_Type;

   function Maximum_Scalable_Width return Width_Per_Pipe is
     (if Gen_G45 then   -- TODO: Is this true?
        (Primary     => 4096,
         Secondary   => 2048,
         Tertiary    => Pos32'First)
      elsif Gen_Ironlake or CPU_Haswell then
        (Primary     => 4096,
         Secondary   => 2048,
         Tertiary    => 2048)
      else
        (Primary     => 4096,
         Secondary   => 4096,
         Tertiary    => 4096));

   -- Maximum X position of hardware cursors
   Maximum_Cursor_X : constant :=
     (case Gen is
         when G45 .. Ironlake       => 4095,
         when Haswell .. Skylake    => 8191);

   Maximum_Cursor_Y : constant := 4095;

   ----------------------------------------------------------------------------

   -- FIXME: Unknown for Broxton, Linux' i915 contains a fixme too :-D
   HDMI_Max_Clock_24bpp : constant Frequency_Type :=
     (case Gen is
         when Generation'First .. G45     => 165_000_000,
         when Ironlake                    => 225_000_000,
         when Haswell .. Generation'Last  => 300_000_000);

   ----------------------------------------------------------------------------

   function GTT_PTE_Size return Natural is
     ((if Has_64bit_GTT then 8 else 4));

   function Fence_Base return Natural is
     (if not Sandybridge_On then 16#0000_3000# else 16#0010_0000#);

   function Fence_Count return Natural is
     (if not Ivybridge_On then 16 else 32);

   ----------------------------------------------------------------------------

   use type HW.Word16;

   -- GMA PCI IDs:
   --
   -- Rather catch too much here than too little, it's
   -- mostly used to distinguish generations. Best public
   -- reference for these IDs is Linux' i915.
   --
   -- Since Sandybridge, bits 4 and 5 encode the compu-
   -- tational capabilities and can mostly be ignored.
   -- From Haswell on, we have to distinguish between
   -- Normal, ULT (U CPU lines) and ULX (Y CPU lines).

   function Is_Haswell_Y (Device_Id : Word16) return Boolean is
     ((Device_Id and 16#ffef#) = 16#0a0e#);
   function Is_Haswell_U (Device_Id : Word16) return Boolean is
     (((Device_Id and 16#ffc3#) = 16#0a02# or
       (Device_Id and 16#ffcf#) = 16#0a0b#) and
      not Is_Haswell_Y (Device_Id));
   function Is_Haswell (Device_Id : Word16) return Boolean is
     ((Device_Id and 16#ffc3#) = 16#0402# or
      (Device_Id and 16#ffcf#) = 16#040b# or
      (Device_Id and 16#ffc3#) = 16#0c02# or
      (Device_Id and 16#ffcf#) = 16#0c0b# or
      (Device_Id and 16#ffc3#) = 16#0d02# or
      (Device_Id and 16#ffcf#) = 16#0d0b#);

   function Is_Broadwell_Y (Device_Id : Word16) return Boolean is
     ((Device_Id and 16#ffcf#) = 16#160e#);
   function Is_Broadwell_U (Device_Id : Word16) return Boolean is
     ((Device_Id and 16#ffcf#) = 16#1606# or
      (Device_Id and 16#ffcf#) = 16#160b#);
   function Is_Broadwell (Device_Id : Word16) return Boolean is
     ((Device_Id and 16#ffc7#) = 16#1602# or
      (Device_Id and 16#ffcf#) = 16#160d#);

   function Is_Skylake_Y (Device_Id : Word16) return Boolean is
     ((Device_Id and 16#ffcf#) = 16#190e#);
   function Is_Skylake_U (Device_Id : Word16) return Boolean is
     ((Device_Id and 16#ffc9#) = 16#1901# or
      (Device_Id and 16#ffcf#) = 16#1906#);
   function Is_Skylake (Device_Id : Word16) return Boolean is
     ((Device_Id and 16#ffc7#) = 16#1902# or
      (Device_Id and 16#ffcf#) = 16#190b# or
      (Device_Id and 16#ffcf#) = 16#190d#);

   function Is_Kaby_Lake_Y (Device_Id : Word16) return Boolean is
     ((Device_Id and 16#ffcf#) = 16#5905# or
      (Device_Id and 16#ffcf#) = 16#590e#);
   function Is_Kaby_Lake_Y_AML (Device_Id : Word16) return Boolean is
     (Device_Id = 16#591c# or Device_Id = 16#87c0#);
   function Is_Kaby_Lake_U (Device_Id : Word16) return Boolean is
     ((Device_Id and 16#ffcd#) = 16#5901# or
      (Device_Id and 16#ffce#) = 16#5906#);
   function Is_Kaby_Lake (Device_Id : Word16) return Boolean is
     ((Device_Id and 16#ffc7#) = 16#5902# or
      (Device_Id and 16#ffcf#) = 16#5908# or
      (Device_Id and 16#ffcf#) = 16#590b# or
      (Device_Id and 16#ffcf#) = 16#590d#);

   function Is_Coffee_Lake_Y_AML (Device_Id : Word16) return Boolean is
     (Device_Id = 16#87ca#);
   -- Including Whiskey Lake:
   function Is_Coffee_Lake_U (Device_Id : Word16) return Boolean is
     ((Device_Id and 16#fff0#) = 16#3ea0#);
   function Is_Coffee_Lake (Device_Id : Word16) return Boolean is
     ((Device_Id and 16#fff0#) = 16#3e90#);

   function Is_Comet_Lake_U (Device_Id : Word16) return Boolean is
     ((Device_Id and 16#ff9f#) = 16#9b01# or
      (Device_Id and 16#ff9f#) = 16#9b8a# or
      (Device_Id and 16#ff9f#) = 16#9b8c#);
   function Is_Comet_Lake (Device_Id : Word16) return Boolean is
     ((Device_Id and 16#ff8f#) = 16#9b82# or
      (Device_Id and 16#ff8f#) = 16#9b84# or
      (Device_Id and 16#ff8f#) = 16#9b85# or
      (Device_Id and 16#ff8f#) = 16#9b86# or
      (Device_Id and 16#ff8f#) = 16#9b88#);

   function Is_GPU (Device_Id : Word16; CPU : CPU_Type; CPU_Var : CPU_Variant)
      return Boolean is
     (case CPU is
         when G45          => (Device_Id and 16#ff02#) = 16#2e02#,
         when GM45         => (Device_Id and 16#fffe#) = 16#2a42#,
         when Ironlake     => (Device_Id and 16#fff3#) = 16#0042#,
         when Sandybridge  => (Device_Id and 16#ffc2#) = 16#0102#,
         when Ivybridge    => (Device_Id and 16#ffc3#) = 16#0142#,
         when Haswell      => (case CPU_Var is
                                 when Normal => Is_Haswell (Device_Id),
                                 when ULT    => Is_Haswell_U (Device_Id),
                                 when ULX    => Is_Haswell_Y (Device_Id)),
         when Broadwell    => (case CPU_Var is
                                 when Normal => Is_Broadwell (Device_Id),
                                 when ULT    => Is_Broadwell_U (Device_Id),
                                 when ULX    => Is_Broadwell_Y (Device_Id)),
         when Broxton      => (Device_Id and 16#fffe#) = 16#5a84#,
         when Skylake      => (case CPU_Var is
                                 when Normal => Is_Skylake (Device_Id),
                                 when ULT    => Is_Skylake_U (Device_Id),
                                 when ULX    => Is_Skylake_Y (Device_Id)),
         when Kabylake     => (case CPU_Var is
                                 when Normal =>
                                    Is_Kaby_Lake (Device_Id) or
                                    Is_Coffee_Lake (Device_Id) or
                                    Is_Comet_Lake (Device_Id),
                                 when ULT    =>
                                    Is_Kaby_Lake_U (Device_Id) or
                                    Is_Coffee_Lake_U (Device_Id) or
                                    Is_Comet_Lake_U (Device_Id),
                                 when ULX    =>
                                    Is_Kaby_Lake_Y (Device_Id) or
                                    Is_Kaby_Lake_Y_AML (Device_Id) or
                                    Is_Coffee_Lake_Y_AML (Device_Id)));

   function Compatible_GPU (Device_Id : Word16) return Boolean is
     (Is_GPU (Device_Id, CPU, CPU_Var));

   pragma Warnings (GNATprove, Off, "subprogram ""Detect_CPU"" has no effect",
                    Reason => "only effective in dynamic cpu config");
   procedure Detect_CPU (Device : Word16);

end HW.GFX.GMA.Config;
