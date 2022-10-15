-- ------------------------------------------------------------------------- 
-- High Level Design Compiler for Intel(R) FPGAs Version 21.1 (Release Build #850)
-- Quartus Prime development tool and MATLAB/Simulink Interface
-- 
-- Legal Notice: Copyright 2022 Intel Corporation.  All rights reserved.
-- Your use of  Intel Corporation's design tools,  logic functions and other
-- software and  tools, and its AMPP partner logic functions, and any output
-- files any  of the foregoing (including  device programming  or simulation
-- files), and  any associated  documentation  or information  are expressly
-- subject  to the terms and  conditions of the  Intel FPGA Software License
-- Agreement, Intel MegaCore Function License Agreement, or other applicable
-- license agreement,  including,  without limitation,  that your use is for
-- the  sole  purpose of  programming  logic devices  manufactured by  Intel
-- and  sold by Intel  or its authorized  distributors. Please refer  to the
-- applicable agreement for further details.
-- ---------------------------------------------------------------------------

-- VHDL created from cordic24_CORDIC_0
-- VHDL created on Fri Oct 14 23:15:46 2022


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.all;
use std.TextIO.all;
use work.dspba_library_package.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
LIBRARY lpm;
USE lpm.lpm_components.all;

entity cordic24_CORDIC_0 is
    port (
        a : in std_logic_vector(24 downto 0);  -- ufix25_en24
        c : out std_logic_vector(24 downto 0);  -- ufix25_en24
        s : out std_logic_vector(24 downto 0);  -- ufix25_en24
        clk : in std_logic;
        areset : in std_logic
    );
end cordic24_CORDIC_0;

architecture normal of cordic24_CORDIC_0 is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal cstOneOverK_uid6_sincosTest_q : STD_LOGIC_VECTOR (49 downto 0);
    signal cstArcTan2Mi_0_uid10_sincosTest_q : STD_LOGIC_VECTOR (34 downto 0);
    signal xip1E_1_uid16_sincosTest_q : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1E_1CostZeroPaddingA_uid17_sincosTest_q : STD_LOGIC_VECTOR (49 downto 0);
    signal yip1E_1NA_uid18_sincosTest_q : STD_LOGIC_VECTOR (50 downto 0);
    signal yip1E_1sumAHighB_uid19_sincosTest_a : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1E_1sumAHighB_uid19_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1E_1sumAHighB_uid19_sincosTest_o : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1E_1sumAHighB_uid19_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_1sumAHighB_uid19_sincosTest_q : STD_LOGIC_VECTOR (51 downto 0);
    signal invSignOfSelectionSignal_uid20_sincosTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_1CostZeroPaddingA_uid21_sincosTest_q : STD_LOGIC_VECTOR (9 downto 0);
    signal aip1E_1NA_uid22_sincosTest_q : STD_LOGIC_VECTOR (34 downto 0);
    signal aip1E_1sumAHighB_uid23_sincosTest_a : STD_LOGIC_VECTOR (37 downto 0);
    signal aip1E_1sumAHighB_uid23_sincosTest_b : STD_LOGIC_VECTOR (37 downto 0);
    signal aip1E_1sumAHighB_uid23_sincosTest_o : STD_LOGIC_VECTOR (37 downto 0);
    signal aip1E_1sumAHighB_uid23_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_1sumAHighB_uid23_sincosTest_q : STD_LOGIC_VECTOR (36 downto 0);
    signal xip1_1_topRange_uid25_sincosTest_in : STD_LOGIC_VECTOR (51 downto 0);
    signal xip1_1_topRange_uid25_sincosTest_b : STD_LOGIC_VECTOR (51 downto 0);
    signal xip1_1_mergedSignalTM_uid26_sincosTest_q : STD_LOGIC_VECTOR (52 downto 0);
    signal xMSB_uid28_sincosTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1_1_mergedSignalTM_uid32_sincosTest_q : STD_LOGIC_VECTOR (52 downto 0);
    signal aip1E_uid34_sincosTest_in : STD_LOGIC_VECTOR (35 downto 0);
    signal aip1E_uid34_sincosTest_b : STD_LOGIC_VECTOR (35 downto 0);
    signal xMSB_uid35_sincosTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid37_sincosTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid40_sincosTest_b : STD_LOGIC_VECTOR (51 downto 0);
    signal twoToMiSiYip_uid41_sincosTest_b : STD_LOGIC_VECTOR (51 downto 0);
    signal cstArcTan2Mi_1_uid42_sincosTest_q : STD_LOGIC_VECTOR (33 downto 0);
    signal xip1E_2_uid44_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_2_uid44_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_2_uid44_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_2_uid44_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_2_uid44_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal yip1E_2_uid45_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_2_uid45_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_2_uid45_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_2_uid45_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_2_uid45_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal aip1E_2_uid47_sincosTest_a : STD_LOGIC_VECTOR (37 downto 0);
    signal aip1E_2_uid47_sincosTest_b : STD_LOGIC_VECTOR (37 downto 0);
    signal aip1E_2_uid47_sincosTest_o : STD_LOGIC_VECTOR (37 downto 0);
    signal aip1E_2_uid47_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_2_uid47_sincosTest_q : STD_LOGIC_VECTOR (36 downto 0);
    signal xip1_2_uid48_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal xip1_2_uid48_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_2_uid49_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_2_uid49_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal aip1E_uid50_sincosTest_in : STD_LOGIC_VECTOR (34 downto 0);
    signal aip1E_uid50_sincosTest_b : STD_LOGIC_VECTOR (34 downto 0);
    signal xMSB_uid51_sincosTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid53_sincosTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid56_sincosTest_b : STD_LOGIC_VECTOR (50 downto 0);
    signal twoToMiSiYip_uid57_sincosTest_b : STD_LOGIC_VECTOR (50 downto 0);
    signal cstArcTan2Mi_2_uid58_sincosTest_q : STD_LOGIC_VECTOR (32 downto 0);
    signal xip1E_3_uid60_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_3_uid60_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_3_uid60_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_3_uid60_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_3_uid60_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal yip1E_3_uid61_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_3_uid61_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_3_uid61_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_3_uid61_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_3_uid61_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal aip1E_3_uid63_sincosTest_a : STD_LOGIC_VECTOR (36 downto 0);
    signal aip1E_3_uid63_sincosTest_b : STD_LOGIC_VECTOR (36 downto 0);
    signal aip1E_3_uid63_sincosTest_o : STD_LOGIC_VECTOR (36 downto 0);
    signal aip1E_3_uid63_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_3_uid63_sincosTest_q : STD_LOGIC_VECTOR (35 downto 0);
    signal xip1_3_uid64_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal xip1_3_uid64_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_3_uid65_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_3_uid65_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal aip1E_uid66_sincosTest_in : STD_LOGIC_VECTOR (33 downto 0);
    signal aip1E_uid66_sincosTest_b : STD_LOGIC_VECTOR (33 downto 0);
    signal xMSB_uid67_sincosTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid69_sincosTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid72_sincosTest_b : STD_LOGIC_VECTOR (49 downto 0);
    signal twoToMiSiYip_uid73_sincosTest_b : STD_LOGIC_VECTOR (49 downto 0);
    signal cstArcTan2Mi_3_uid74_sincosTest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal xip1E_4_uid76_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_4_uid76_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_4_uid76_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_4_uid76_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_4_uid76_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal yip1E_4_uid77_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_4_uid77_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_4_uid77_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_4_uid77_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_4_uid77_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal aip1E_4_uid79_sincosTest_a : STD_LOGIC_VECTOR (35 downto 0);
    signal aip1E_4_uid79_sincosTest_b : STD_LOGIC_VECTOR (35 downto 0);
    signal aip1E_4_uid79_sincosTest_o : STD_LOGIC_VECTOR (35 downto 0);
    signal aip1E_4_uid79_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_4_uid79_sincosTest_q : STD_LOGIC_VECTOR (34 downto 0);
    signal xip1_4_uid80_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal xip1_4_uid80_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_4_uid81_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_4_uid81_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal aip1E_uid82_sincosTest_in : STD_LOGIC_VECTOR (32 downto 0);
    signal aip1E_uid82_sincosTest_b : STD_LOGIC_VECTOR (32 downto 0);
    signal xMSB_uid83_sincosTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid85_sincosTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid88_sincosTest_b : STD_LOGIC_VECTOR (48 downto 0);
    signal twoToMiSiYip_uid89_sincosTest_b : STD_LOGIC_VECTOR (48 downto 0);
    signal cstArcTan2Mi_4_uid90_sincosTest_q : STD_LOGIC_VECTOR (30 downto 0);
    signal xip1E_5_uid92_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_5_uid92_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_5_uid92_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_5_uid92_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_5_uid92_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal yip1E_5_uid93_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_5_uid93_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_5_uid93_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_5_uid93_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_5_uid93_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal aip1E_5_uid95_sincosTest_a : STD_LOGIC_VECTOR (34 downto 0);
    signal aip1E_5_uid95_sincosTest_b : STD_LOGIC_VECTOR (34 downto 0);
    signal aip1E_5_uid95_sincosTest_o : STD_LOGIC_VECTOR (34 downto 0);
    signal aip1E_5_uid95_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_5_uid95_sincosTest_q : STD_LOGIC_VECTOR (33 downto 0);
    signal xip1_5_uid96_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal xip1_5_uid96_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_5_uid97_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_5_uid97_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal aip1E_uid98_sincosTest_in : STD_LOGIC_VECTOR (31 downto 0);
    signal aip1E_uid98_sincosTest_b : STD_LOGIC_VECTOR (31 downto 0);
    signal xMSB_uid99_sincosTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid101_sincosTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid104_sincosTest_b : STD_LOGIC_VECTOR (47 downto 0);
    signal twoToMiSiYip_uid105_sincosTest_b : STD_LOGIC_VECTOR (47 downto 0);
    signal cstArcTan2Mi_5_uid106_sincosTest_q : STD_LOGIC_VECTOR (29 downto 0);
    signal xip1E_6_uid108_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_6_uid108_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_6_uid108_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_6_uid108_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_6_uid108_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal yip1E_6_uid109_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_6_uid109_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_6_uid109_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_6_uid109_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_6_uid109_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal aip1E_6_uid111_sincosTest_a : STD_LOGIC_VECTOR (33 downto 0);
    signal aip1E_6_uid111_sincosTest_b : STD_LOGIC_VECTOR (33 downto 0);
    signal aip1E_6_uid111_sincosTest_o : STD_LOGIC_VECTOR (33 downto 0);
    signal aip1E_6_uid111_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_6_uid111_sincosTest_q : STD_LOGIC_VECTOR (32 downto 0);
    signal xip1_6_uid112_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal xip1_6_uid112_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_6_uid113_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_6_uid113_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal aip1E_uid114_sincosTest_in : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_uid114_sincosTest_b : STD_LOGIC_VECTOR (30 downto 0);
    signal xMSB_uid115_sincosTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid117_sincosTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid120_sincosTest_b : STD_LOGIC_VECTOR (46 downto 0);
    signal twoToMiSiYip_uid121_sincosTest_b : STD_LOGIC_VECTOR (46 downto 0);
    signal cstArcTan2Mi_6_uid122_sincosTest_q : STD_LOGIC_VECTOR (28 downto 0);
    signal xip1E_7_uid124_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_7_uid124_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_7_uid124_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_7_uid124_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_7_uid124_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal yip1E_7_uid125_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_7_uid125_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_7_uid125_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_7_uid125_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_7_uid125_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal aip1E_7_uid127_sincosTest_a : STD_LOGIC_VECTOR (32 downto 0);
    signal aip1E_7_uid127_sincosTest_b : STD_LOGIC_VECTOR (32 downto 0);
    signal aip1E_7_uid127_sincosTest_o : STD_LOGIC_VECTOR (32 downto 0);
    signal aip1E_7_uid127_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_7_uid127_sincosTest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal xip1_7_uid128_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal xip1_7_uid128_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_7_uid129_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_7_uid129_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal aip1E_uid130_sincosTest_in : STD_LOGIC_VECTOR (29 downto 0);
    signal aip1E_uid130_sincosTest_b : STD_LOGIC_VECTOR (29 downto 0);
    signal xMSB_uid131_sincosTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid133_sincosTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid136_sincosTest_b : STD_LOGIC_VECTOR (45 downto 0);
    signal twoToMiSiYip_uid137_sincosTest_b : STD_LOGIC_VECTOR (45 downto 0);
    signal cstArcTan2Mi_7_uid138_sincosTest_q : STD_LOGIC_VECTOR (27 downto 0);
    signal xip1E_8_uid140_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_8_uid140_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_8_uid140_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_8_uid140_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_8_uid140_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal yip1E_8_uid141_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_8_uid141_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_8_uid141_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_8_uid141_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_8_uid141_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal aip1E_8_uid143_sincosTest_a : STD_LOGIC_VECTOR (31 downto 0);
    signal aip1E_8_uid143_sincosTest_b : STD_LOGIC_VECTOR (31 downto 0);
    signal aip1E_8_uid143_sincosTest_o : STD_LOGIC_VECTOR (31 downto 0);
    signal aip1E_8_uid143_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_8_uid143_sincosTest_q : STD_LOGIC_VECTOR (30 downto 0);
    signal xip1_8_uid144_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal xip1_8_uid144_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_8_uid145_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_8_uid145_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal aip1E_uid146_sincosTest_in : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_uid146_sincosTest_b : STD_LOGIC_VECTOR (28 downto 0);
    signal xMSB_uid147_sincosTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid149_sincosTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid152_sincosTest_b : STD_LOGIC_VECTOR (44 downto 0);
    signal twoToMiSiYip_uid153_sincosTest_b : STD_LOGIC_VECTOR (44 downto 0);
    signal cstArcTan2Mi_8_uid154_sincosTest_q : STD_LOGIC_VECTOR (26 downto 0);
    signal xip1E_9_uid156_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_9_uid156_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_9_uid156_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_9_uid156_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_9_uid156_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal yip1E_9_uid157_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_9_uid157_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_9_uid157_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_9_uid157_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_9_uid157_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal aip1E_9_uid159_sincosTest_a : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_9_uid159_sincosTest_b : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_9_uid159_sincosTest_o : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_9_uid159_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_9_uid159_sincosTest_q : STD_LOGIC_VECTOR (29 downto 0);
    signal xip1_9_uid160_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal xip1_9_uid160_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_9_uid161_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_9_uid161_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal aip1E_uid162_sincosTest_in : STD_LOGIC_VECTOR (27 downto 0);
    signal aip1E_uid162_sincosTest_b : STD_LOGIC_VECTOR (27 downto 0);
    signal xMSB_uid163_sincosTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid165_sincosTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid168_sincosTest_b : STD_LOGIC_VECTOR (43 downto 0);
    signal twoToMiSiYip_uid169_sincosTest_b : STD_LOGIC_VECTOR (43 downto 0);
    signal cstArcTan2Mi_9_uid170_sincosTest_q : STD_LOGIC_VECTOR (25 downto 0);
    signal xip1E_10_uid172_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_10_uid172_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_10_uid172_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_10_uid172_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_10_uid172_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal yip1E_10_uid173_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_10_uid173_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_10_uid173_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_10_uid173_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_10_uid173_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal aip1E_10_uid175_sincosTest_a : STD_LOGIC_VECTOR (29 downto 0);
    signal aip1E_10_uid175_sincosTest_b : STD_LOGIC_VECTOR (29 downto 0);
    signal aip1E_10_uid175_sincosTest_o : STD_LOGIC_VECTOR (29 downto 0);
    signal aip1E_10_uid175_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_10_uid175_sincosTest_q : STD_LOGIC_VECTOR (28 downto 0);
    signal xip1_10_uid176_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal xip1_10_uid176_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_10_uid177_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_10_uid177_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal aip1E_uid178_sincosTest_in : STD_LOGIC_VECTOR (26 downto 0);
    signal aip1E_uid178_sincosTest_b : STD_LOGIC_VECTOR (26 downto 0);
    signal xMSB_uid179_sincosTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid181_sincosTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid184_sincosTest_b : STD_LOGIC_VECTOR (42 downto 0);
    signal twoToMiSiYip_uid185_sincosTest_b : STD_LOGIC_VECTOR (42 downto 0);
    signal cstArcTan2Mi_10_uid186_sincosTest_q : STD_LOGIC_VECTOR (24 downto 0);
    signal xip1E_11_uid188_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_11_uid188_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_11_uid188_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_11_uid188_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_11_uid188_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal yip1E_11_uid189_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_11_uid189_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_11_uid189_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_11_uid189_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_11_uid189_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal aip1E_11_uid191_sincosTest_a : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_11_uid191_sincosTest_b : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_11_uid191_sincosTest_o : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_11_uid191_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_11_uid191_sincosTest_q : STD_LOGIC_VECTOR (27 downto 0);
    signal xip1_11_uid192_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal xip1_11_uid192_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_11_uid193_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_11_uid193_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal aip1E_uid194_sincosTest_in : STD_LOGIC_VECTOR (25 downto 0);
    signal aip1E_uid194_sincosTest_b : STD_LOGIC_VECTOR (25 downto 0);
    signal xMSB_uid195_sincosTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid197_sincosTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid200_sincosTest_b : STD_LOGIC_VECTOR (41 downto 0);
    signal twoToMiSiYip_uid201_sincosTest_b : STD_LOGIC_VECTOR (41 downto 0);
    signal cstArcTan2Mi_11_uid202_sincosTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal xip1E_12_uid204_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_12_uid204_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_12_uid204_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_12_uid204_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_12_uid204_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal yip1E_12_uid205_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_12_uid205_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_12_uid205_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_12_uid205_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_12_uid205_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal aip1E_12_uid207_sincosTest_a : STD_LOGIC_VECTOR (27 downto 0);
    signal aip1E_12_uid207_sincosTest_b : STD_LOGIC_VECTOR (27 downto 0);
    signal aip1E_12_uid207_sincosTest_o : STD_LOGIC_VECTOR (27 downto 0);
    signal aip1E_12_uid207_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_12_uid207_sincosTest_q : STD_LOGIC_VECTOR (26 downto 0);
    signal xip1_12_uid208_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal xip1_12_uid208_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_12_uid209_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_12_uid209_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal aip1E_uid210_sincosTest_in : STD_LOGIC_VECTOR (24 downto 0);
    signal aip1E_uid210_sincosTest_b : STD_LOGIC_VECTOR (24 downto 0);
    signal xMSB_uid211_sincosTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid213_sincosTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid216_sincosTest_b : STD_LOGIC_VECTOR (40 downto 0);
    signal twoToMiSiYip_uid217_sincosTest_b : STD_LOGIC_VECTOR (40 downto 0);
    signal cstArcTan2Mi_12_uid218_sincosTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal xip1E_13_uid220_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_13_uid220_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_13_uid220_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_13_uid220_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_13_uid220_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal yip1E_13_uid221_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_13_uid221_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_13_uid221_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_13_uid221_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_13_uid221_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal lowRangeA_uid223_sincosTest_in : STD_LOGIC_VECTOR (0 downto 0);
    signal lowRangeA_uid223_sincosTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal highABits_uid224_sincosTest_b : STD_LOGIC_VECTOR (23 downto 0);
    signal aip1E_13high_uid225_sincosTest_a : STD_LOGIC_VECTOR (25 downto 0);
    signal aip1E_13high_uid225_sincosTest_b : STD_LOGIC_VECTOR (25 downto 0);
    signal aip1E_13high_uid225_sincosTest_o : STD_LOGIC_VECTOR (25 downto 0);
    signal aip1E_13high_uid225_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_13high_uid225_sincosTest_q : STD_LOGIC_VECTOR (24 downto 0);
    signal aip1E_13_uid226_sincosTest_q : STD_LOGIC_VECTOR (25 downto 0);
    signal xip1_13_uid227_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal xip1_13_uid227_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_13_uid228_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_13_uid228_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal aip1E_uid229_sincosTest_in : STD_LOGIC_VECTOR (23 downto 0);
    signal aip1E_uid229_sincosTest_b : STD_LOGIC_VECTOR (23 downto 0);
    signal xMSB_uid230_sincosTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid232_sincosTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid235_sincosTest_b : STD_LOGIC_VECTOR (39 downto 0);
    signal twoToMiSiYip_uid236_sincosTest_b : STD_LOGIC_VECTOR (39 downto 0);
    signal cstArcTan2Mi_13_uid237_sincosTest_q : STD_LOGIC_VECTOR (21 downto 0);
    signal xip1E_14_uid239_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_14_uid239_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_14_uid239_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_14_uid239_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_14_uid239_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal yip1E_14_uid240_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_14_uid240_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_14_uid240_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_14_uid240_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_14_uid240_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal lowRangeA_uid242_sincosTest_in : STD_LOGIC_VECTOR (0 downto 0);
    signal lowRangeA_uid242_sincosTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal highABits_uid243_sincosTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal aip1E_14high_uid244_sincosTest_a : STD_LOGIC_VECTOR (24 downto 0);
    signal aip1E_14high_uid244_sincosTest_b : STD_LOGIC_VECTOR (24 downto 0);
    signal aip1E_14high_uid244_sincosTest_o : STD_LOGIC_VECTOR (24 downto 0);
    signal aip1E_14high_uid244_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_14high_uid244_sincosTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal aip1E_14_uid245_sincosTest_q : STD_LOGIC_VECTOR (24 downto 0);
    signal xip1_14_uid246_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal xip1_14_uid246_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_14_uid247_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_14_uid247_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal aip1E_uid248_sincosTest_in : STD_LOGIC_VECTOR (22 downto 0);
    signal aip1E_uid248_sincosTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal xMSB_uid249_sincosTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid251_sincosTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid254_sincosTest_b : STD_LOGIC_VECTOR (38 downto 0);
    signal twoToMiSiYip_uid255_sincosTest_b : STD_LOGIC_VECTOR (38 downto 0);
    signal cstArcTan2Mi_14_uid256_sincosTest_q : STD_LOGIC_VECTOR (20 downto 0);
    signal xip1E_15_uid258_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_15_uid258_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_15_uid258_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_15_uid258_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_15_uid258_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal yip1E_15_uid259_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_15_uid259_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_15_uid259_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_15_uid259_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_15_uid259_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal lowRangeA_uid261_sincosTest_in : STD_LOGIC_VECTOR (0 downto 0);
    signal lowRangeA_uid261_sincosTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal highABits_uid262_sincosTest_b : STD_LOGIC_VECTOR (21 downto 0);
    signal aip1E_15high_uid263_sincosTest_a : STD_LOGIC_VECTOR (23 downto 0);
    signal aip1E_15high_uid263_sincosTest_b : STD_LOGIC_VECTOR (23 downto 0);
    signal aip1E_15high_uid263_sincosTest_o : STD_LOGIC_VECTOR (23 downto 0);
    signal aip1E_15high_uid263_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_15high_uid263_sincosTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal aip1E_15_uid264_sincosTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal xip1_15_uid265_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal xip1_15_uid265_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_15_uid266_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_15_uid266_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal aip1E_uid267_sincosTest_in : STD_LOGIC_VECTOR (21 downto 0);
    signal aip1E_uid267_sincosTest_b : STD_LOGIC_VECTOR (21 downto 0);
    signal xMSB_uid268_sincosTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid270_sincosTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid273_sincosTest_b : STD_LOGIC_VECTOR (37 downto 0);
    signal twoToMiSiYip_uid274_sincosTest_b : STD_LOGIC_VECTOR (37 downto 0);
    signal cstArcTan2Mi_15_uid275_sincosTest_q : STD_LOGIC_VECTOR (19 downto 0);
    signal xip1E_16_uid277_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_16_uid277_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_16_uid277_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_16_uid277_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_16_uid277_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal yip1E_16_uid278_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_16_uid278_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_16_uid278_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_16_uid278_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_16_uid278_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal lowRangeA_uid280_sincosTest_in : STD_LOGIC_VECTOR (0 downto 0);
    signal lowRangeA_uid280_sincosTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal highABits_uid281_sincosTest_b : STD_LOGIC_VECTOR (20 downto 0);
    signal aip1E_16high_uid282_sincosTest_a : STD_LOGIC_VECTOR (22 downto 0);
    signal aip1E_16high_uid282_sincosTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal aip1E_16high_uid282_sincosTest_o : STD_LOGIC_VECTOR (22 downto 0);
    signal aip1E_16high_uid282_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_16high_uid282_sincosTest_q : STD_LOGIC_VECTOR (21 downto 0);
    signal aip1E_16_uid283_sincosTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal xip1_16_uid284_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal xip1_16_uid284_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_16_uid285_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_16_uid285_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal aip1E_uid286_sincosTest_in : STD_LOGIC_VECTOR (20 downto 0);
    signal aip1E_uid286_sincosTest_b : STD_LOGIC_VECTOR (20 downto 0);
    signal xMSB_uid287_sincosTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid289_sincosTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid292_sincosTest_b : STD_LOGIC_VECTOR (36 downto 0);
    signal twoToMiSiYip_uid293_sincosTest_b : STD_LOGIC_VECTOR (36 downto 0);
    signal cstArcTan2Mi_16_uid294_sincosTest_q : STD_LOGIC_VECTOR (18 downto 0);
    signal xip1E_17_uid296_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_17_uid296_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_17_uid296_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_17_uid296_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_17_uid296_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal yip1E_17_uid297_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_17_uid297_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_17_uid297_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_17_uid297_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_17_uid297_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal lowRangeA_uid299_sincosTest_in : STD_LOGIC_VECTOR (0 downto 0);
    signal lowRangeA_uid299_sincosTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal highABits_uid300_sincosTest_b : STD_LOGIC_VECTOR (19 downto 0);
    signal aip1E_17high_uid301_sincosTest_a : STD_LOGIC_VECTOR (21 downto 0);
    signal aip1E_17high_uid301_sincosTest_b : STD_LOGIC_VECTOR (21 downto 0);
    signal aip1E_17high_uid301_sincosTest_o : STD_LOGIC_VECTOR (21 downto 0);
    signal aip1E_17high_uid301_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_17high_uid301_sincosTest_q : STD_LOGIC_VECTOR (20 downto 0);
    signal aip1E_17_uid302_sincosTest_q : STD_LOGIC_VECTOR (21 downto 0);
    signal xip1_17_uid303_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal xip1_17_uid303_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_17_uid304_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_17_uid304_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal aip1E_uid305_sincosTest_in : STD_LOGIC_VECTOR (19 downto 0);
    signal aip1E_uid305_sincosTest_b : STD_LOGIC_VECTOR (19 downto 0);
    signal xMSB_uid306_sincosTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid308_sincosTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid311_sincosTest_b : STD_LOGIC_VECTOR (35 downto 0);
    signal twoToMiSiYip_uid312_sincosTest_b : STD_LOGIC_VECTOR (35 downto 0);
    signal cstArcTan2Mi_17_uid313_sincosTest_q : STD_LOGIC_VECTOR (17 downto 0);
    signal xip1E_18_uid315_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_18_uid315_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_18_uid315_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_18_uid315_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_18_uid315_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal yip1E_18_uid316_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_18_uid316_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_18_uid316_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_18_uid316_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_18_uid316_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal lowRangeA_uid318_sincosTest_in : STD_LOGIC_VECTOR (0 downto 0);
    signal lowRangeA_uid318_sincosTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal highABits_uid319_sincosTest_b : STD_LOGIC_VECTOR (18 downto 0);
    signal aip1E_18high_uid320_sincosTest_a : STD_LOGIC_VECTOR (20 downto 0);
    signal aip1E_18high_uid320_sincosTest_b : STD_LOGIC_VECTOR (20 downto 0);
    signal aip1E_18high_uid320_sincosTest_o : STD_LOGIC_VECTOR (20 downto 0);
    signal aip1E_18high_uid320_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_18high_uid320_sincosTest_q : STD_LOGIC_VECTOR (19 downto 0);
    signal aip1E_18_uid321_sincosTest_q : STD_LOGIC_VECTOR (20 downto 0);
    signal xip1_18_uid322_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal xip1_18_uid322_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_18_uid323_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_18_uid323_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal aip1E_uid324_sincosTest_in : STD_LOGIC_VECTOR (18 downto 0);
    signal aip1E_uid324_sincosTest_b : STD_LOGIC_VECTOR (18 downto 0);
    signal xMSB_uid325_sincosTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid327_sincosTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid330_sincosTest_b : STD_LOGIC_VECTOR (34 downto 0);
    signal twoToMiSiYip_uid331_sincosTest_b : STD_LOGIC_VECTOR (34 downto 0);
    signal cstArcTan2Mi_18_uid332_sincosTest_q : STD_LOGIC_VECTOR (16 downto 0);
    signal xip1E_19_uid334_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_19_uid334_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_19_uid334_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_19_uid334_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_19_uid334_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal yip1E_19_uid335_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_19_uid335_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_19_uid335_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_19_uid335_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_19_uid335_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal lowRangeA_uid337_sincosTest_in : STD_LOGIC_VECTOR (0 downto 0);
    signal lowRangeA_uid337_sincosTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal highABits_uid338_sincosTest_b : STD_LOGIC_VECTOR (17 downto 0);
    signal aip1E_19high_uid339_sincosTest_a : STD_LOGIC_VECTOR (19 downto 0);
    signal aip1E_19high_uid339_sincosTest_b : STD_LOGIC_VECTOR (19 downto 0);
    signal aip1E_19high_uid339_sincosTest_o : STD_LOGIC_VECTOR (19 downto 0);
    signal aip1E_19high_uid339_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_19high_uid339_sincosTest_q : STD_LOGIC_VECTOR (18 downto 0);
    signal aip1E_19_uid340_sincosTest_q : STD_LOGIC_VECTOR (19 downto 0);
    signal xip1_19_uid341_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal xip1_19_uid341_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_19_uid342_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_19_uid342_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal aip1E_uid343_sincosTest_in : STD_LOGIC_VECTOR (17 downto 0);
    signal aip1E_uid343_sincosTest_b : STD_LOGIC_VECTOR (17 downto 0);
    signal xMSB_uid344_sincosTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid346_sincosTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid349_sincosTest_b : STD_LOGIC_VECTOR (33 downto 0);
    signal twoToMiSiYip_uid350_sincosTest_b : STD_LOGIC_VECTOR (33 downto 0);
    signal cstArcTan2Mi_19_uid351_sincosTest_q : STD_LOGIC_VECTOR (15 downto 0);
    signal xip1E_20_uid353_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_20_uid353_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_20_uid353_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_20_uid353_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_20_uid353_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal yip1E_20_uid354_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_20_uid354_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_20_uid354_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_20_uid354_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_20_uid354_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal lowRangeA_uid356_sincosTest_in : STD_LOGIC_VECTOR (0 downto 0);
    signal lowRangeA_uid356_sincosTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal highABits_uid357_sincosTest_b : STD_LOGIC_VECTOR (16 downto 0);
    signal aip1E_20high_uid358_sincosTest_a : STD_LOGIC_VECTOR (18 downto 0);
    signal aip1E_20high_uid358_sincosTest_b : STD_LOGIC_VECTOR (18 downto 0);
    signal aip1E_20high_uid358_sincosTest_o : STD_LOGIC_VECTOR (18 downto 0);
    signal aip1E_20high_uid358_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_20high_uid358_sincosTest_q : STD_LOGIC_VECTOR (17 downto 0);
    signal aip1E_20_uid359_sincosTest_q : STD_LOGIC_VECTOR (18 downto 0);
    signal xip1_20_uid360_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal xip1_20_uid360_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_20_uid361_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_20_uid361_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal aip1E_uid362_sincosTest_in : STD_LOGIC_VECTOR (16 downto 0);
    signal aip1E_uid362_sincosTest_b : STD_LOGIC_VECTOR (16 downto 0);
    signal xMSB_uid363_sincosTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid365_sincosTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid368_sincosTest_b : STD_LOGIC_VECTOR (32 downto 0);
    signal twoToMiSiYip_uid369_sincosTest_b : STD_LOGIC_VECTOR (32 downto 0);
    signal cstArcTan2Mi_20_uid370_sincosTest_q : STD_LOGIC_VECTOR (14 downto 0);
    signal xip1E_21_uid372_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_21_uid372_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_21_uid372_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_21_uid372_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_21_uid372_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal yip1E_21_uid373_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_21_uid373_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_21_uid373_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_21_uid373_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_21_uid373_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal lowRangeA_uid375_sincosTest_in : STD_LOGIC_VECTOR (0 downto 0);
    signal lowRangeA_uid375_sincosTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal highABits_uid376_sincosTest_b : STD_LOGIC_VECTOR (15 downto 0);
    signal aip1E_21high_uid377_sincosTest_a : STD_LOGIC_VECTOR (17 downto 0);
    signal aip1E_21high_uid377_sincosTest_b : STD_LOGIC_VECTOR (17 downto 0);
    signal aip1E_21high_uid377_sincosTest_o : STD_LOGIC_VECTOR (17 downto 0);
    signal aip1E_21high_uid377_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_21high_uid377_sincosTest_q : STD_LOGIC_VECTOR (16 downto 0);
    signal aip1E_21_uid378_sincosTest_q : STD_LOGIC_VECTOR (17 downto 0);
    signal xip1_21_uid379_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal xip1_21_uid379_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_21_uid380_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_21_uid380_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal aip1E_uid381_sincosTest_in : STD_LOGIC_VECTOR (15 downto 0);
    signal aip1E_uid381_sincosTest_b : STD_LOGIC_VECTOR (15 downto 0);
    signal xMSB_uid382_sincosTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid384_sincosTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid387_sincosTest_b : STD_LOGIC_VECTOR (31 downto 0);
    signal twoToMiSiYip_uid388_sincosTest_b : STD_LOGIC_VECTOR (31 downto 0);
    signal cstArcTan2Mi_21_uid389_sincosTest_q : STD_LOGIC_VECTOR (13 downto 0);
    signal xip1E_22_uid391_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_22_uid391_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_22_uid391_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_22_uid391_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_22_uid391_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal yip1E_22_uid392_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_22_uid392_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_22_uid392_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_22_uid392_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_22_uid392_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal lowRangeA_uid394_sincosTest_in : STD_LOGIC_VECTOR (0 downto 0);
    signal lowRangeA_uid394_sincosTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal highABits_uid395_sincosTest_b : STD_LOGIC_VECTOR (14 downto 0);
    signal aip1E_22high_uid396_sincosTest_a : STD_LOGIC_VECTOR (16 downto 0);
    signal aip1E_22high_uid396_sincosTest_b : STD_LOGIC_VECTOR (16 downto 0);
    signal aip1E_22high_uid396_sincosTest_o : STD_LOGIC_VECTOR (16 downto 0);
    signal aip1E_22high_uid396_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_22high_uid396_sincosTest_q : STD_LOGIC_VECTOR (15 downto 0);
    signal aip1E_22_uid397_sincosTest_q : STD_LOGIC_VECTOR (16 downto 0);
    signal xip1_22_uid398_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal xip1_22_uid398_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_22_uid399_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_22_uid399_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal aip1E_uid400_sincosTest_in : STD_LOGIC_VECTOR (14 downto 0);
    signal aip1E_uid400_sincosTest_b : STD_LOGIC_VECTOR (14 downto 0);
    signal xMSB_uid401_sincosTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid403_sincosTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid406_sincosTest_b : STD_LOGIC_VECTOR (30 downto 0);
    signal twoToMiSiYip_uid407_sincosTest_b : STD_LOGIC_VECTOR (30 downto 0);
    signal cstArcTan2Mi_22_uid408_sincosTest_q : STD_LOGIC_VECTOR (12 downto 0);
    signal xip1E_23_uid410_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_23_uid410_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_23_uid410_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_23_uid410_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_23_uid410_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal yip1E_23_uid411_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_23_uid411_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_23_uid411_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_23_uid411_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_23_uid411_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal lowRangeA_uid413_sincosTest_in : STD_LOGIC_VECTOR (0 downto 0);
    signal lowRangeA_uid413_sincosTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal highABits_uid414_sincosTest_b : STD_LOGIC_VECTOR (13 downto 0);
    signal aip1E_23high_uid415_sincosTest_a : STD_LOGIC_VECTOR (15 downto 0);
    signal aip1E_23high_uid415_sincosTest_b : STD_LOGIC_VECTOR (15 downto 0);
    signal aip1E_23high_uid415_sincosTest_o : STD_LOGIC_VECTOR (15 downto 0);
    signal aip1E_23high_uid415_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_23high_uid415_sincosTest_q : STD_LOGIC_VECTOR (14 downto 0);
    signal aip1E_23_uid416_sincosTest_q : STD_LOGIC_VECTOR (15 downto 0);
    signal xip1_23_uid417_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal xip1_23_uid417_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_23_uid418_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_23_uid418_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal aip1E_uid419_sincosTest_in : STD_LOGIC_VECTOR (13 downto 0);
    signal aip1E_uid419_sincosTest_b : STD_LOGIC_VECTOR (13 downto 0);
    signal xMSB_uid420_sincosTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid422_sincosTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid425_sincosTest_b : STD_LOGIC_VECTOR (29 downto 0);
    signal twoToMiSiYip_uid426_sincosTest_b : STD_LOGIC_VECTOR (29 downto 0);
    signal cstArcTan2Mi_23_uid427_sincosTest_q : STD_LOGIC_VECTOR (11 downto 0);
    signal xip1E_24_uid429_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_24_uid429_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_24_uid429_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_24_uid429_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_24_uid429_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal yip1E_24_uid430_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_24_uid430_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_24_uid430_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_24_uid430_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_24_uid430_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal lowRangeA_uid432_sincosTest_in : STD_LOGIC_VECTOR (0 downto 0);
    signal lowRangeA_uid432_sincosTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal highABits_uid433_sincosTest_b : STD_LOGIC_VECTOR (12 downto 0);
    signal aip1E_24high_uid434_sincosTest_a : STD_LOGIC_VECTOR (14 downto 0);
    signal aip1E_24high_uid434_sincosTest_b : STD_LOGIC_VECTOR (14 downto 0);
    signal aip1E_24high_uid434_sincosTest_o : STD_LOGIC_VECTOR (14 downto 0);
    signal aip1E_24high_uid434_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_24high_uid434_sincosTest_q : STD_LOGIC_VECTOR (13 downto 0);
    signal aip1E_24_uid435_sincosTest_q : STD_LOGIC_VECTOR (14 downto 0);
    signal xip1_24_uid436_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal xip1_24_uid436_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_24_uid437_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_24_uid437_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal aip1E_uid438_sincosTest_in : STD_LOGIC_VECTOR (12 downto 0);
    signal aip1E_uid438_sincosTest_b : STD_LOGIC_VECTOR (12 downto 0);
    signal xMSB_uid439_sincosTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid441_sincosTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid444_sincosTest_b : STD_LOGIC_VECTOR (28 downto 0);
    signal twoToMiSiYip_uid445_sincosTest_b : STD_LOGIC_VECTOR (28 downto 0);
    signal cstArcTan2Mi_24_uid446_sincosTest_q : STD_LOGIC_VECTOR (10 downto 0);
    signal xip1E_25_uid448_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_25_uid448_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_25_uid448_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_25_uid448_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_25_uid448_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal yip1E_25_uid449_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_25_uid449_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_25_uid449_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_25_uid449_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_25_uid449_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal lowRangeA_uid451_sincosTest_in : STD_LOGIC_VECTOR (0 downto 0);
    signal lowRangeA_uid451_sincosTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal highABits_uid452_sincosTest_b : STD_LOGIC_VECTOR (11 downto 0);
    signal aip1E_25high_uid453_sincosTest_a : STD_LOGIC_VECTOR (13 downto 0);
    signal aip1E_25high_uid453_sincosTest_b : STD_LOGIC_VECTOR (13 downto 0);
    signal aip1E_25high_uid453_sincosTest_o : STD_LOGIC_VECTOR (13 downto 0);
    signal aip1E_25high_uid453_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_25high_uid453_sincosTest_q : STD_LOGIC_VECTOR (12 downto 0);
    signal aip1E_25_uid454_sincosTest_q : STD_LOGIC_VECTOR (13 downto 0);
    signal xip1_25_uid455_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal xip1_25_uid455_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_25_uid456_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_25_uid456_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal aip1E_uid457_sincosTest_in : STD_LOGIC_VECTOR (11 downto 0);
    signal aip1E_uid457_sincosTest_b : STD_LOGIC_VECTOR (11 downto 0);
    signal xMSB_uid458_sincosTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid460_sincosTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid463_sincosTest_b : STD_LOGIC_VECTOR (27 downto 0);
    signal twoToMiSiYip_uid464_sincosTest_b : STD_LOGIC_VECTOR (27 downto 0);
    signal xip1E_26_uid467_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_26_uid467_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_26_uid467_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal xip1E_26_uid467_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_26_uid467_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal yip1E_26_uid468_sincosTest_a : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_26_uid468_sincosTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_26_uid468_sincosTest_o : STD_LOGIC_VECTOR (54 downto 0);
    signal yip1E_26_uid468_sincosTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_26_uid468_sincosTest_q : STD_LOGIC_VECTOR (53 downto 0);
    signal xip1_26_uid474_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal xip1_26_uid474_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_26_uid475_sincosTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal yip1_26_uid475_sincosTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal xSumPreRnd_uid477_sincosTest_in : STD_LOGIC_VECTOR (50 downto 0);
    signal xSumPreRnd_uid477_sincosTest_b : STD_LOGIC_VECTOR (25 downto 0);
    signal xSumPostRnd_uid480_sincosTest_a : STD_LOGIC_VECTOR (26 downto 0);
    signal xSumPostRnd_uid480_sincosTest_b : STD_LOGIC_VECTOR (26 downto 0);
    signal xSumPostRnd_uid480_sincosTest_o : STD_LOGIC_VECTOR (26 downto 0);
    signal xSumPostRnd_uid480_sincosTest_q : STD_LOGIC_VECTOR (26 downto 0);
    signal ySumPreRnd_uid481_sincosTest_in : STD_LOGIC_VECTOR (50 downto 0);
    signal ySumPreRnd_uid481_sincosTest_b : STD_LOGIC_VECTOR (25 downto 0);
    signal ySumPostRnd_uid484_sincosTest_a : STD_LOGIC_VECTOR (26 downto 0);
    signal ySumPostRnd_uid484_sincosTest_b : STD_LOGIC_VECTOR (26 downto 0);
    signal ySumPostRnd_uid484_sincosTest_o : STD_LOGIC_VECTOR (26 downto 0);
    signal ySumPostRnd_uid484_sincosTest_q : STD_LOGIC_VECTOR (26 downto 0);
    signal xPostExc_uid485_sincosTest_in : STD_LOGIC_VECTOR (25 downto 0);
    signal xPostExc_uid485_sincosTest_b : STD_LOGIC_VECTOR (24 downto 0);
    signal yPostExc_uid486_sincosTest_in : STD_LOGIC_VECTOR (25 downto 0);
    signal yPostExc_uid486_sincosTest_b : STD_LOGIC_VECTOR (24 downto 0);
    signal redist0_xMSB_uid458_sincosTest_b_15_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_yip1_25_uid456_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist2_xip1_25_uid455_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist3_xMSB_uid439_sincosTest_b_14_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_yip1_24_uid437_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist5_xip1_24_uid436_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist6_xMSB_uid420_sincosTest_b_13_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_yip1_23_uid418_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist8_xip1_23_uid417_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist9_xMSB_uid401_sincosTest_b_12_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist10_aip1E_uid400_sincosTest_b_1_q : STD_LOGIC_VECTOR (14 downto 0);
    signal redist11_yip1_22_uid399_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist12_xip1_22_uid398_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist13_xMSB_uid382_sincosTest_b_12_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist14_yip1_21_uid380_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist15_xip1_21_uid379_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist16_xMSB_uid363_sincosTest_b_11_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist17_yip1_20_uid361_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist18_xip1_20_uid360_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist19_xMSB_uid344_sincosTest_b_10_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist20_aip1E_uid343_sincosTest_b_1_q : STD_LOGIC_VECTOR (17 downto 0);
    signal redist21_yip1_19_uid342_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist22_xip1_19_uid341_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist23_xMSB_uid325_sincosTest_b_10_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist24_yip1_18_uid323_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist25_xip1_18_uid322_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist26_xMSB_uid306_sincosTest_b_9_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist27_yip1_17_uid304_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist28_xip1_17_uid303_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist29_xMSB_uid287_sincosTest_b_8_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist30_aip1E_uid286_sincosTest_b_1_q : STD_LOGIC_VECTOR (20 downto 0);
    signal redist31_yip1_16_uid285_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist32_xip1_16_uid284_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist33_xMSB_uid268_sincosTest_b_8_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist34_yip1_15_uid266_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist35_xip1_15_uid265_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist36_xMSB_uid249_sincosTest_b_7_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist37_aip1E_uid248_sincosTest_b_1_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist38_yip1_14_uid247_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist39_xip1_14_uid246_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist40_xMSB_uid230_sincosTest_b_7_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist41_yip1_13_uid228_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist42_xip1_13_uid227_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist43_xMSB_uid211_sincosTest_b_6_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist44_aip1E_uid210_sincosTest_b_1_q : STD_LOGIC_VECTOR (24 downto 0);
    signal redist45_yip1_12_uid209_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist46_xip1_12_uid208_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist47_xMSB_uid195_sincosTest_b_6_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist48_yip1_11_uid193_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist49_xip1_11_uid192_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist50_xMSB_uid179_sincosTest_b_5_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist51_aip1E_uid178_sincosTest_b_1_q : STD_LOGIC_VECTOR (26 downto 0);
    signal redist52_yip1_10_uid177_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist53_xip1_10_uid176_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist54_xMSB_uid163_sincosTest_b_5_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist55_yip1_9_uid161_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist56_xip1_9_uid160_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist57_xMSB_uid147_sincosTest_b_4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist58_aip1E_uid146_sincosTest_b_1_q : STD_LOGIC_VECTOR (28 downto 0);
    signal redist59_yip1_8_uid145_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist60_xip1_8_uid144_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist61_xMSB_uid131_sincosTest_b_4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist62_yip1_7_uid129_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist63_xip1_7_uid128_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist64_xMSB_uid115_sincosTest_b_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist65_aip1E_uid114_sincosTest_b_1_q : STD_LOGIC_VECTOR (30 downto 0);
    signal redist66_yip1_6_uid113_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist67_xip1_6_uid112_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist68_xMSB_uid99_sincosTest_b_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist69_yip1_5_uid97_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist70_xip1_5_uid96_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist71_xMSB_uid83_sincosTest_b_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist72_aip1E_uid82_sincosTest_b_1_q : STD_LOGIC_VECTOR (32 downto 0);
    signal redist73_yip1_4_uid81_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist74_xip1_4_uid80_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist75_xMSB_uid67_sincosTest_b_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist76_yip1_3_uid65_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist77_xip1_3_uid64_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist78_xMSB_uid51_sincosTest_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist79_aip1E_uid50_sincosTest_b_1_q : STD_LOGIC_VECTOR (34 downto 0);
    signal redist80_yip1_2_uid49_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist81_xip1_2_uid48_sincosTest_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist82_xMSB_uid35_sincosTest_b_1_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- xMSB_uid195_sincosTest(BITSELECT,194)@5
    xMSB_uid195_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid194_sincosTest_b(25 downto 25));

    -- cstArcTan2Mi_11_uid202_sincosTest(CONSTANT,201)
    cstArcTan2Mi_11_uid202_sincosTest_q <= "011111111111111111111111";

    -- xMSB_uid179_sincosTest(BITSELECT,178)@5
    xMSB_uid179_sincosTest_b <= STD_LOGIC_VECTOR(redist51_aip1E_uid178_sincosTest_b_1_q(26 downto 26));

    -- cstArcTan2Mi_10_uid186_sincosTest(CONSTANT,185)
    cstArcTan2Mi_10_uid186_sincosTest_q <= "0111111111111111111111011";

    -- xMSB_uid163_sincosTest(BITSELECT,162)@4
    xMSB_uid163_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid162_sincosTest_b(27 downto 27));

    -- cstArcTan2Mi_9_uid170_sincosTest(CONSTANT,169)
    cstArcTan2Mi_9_uid170_sincosTest_q <= "01111111111111111111010101";

    -- xMSB_uid147_sincosTest(BITSELECT,146)@4
    xMSB_uid147_sincosTest_b <= STD_LOGIC_VECTOR(redist58_aip1E_uid146_sincosTest_b_1_q(28 downto 28));

    -- cstArcTan2Mi_8_uid154_sincosTest(CONSTANT,153)
    cstArcTan2Mi_8_uid154_sincosTest_q <= "011111111111111111010101011";

    -- xMSB_uid131_sincosTest(BITSELECT,130)@3
    xMSB_uid131_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid130_sincosTest_b(29 downto 29));

    -- cstArcTan2Mi_7_uid138_sincosTest(CONSTANT,137)
    cstArcTan2Mi_7_uid138_sincosTest_q <= "0111111111111111010101010101";

    -- xMSB_uid115_sincosTest(BITSELECT,114)@3
    xMSB_uid115_sincosTest_b <= STD_LOGIC_VECTOR(redist65_aip1E_uid114_sincosTest_b_1_q(30 downto 30));

    -- cstArcTan2Mi_6_uid122_sincosTest(CONSTANT,121)
    cstArcTan2Mi_6_uid122_sincosTest_q <= "01111111111111010101010101110";

    -- xMSB_uid99_sincosTest(BITSELECT,98)@2
    xMSB_uid99_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid98_sincosTest_b(31 downto 31));

    -- cstArcTan2Mi_5_uid106_sincosTest(CONSTANT,105)
    cstArcTan2Mi_5_uid106_sincosTest_q <= "011111111111010101010110111100";

    -- xMSB_uid83_sincosTest(BITSELECT,82)@2
    xMSB_uid83_sincosTest_b <= STD_LOGIC_VECTOR(redist72_aip1E_uid82_sincosTest_b_1_q(32 downto 32));

    -- cstArcTan2Mi_4_uid90_sincosTest(CONSTANT,89)
    cstArcTan2Mi_4_uid90_sincosTest_q <= "0111111111010101011011101101110";

    -- xMSB_uid67_sincosTest(BITSELECT,66)@1
    xMSB_uid67_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid66_sincosTest_b(33 downto 33));

    -- cstArcTan2Mi_3_uid74_sincosTest(CONSTANT,73)
    cstArcTan2Mi_3_uid74_sincosTest_q <= "01111111010101101110101001101011";

    -- xMSB_uid51_sincosTest(BITSELECT,50)@1
    xMSB_uid51_sincosTest_b <= STD_LOGIC_VECTOR(redist79_aip1E_uid50_sincosTest_b_1_q(34 downto 34));

    -- cstArcTan2Mi_2_uid58_sincosTest(CONSTANT,57)
    cstArcTan2Mi_2_uid58_sincosTest_q <= "011111010110110111010111111001001";

    -- xMSB_uid35_sincosTest(BITSELECT,34)@0
    xMSB_uid35_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid34_sincosTest_b(35 downto 35));

    -- cstArcTan2Mi_1_uid42_sincosTest(CONSTANT,41)
    cstArcTan2Mi_1_uid42_sincosTest_q <= "0111011010110001100111000001010110";

    -- invSignOfSelectionSignal_uid20_sincosTest(LOGICAL,19)@0
    invSignOfSelectionSignal_uid20_sincosTest_q <= not (VCC_q);

    -- cstArcTan2Mi_0_uid10_sincosTest(CONSTANT,9)
    cstArcTan2Mi_0_uid10_sincosTest_q <= "01100100100001111110110101010001001";

    -- aip1E_1CostZeroPaddingA_uid21_sincosTest(CONSTANT,20)
    aip1E_1CostZeroPaddingA_uid21_sincosTest_q <= "0000000000";

    -- aip1E_1NA_uid22_sincosTest(BITJOIN,21)@0
    aip1E_1NA_uid22_sincosTest_q <= a & aip1E_1CostZeroPaddingA_uid21_sincosTest_q;

    -- aip1E_1sumAHighB_uid23_sincosTest(ADDSUB,22)@0
    aip1E_1sumAHighB_uid23_sincosTest_s <= invSignOfSelectionSignal_uid20_sincosTest_q;
    aip1E_1sumAHighB_uid23_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & aip1E_1NA_uid22_sincosTest_q));
    aip1E_1sumAHighB_uid23_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((37 downto 35 => cstArcTan2Mi_0_uid10_sincosTest_q(34)) & cstArcTan2Mi_0_uid10_sincosTest_q));
    aip1E_1sumAHighB_uid23_sincosTest_combproc: PROCESS (aip1E_1sumAHighB_uid23_sincosTest_a, aip1E_1sumAHighB_uid23_sincosTest_b, aip1E_1sumAHighB_uid23_sincosTest_s)
    BEGIN
        IF (aip1E_1sumAHighB_uid23_sincosTest_s = "1") THEN
            aip1E_1sumAHighB_uid23_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_1sumAHighB_uid23_sincosTest_a) + SIGNED(aip1E_1sumAHighB_uid23_sincosTest_b));
        ELSE
            aip1E_1sumAHighB_uid23_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_1sumAHighB_uid23_sincosTest_a) - SIGNED(aip1E_1sumAHighB_uid23_sincosTest_b));
        END IF;
    END PROCESS;
    aip1E_1sumAHighB_uid23_sincosTest_q <= aip1E_1sumAHighB_uid23_sincosTest_o(36 downto 0);

    -- aip1E_uid34_sincosTest(BITSELECT,33)@0
    aip1E_uid34_sincosTest_in <= STD_LOGIC_VECTOR(aip1E_1sumAHighB_uid23_sincosTest_q(35 downto 0));
    aip1E_uid34_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid34_sincosTest_in(35 downto 0));

    -- aip1E_2_uid47_sincosTest(ADDSUB,46)@0
    aip1E_2_uid47_sincosTest_s <= xMSB_uid35_sincosTest_b;
    aip1E_2_uid47_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((37 downto 36 => aip1E_uid34_sincosTest_b(35)) & aip1E_uid34_sincosTest_b));
    aip1E_2_uid47_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((37 downto 34 => cstArcTan2Mi_1_uid42_sincosTest_q(33)) & cstArcTan2Mi_1_uid42_sincosTest_q));
    aip1E_2_uid47_sincosTest_combproc: PROCESS (aip1E_2_uid47_sincosTest_a, aip1E_2_uid47_sincosTest_b, aip1E_2_uid47_sincosTest_s)
    BEGIN
        IF (aip1E_2_uid47_sincosTest_s = "1") THEN
            aip1E_2_uid47_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_2_uid47_sincosTest_a) + SIGNED(aip1E_2_uid47_sincosTest_b));
        ELSE
            aip1E_2_uid47_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_2_uid47_sincosTest_a) - SIGNED(aip1E_2_uid47_sincosTest_b));
        END IF;
    END PROCESS;
    aip1E_2_uid47_sincosTest_q <= aip1E_2_uid47_sincosTest_o(36 downto 0);

    -- aip1E_uid50_sincosTest(BITSELECT,49)@0
    aip1E_uid50_sincosTest_in <= STD_LOGIC_VECTOR(aip1E_2_uid47_sincosTest_q(34 downto 0));
    aip1E_uid50_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid50_sincosTest_in(34 downto 0));

    -- redist79_aip1E_uid50_sincosTest_b_1(DELAY,569)
    redist79_aip1E_uid50_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 35, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid50_sincosTest_b, xout => redist79_aip1E_uid50_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- aip1E_3_uid63_sincosTest(ADDSUB,62)@1
    aip1E_3_uid63_sincosTest_s <= xMSB_uid51_sincosTest_b;
    aip1E_3_uid63_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((36 downto 35 => redist79_aip1E_uid50_sincosTest_b_1_q(34)) & redist79_aip1E_uid50_sincosTest_b_1_q));
    aip1E_3_uid63_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((36 downto 33 => cstArcTan2Mi_2_uid58_sincosTest_q(32)) & cstArcTan2Mi_2_uid58_sincosTest_q));
    aip1E_3_uid63_sincosTest_combproc: PROCESS (aip1E_3_uid63_sincosTest_a, aip1E_3_uid63_sincosTest_b, aip1E_3_uid63_sincosTest_s)
    BEGIN
        IF (aip1E_3_uid63_sincosTest_s = "1") THEN
            aip1E_3_uid63_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_3_uid63_sincosTest_a) + SIGNED(aip1E_3_uid63_sincosTest_b));
        ELSE
            aip1E_3_uid63_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_3_uid63_sincosTest_a) - SIGNED(aip1E_3_uid63_sincosTest_b));
        END IF;
    END PROCESS;
    aip1E_3_uid63_sincosTest_q <= aip1E_3_uid63_sincosTest_o(35 downto 0);

    -- aip1E_uid66_sincosTest(BITSELECT,65)@1
    aip1E_uid66_sincosTest_in <= STD_LOGIC_VECTOR(aip1E_3_uid63_sincosTest_q(33 downto 0));
    aip1E_uid66_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid66_sincosTest_in(33 downto 0));

    -- aip1E_4_uid79_sincosTest(ADDSUB,78)@1
    aip1E_4_uid79_sincosTest_s <= xMSB_uid67_sincosTest_b;
    aip1E_4_uid79_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 34 => aip1E_uid66_sincosTest_b(33)) & aip1E_uid66_sincosTest_b));
    aip1E_4_uid79_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 32 => cstArcTan2Mi_3_uid74_sincosTest_q(31)) & cstArcTan2Mi_3_uid74_sincosTest_q));
    aip1E_4_uid79_sincosTest_combproc: PROCESS (aip1E_4_uid79_sincosTest_a, aip1E_4_uid79_sincosTest_b, aip1E_4_uid79_sincosTest_s)
    BEGIN
        IF (aip1E_4_uid79_sincosTest_s = "1") THEN
            aip1E_4_uid79_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_4_uid79_sincosTest_a) + SIGNED(aip1E_4_uid79_sincosTest_b));
        ELSE
            aip1E_4_uid79_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_4_uid79_sincosTest_a) - SIGNED(aip1E_4_uid79_sincosTest_b));
        END IF;
    END PROCESS;
    aip1E_4_uid79_sincosTest_q <= aip1E_4_uid79_sincosTest_o(34 downto 0);

    -- aip1E_uid82_sincosTest(BITSELECT,81)@1
    aip1E_uid82_sincosTest_in <= STD_LOGIC_VECTOR(aip1E_4_uid79_sincosTest_q(32 downto 0));
    aip1E_uid82_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid82_sincosTest_in(32 downto 0));

    -- redist72_aip1E_uid82_sincosTest_b_1(DELAY,562)
    redist72_aip1E_uid82_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 33, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid82_sincosTest_b, xout => redist72_aip1E_uid82_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- aip1E_5_uid95_sincosTest(ADDSUB,94)@2
    aip1E_5_uid95_sincosTest_s <= xMSB_uid83_sincosTest_b;
    aip1E_5_uid95_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((34 downto 33 => redist72_aip1E_uid82_sincosTest_b_1_q(32)) & redist72_aip1E_uid82_sincosTest_b_1_q));
    aip1E_5_uid95_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((34 downto 31 => cstArcTan2Mi_4_uid90_sincosTest_q(30)) & cstArcTan2Mi_4_uid90_sincosTest_q));
    aip1E_5_uid95_sincosTest_combproc: PROCESS (aip1E_5_uid95_sincosTest_a, aip1E_5_uid95_sincosTest_b, aip1E_5_uid95_sincosTest_s)
    BEGIN
        IF (aip1E_5_uid95_sincosTest_s = "1") THEN
            aip1E_5_uid95_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_5_uid95_sincosTest_a) + SIGNED(aip1E_5_uid95_sincosTest_b));
        ELSE
            aip1E_5_uid95_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_5_uid95_sincosTest_a) - SIGNED(aip1E_5_uid95_sincosTest_b));
        END IF;
    END PROCESS;
    aip1E_5_uid95_sincosTest_q <= aip1E_5_uid95_sincosTest_o(33 downto 0);

    -- aip1E_uid98_sincosTest(BITSELECT,97)@2
    aip1E_uid98_sincosTest_in <= STD_LOGIC_VECTOR(aip1E_5_uid95_sincosTest_q(31 downto 0));
    aip1E_uid98_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid98_sincosTest_in(31 downto 0));

    -- aip1E_6_uid111_sincosTest(ADDSUB,110)@2
    aip1E_6_uid111_sincosTest_s <= xMSB_uid99_sincosTest_b;
    aip1E_6_uid111_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 32 => aip1E_uid98_sincosTest_b(31)) & aip1E_uid98_sincosTest_b));
    aip1E_6_uid111_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 30 => cstArcTan2Mi_5_uid106_sincosTest_q(29)) & cstArcTan2Mi_5_uid106_sincosTest_q));
    aip1E_6_uid111_sincosTest_combproc: PROCESS (aip1E_6_uid111_sincosTest_a, aip1E_6_uid111_sincosTest_b, aip1E_6_uid111_sincosTest_s)
    BEGIN
        IF (aip1E_6_uid111_sincosTest_s = "1") THEN
            aip1E_6_uid111_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_6_uid111_sincosTest_a) + SIGNED(aip1E_6_uid111_sincosTest_b));
        ELSE
            aip1E_6_uid111_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_6_uid111_sincosTest_a) - SIGNED(aip1E_6_uid111_sincosTest_b));
        END IF;
    END PROCESS;
    aip1E_6_uid111_sincosTest_q <= aip1E_6_uid111_sincosTest_o(32 downto 0);

    -- aip1E_uid114_sincosTest(BITSELECT,113)@2
    aip1E_uid114_sincosTest_in <= STD_LOGIC_VECTOR(aip1E_6_uid111_sincosTest_q(30 downto 0));
    aip1E_uid114_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid114_sincosTest_in(30 downto 0));

    -- redist65_aip1E_uid114_sincosTest_b_1(DELAY,555)
    redist65_aip1E_uid114_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 31, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid114_sincosTest_b, xout => redist65_aip1E_uid114_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- aip1E_7_uid127_sincosTest(ADDSUB,126)@3
    aip1E_7_uid127_sincosTest_s <= xMSB_uid115_sincosTest_b;
    aip1E_7_uid127_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 31 => redist65_aip1E_uid114_sincosTest_b_1_q(30)) & redist65_aip1E_uid114_sincosTest_b_1_q));
    aip1E_7_uid127_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 29 => cstArcTan2Mi_6_uid122_sincosTest_q(28)) & cstArcTan2Mi_6_uid122_sincosTest_q));
    aip1E_7_uid127_sincosTest_combproc: PROCESS (aip1E_7_uid127_sincosTest_a, aip1E_7_uid127_sincosTest_b, aip1E_7_uid127_sincosTest_s)
    BEGIN
        IF (aip1E_7_uid127_sincosTest_s = "1") THEN
            aip1E_7_uid127_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_7_uid127_sincosTest_a) + SIGNED(aip1E_7_uid127_sincosTest_b));
        ELSE
            aip1E_7_uid127_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_7_uid127_sincosTest_a) - SIGNED(aip1E_7_uid127_sincosTest_b));
        END IF;
    END PROCESS;
    aip1E_7_uid127_sincosTest_q <= aip1E_7_uid127_sincosTest_o(31 downto 0);

    -- aip1E_uid130_sincosTest(BITSELECT,129)@3
    aip1E_uid130_sincosTest_in <= STD_LOGIC_VECTOR(aip1E_7_uid127_sincosTest_q(29 downto 0));
    aip1E_uid130_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid130_sincosTest_in(29 downto 0));

    -- aip1E_8_uid143_sincosTest(ADDSUB,142)@3
    aip1E_8_uid143_sincosTest_s <= xMSB_uid131_sincosTest_b;
    aip1E_8_uid143_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((31 downto 30 => aip1E_uid130_sincosTest_b(29)) & aip1E_uid130_sincosTest_b));
    aip1E_8_uid143_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((31 downto 28 => cstArcTan2Mi_7_uid138_sincosTest_q(27)) & cstArcTan2Mi_7_uid138_sincosTest_q));
    aip1E_8_uid143_sincosTest_combproc: PROCESS (aip1E_8_uid143_sincosTest_a, aip1E_8_uid143_sincosTest_b, aip1E_8_uid143_sincosTest_s)
    BEGIN
        IF (aip1E_8_uid143_sincosTest_s = "1") THEN
            aip1E_8_uid143_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_8_uid143_sincosTest_a) + SIGNED(aip1E_8_uid143_sincosTest_b));
        ELSE
            aip1E_8_uid143_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_8_uid143_sincosTest_a) - SIGNED(aip1E_8_uid143_sincosTest_b));
        END IF;
    END PROCESS;
    aip1E_8_uid143_sincosTest_q <= aip1E_8_uid143_sincosTest_o(30 downto 0);

    -- aip1E_uid146_sincosTest(BITSELECT,145)@3
    aip1E_uid146_sincosTest_in <= STD_LOGIC_VECTOR(aip1E_8_uid143_sincosTest_q(28 downto 0));
    aip1E_uid146_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid146_sincosTest_in(28 downto 0));

    -- redist58_aip1E_uid146_sincosTest_b_1(DELAY,548)
    redist58_aip1E_uid146_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 29, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid146_sincosTest_b, xout => redist58_aip1E_uid146_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- aip1E_9_uid159_sincosTest(ADDSUB,158)@4
    aip1E_9_uid159_sincosTest_s <= xMSB_uid147_sincosTest_b;
    aip1E_9_uid159_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 29 => redist58_aip1E_uid146_sincosTest_b_1_q(28)) & redist58_aip1E_uid146_sincosTest_b_1_q));
    aip1E_9_uid159_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 27 => cstArcTan2Mi_8_uid154_sincosTest_q(26)) & cstArcTan2Mi_8_uid154_sincosTest_q));
    aip1E_9_uid159_sincosTest_combproc: PROCESS (aip1E_9_uid159_sincosTest_a, aip1E_9_uid159_sincosTest_b, aip1E_9_uid159_sincosTest_s)
    BEGIN
        IF (aip1E_9_uid159_sincosTest_s = "1") THEN
            aip1E_9_uid159_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_9_uid159_sincosTest_a) + SIGNED(aip1E_9_uid159_sincosTest_b));
        ELSE
            aip1E_9_uid159_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_9_uid159_sincosTest_a) - SIGNED(aip1E_9_uid159_sincosTest_b));
        END IF;
    END PROCESS;
    aip1E_9_uid159_sincosTest_q <= aip1E_9_uid159_sincosTest_o(29 downto 0);

    -- aip1E_uid162_sincosTest(BITSELECT,161)@4
    aip1E_uid162_sincosTest_in <= STD_LOGIC_VECTOR(aip1E_9_uid159_sincosTest_q(27 downto 0));
    aip1E_uid162_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid162_sincosTest_in(27 downto 0));

    -- aip1E_10_uid175_sincosTest(ADDSUB,174)@4
    aip1E_10_uid175_sincosTest_s <= xMSB_uid163_sincosTest_b;
    aip1E_10_uid175_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 28 => aip1E_uid162_sincosTest_b(27)) & aip1E_uid162_sincosTest_b));
    aip1E_10_uid175_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 26 => cstArcTan2Mi_9_uid170_sincosTest_q(25)) & cstArcTan2Mi_9_uid170_sincosTest_q));
    aip1E_10_uid175_sincosTest_combproc: PROCESS (aip1E_10_uid175_sincosTest_a, aip1E_10_uid175_sincosTest_b, aip1E_10_uid175_sincosTest_s)
    BEGIN
        IF (aip1E_10_uid175_sincosTest_s = "1") THEN
            aip1E_10_uid175_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_10_uid175_sincosTest_a) + SIGNED(aip1E_10_uid175_sincosTest_b));
        ELSE
            aip1E_10_uid175_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_10_uid175_sincosTest_a) - SIGNED(aip1E_10_uid175_sincosTest_b));
        END IF;
    END PROCESS;
    aip1E_10_uid175_sincosTest_q <= aip1E_10_uid175_sincosTest_o(28 downto 0);

    -- aip1E_uid178_sincosTest(BITSELECT,177)@4
    aip1E_uid178_sincosTest_in <= STD_LOGIC_VECTOR(aip1E_10_uid175_sincosTest_q(26 downto 0));
    aip1E_uid178_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid178_sincosTest_in(26 downto 0));

    -- redist51_aip1E_uid178_sincosTest_b_1(DELAY,541)
    redist51_aip1E_uid178_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 27, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid178_sincosTest_b, xout => redist51_aip1E_uid178_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- aip1E_11_uid191_sincosTest(ADDSUB,190)@5
    aip1E_11_uid191_sincosTest_s <= xMSB_uid179_sincosTest_b;
    aip1E_11_uid191_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 27 => redist51_aip1E_uid178_sincosTest_b_1_q(26)) & redist51_aip1E_uid178_sincosTest_b_1_q));
    aip1E_11_uid191_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 25 => cstArcTan2Mi_10_uid186_sincosTest_q(24)) & cstArcTan2Mi_10_uid186_sincosTest_q));
    aip1E_11_uid191_sincosTest_combproc: PROCESS (aip1E_11_uid191_sincosTest_a, aip1E_11_uid191_sincosTest_b, aip1E_11_uid191_sincosTest_s)
    BEGIN
        IF (aip1E_11_uid191_sincosTest_s = "1") THEN
            aip1E_11_uid191_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_11_uid191_sincosTest_a) + SIGNED(aip1E_11_uid191_sincosTest_b));
        ELSE
            aip1E_11_uid191_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_11_uid191_sincosTest_a) - SIGNED(aip1E_11_uid191_sincosTest_b));
        END IF;
    END PROCESS;
    aip1E_11_uid191_sincosTest_q <= aip1E_11_uid191_sincosTest_o(27 downto 0);

    -- aip1E_uid194_sincosTest(BITSELECT,193)@5
    aip1E_uid194_sincosTest_in <= STD_LOGIC_VECTOR(aip1E_11_uid191_sincosTest_q(25 downto 0));
    aip1E_uid194_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid194_sincosTest_in(25 downto 0));

    -- aip1E_12_uid207_sincosTest(ADDSUB,206)@5
    aip1E_12_uid207_sincosTest_s <= xMSB_uid195_sincosTest_b;
    aip1E_12_uid207_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((27 downto 26 => aip1E_uid194_sincosTest_b(25)) & aip1E_uid194_sincosTest_b));
    aip1E_12_uid207_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((27 downto 24 => cstArcTan2Mi_11_uid202_sincosTest_q(23)) & cstArcTan2Mi_11_uid202_sincosTest_q));
    aip1E_12_uid207_sincosTest_combproc: PROCESS (aip1E_12_uid207_sincosTest_a, aip1E_12_uid207_sincosTest_b, aip1E_12_uid207_sincosTest_s)
    BEGIN
        IF (aip1E_12_uid207_sincosTest_s = "1") THEN
            aip1E_12_uid207_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_12_uid207_sincosTest_a) + SIGNED(aip1E_12_uid207_sincosTest_b));
        ELSE
            aip1E_12_uid207_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_12_uid207_sincosTest_a) - SIGNED(aip1E_12_uid207_sincosTest_b));
        END IF;
    END PROCESS;
    aip1E_12_uid207_sincosTest_q <= aip1E_12_uid207_sincosTest_o(26 downto 0);

    -- aip1E_uid210_sincosTest(BITSELECT,209)@5
    aip1E_uid210_sincosTest_in <= STD_LOGIC_VECTOR(aip1E_12_uid207_sincosTest_q(24 downto 0));
    aip1E_uid210_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid210_sincosTest_in(24 downto 0));

    -- redist44_aip1E_uid210_sincosTest_b_1(DELAY,534)
    redist44_aip1E_uid210_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 25, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid210_sincosTest_b, xout => redist44_aip1E_uid210_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- xMSB_uid211_sincosTest(BITSELECT,210)@6
    xMSB_uid211_sincosTest_b <= STD_LOGIC_VECTOR(redist44_aip1E_uid210_sincosTest_b_1_q(24 downto 24));

    -- cstArcTan2Mi_12_uid218_sincosTest(CONSTANT,217)
    cstArcTan2Mi_12_uid218_sincosTest_q <= "01000000000000000000000";

    -- highABits_uid224_sincosTest(BITSELECT,223)@6
    highABits_uid224_sincosTest_b <= STD_LOGIC_VECTOR(redist44_aip1E_uid210_sincosTest_b_1_q(24 downto 1));

    -- aip1E_13high_uid225_sincosTest(ADDSUB,224)@6
    aip1E_13high_uid225_sincosTest_s <= xMSB_uid211_sincosTest_b;
    aip1E_13high_uid225_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((25 downto 24 => highABits_uid224_sincosTest_b(23)) & highABits_uid224_sincosTest_b));
    aip1E_13high_uid225_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((25 downto 23 => cstArcTan2Mi_12_uid218_sincosTest_q(22)) & cstArcTan2Mi_12_uid218_sincosTest_q));
    aip1E_13high_uid225_sincosTest_combproc: PROCESS (aip1E_13high_uid225_sincosTest_a, aip1E_13high_uid225_sincosTest_b, aip1E_13high_uid225_sincosTest_s)
    BEGIN
        IF (aip1E_13high_uid225_sincosTest_s = "1") THEN
            aip1E_13high_uid225_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_13high_uid225_sincosTest_a) + SIGNED(aip1E_13high_uid225_sincosTest_b));
        ELSE
            aip1E_13high_uid225_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_13high_uid225_sincosTest_a) - SIGNED(aip1E_13high_uid225_sincosTest_b));
        END IF;
    END PROCESS;
    aip1E_13high_uid225_sincosTest_q <= aip1E_13high_uid225_sincosTest_o(24 downto 0);

    -- lowRangeA_uid223_sincosTest(BITSELECT,222)@6
    lowRangeA_uid223_sincosTest_in <= redist44_aip1E_uid210_sincosTest_b_1_q(0 downto 0);
    lowRangeA_uid223_sincosTest_b <= lowRangeA_uid223_sincosTest_in(0 downto 0);

    -- aip1E_13_uid226_sincosTest(BITJOIN,225)@6
    aip1E_13_uid226_sincosTest_q <= aip1E_13high_uid225_sincosTest_q & lowRangeA_uid223_sincosTest_b;

    -- aip1E_uid229_sincosTest(BITSELECT,228)@6
    aip1E_uid229_sincosTest_in <= STD_LOGIC_VECTOR(aip1E_13_uid226_sincosTest_q(23 downto 0));
    aip1E_uid229_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid229_sincosTest_in(23 downto 0));

    -- xMSB_uid230_sincosTest(BITSELECT,229)@6
    xMSB_uid230_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid229_sincosTest_b(23 downto 23));

    -- cstArcTan2Mi_13_uid237_sincosTest(CONSTANT,236)
    cstArcTan2Mi_13_uid237_sincosTest_q <= "0100000000000000000000";

    -- highABits_uid243_sincosTest(BITSELECT,242)@6
    highABits_uid243_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid229_sincosTest_b(23 downto 1));

    -- aip1E_14high_uid244_sincosTest(ADDSUB,243)@6
    aip1E_14high_uid244_sincosTest_s <= xMSB_uid230_sincosTest_b;
    aip1E_14high_uid244_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((24 downto 23 => highABits_uid243_sincosTest_b(22)) & highABits_uid243_sincosTest_b));
    aip1E_14high_uid244_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((24 downto 22 => cstArcTan2Mi_13_uid237_sincosTest_q(21)) & cstArcTan2Mi_13_uid237_sincosTest_q));
    aip1E_14high_uid244_sincosTest_combproc: PROCESS (aip1E_14high_uid244_sincosTest_a, aip1E_14high_uid244_sincosTest_b, aip1E_14high_uid244_sincosTest_s)
    BEGIN
        IF (aip1E_14high_uid244_sincosTest_s = "1") THEN
            aip1E_14high_uid244_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_14high_uid244_sincosTest_a) + SIGNED(aip1E_14high_uid244_sincosTest_b));
        ELSE
            aip1E_14high_uid244_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_14high_uid244_sincosTest_a) - SIGNED(aip1E_14high_uid244_sincosTest_b));
        END IF;
    END PROCESS;
    aip1E_14high_uid244_sincosTest_q <= aip1E_14high_uid244_sincosTest_o(23 downto 0);

    -- lowRangeA_uid242_sincosTest(BITSELECT,241)@6
    lowRangeA_uid242_sincosTest_in <= aip1E_uid229_sincosTest_b(0 downto 0);
    lowRangeA_uid242_sincosTest_b <= lowRangeA_uid242_sincosTest_in(0 downto 0);

    -- aip1E_14_uid245_sincosTest(BITJOIN,244)@6
    aip1E_14_uid245_sincosTest_q <= aip1E_14high_uid244_sincosTest_q & lowRangeA_uid242_sincosTest_b;

    -- aip1E_uid248_sincosTest(BITSELECT,247)@6
    aip1E_uid248_sincosTest_in <= STD_LOGIC_VECTOR(aip1E_14_uid245_sincosTest_q(22 downto 0));
    aip1E_uid248_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid248_sincosTest_in(22 downto 0));

    -- redist37_aip1E_uid248_sincosTest_b_1(DELAY,527)
    redist37_aip1E_uid248_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 23, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid248_sincosTest_b, xout => redist37_aip1E_uid248_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- xMSB_uid249_sincosTest(BITSELECT,248)@7
    xMSB_uid249_sincosTest_b <= STD_LOGIC_VECTOR(redist37_aip1E_uid248_sincosTest_b_1_q(22 downto 22));

    -- cstArcTan2Mi_14_uid256_sincosTest(CONSTANT,255)
    cstArcTan2Mi_14_uid256_sincosTest_q <= "010000000000000000000";

    -- highABits_uid262_sincosTest(BITSELECT,261)@7
    highABits_uid262_sincosTest_b <= STD_LOGIC_VECTOR(redist37_aip1E_uid248_sincosTest_b_1_q(22 downto 1));

    -- aip1E_15high_uid263_sincosTest(ADDSUB,262)@7
    aip1E_15high_uid263_sincosTest_s <= xMSB_uid249_sincosTest_b;
    aip1E_15high_uid263_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((23 downto 22 => highABits_uid262_sincosTest_b(21)) & highABits_uid262_sincosTest_b));
    aip1E_15high_uid263_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((23 downto 21 => cstArcTan2Mi_14_uid256_sincosTest_q(20)) & cstArcTan2Mi_14_uid256_sincosTest_q));
    aip1E_15high_uid263_sincosTest_combproc: PROCESS (aip1E_15high_uid263_sincosTest_a, aip1E_15high_uid263_sincosTest_b, aip1E_15high_uid263_sincosTest_s)
    BEGIN
        IF (aip1E_15high_uid263_sincosTest_s = "1") THEN
            aip1E_15high_uid263_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_15high_uid263_sincosTest_a) + SIGNED(aip1E_15high_uid263_sincosTest_b));
        ELSE
            aip1E_15high_uid263_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_15high_uid263_sincosTest_a) - SIGNED(aip1E_15high_uid263_sincosTest_b));
        END IF;
    END PROCESS;
    aip1E_15high_uid263_sincosTest_q <= aip1E_15high_uid263_sincosTest_o(22 downto 0);

    -- lowRangeA_uid261_sincosTest(BITSELECT,260)@7
    lowRangeA_uid261_sincosTest_in <= redist37_aip1E_uid248_sincosTest_b_1_q(0 downto 0);
    lowRangeA_uid261_sincosTest_b <= lowRangeA_uid261_sincosTest_in(0 downto 0);

    -- aip1E_15_uid264_sincosTest(BITJOIN,263)@7
    aip1E_15_uid264_sincosTest_q <= aip1E_15high_uid263_sincosTest_q & lowRangeA_uid261_sincosTest_b;

    -- aip1E_uid267_sincosTest(BITSELECT,266)@7
    aip1E_uid267_sincosTest_in <= STD_LOGIC_VECTOR(aip1E_15_uid264_sincosTest_q(21 downto 0));
    aip1E_uid267_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid267_sincosTest_in(21 downto 0));

    -- xMSB_uid268_sincosTest(BITSELECT,267)@7
    xMSB_uid268_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid267_sincosTest_b(21 downto 21));

    -- cstArcTan2Mi_15_uid275_sincosTest(CONSTANT,274)
    cstArcTan2Mi_15_uid275_sincosTest_q <= "01000000000000000000";

    -- highABits_uid281_sincosTest(BITSELECT,280)@7
    highABits_uid281_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid267_sincosTest_b(21 downto 1));

    -- aip1E_16high_uid282_sincosTest(ADDSUB,281)@7
    aip1E_16high_uid282_sincosTest_s <= xMSB_uid268_sincosTest_b;
    aip1E_16high_uid282_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((22 downto 21 => highABits_uid281_sincosTest_b(20)) & highABits_uid281_sincosTest_b));
    aip1E_16high_uid282_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((22 downto 20 => cstArcTan2Mi_15_uid275_sincosTest_q(19)) & cstArcTan2Mi_15_uid275_sincosTest_q));
    aip1E_16high_uid282_sincosTest_combproc: PROCESS (aip1E_16high_uid282_sincosTest_a, aip1E_16high_uid282_sincosTest_b, aip1E_16high_uid282_sincosTest_s)
    BEGIN
        IF (aip1E_16high_uid282_sincosTest_s = "1") THEN
            aip1E_16high_uid282_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_16high_uid282_sincosTest_a) + SIGNED(aip1E_16high_uid282_sincosTest_b));
        ELSE
            aip1E_16high_uid282_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_16high_uid282_sincosTest_a) - SIGNED(aip1E_16high_uid282_sincosTest_b));
        END IF;
    END PROCESS;
    aip1E_16high_uid282_sincosTest_q <= aip1E_16high_uid282_sincosTest_o(21 downto 0);

    -- lowRangeA_uid280_sincosTest(BITSELECT,279)@7
    lowRangeA_uid280_sincosTest_in <= aip1E_uid267_sincosTest_b(0 downto 0);
    lowRangeA_uid280_sincosTest_b <= lowRangeA_uid280_sincosTest_in(0 downto 0);

    -- aip1E_16_uid283_sincosTest(BITJOIN,282)@7
    aip1E_16_uid283_sincosTest_q <= aip1E_16high_uid282_sincosTest_q & lowRangeA_uid280_sincosTest_b;

    -- aip1E_uid286_sincosTest(BITSELECT,285)@7
    aip1E_uid286_sincosTest_in <= STD_LOGIC_VECTOR(aip1E_16_uid283_sincosTest_q(20 downto 0));
    aip1E_uid286_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid286_sincosTest_in(20 downto 0));

    -- redist30_aip1E_uid286_sincosTest_b_1(DELAY,520)
    redist30_aip1E_uid286_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 21, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid286_sincosTest_b, xout => redist30_aip1E_uid286_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- xMSB_uid287_sincosTest(BITSELECT,286)@8
    xMSB_uid287_sincosTest_b <= STD_LOGIC_VECTOR(redist30_aip1E_uid286_sincosTest_b_1_q(20 downto 20));

    -- cstArcTan2Mi_16_uid294_sincosTest(CONSTANT,293)
    cstArcTan2Mi_16_uid294_sincosTest_q <= "0100000000000000000";

    -- highABits_uid300_sincosTest(BITSELECT,299)@8
    highABits_uid300_sincosTest_b <= STD_LOGIC_VECTOR(redist30_aip1E_uid286_sincosTest_b_1_q(20 downto 1));

    -- aip1E_17high_uid301_sincosTest(ADDSUB,300)@8
    aip1E_17high_uid301_sincosTest_s <= xMSB_uid287_sincosTest_b;
    aip1E_17high_uid301_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((21 downto 20 => highABits_uid300_sincosTest_b(19)) & highABits_uid300_sincosTest_b));
    aip1E_17high_uid301_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((21 downto 19 => cstArcTan2Mi_16_uid294_sincosTest_q(18)) & cstArcTan2Mi_16_uid294_sincosTest_q));
    aip1E_17high_uid301_sincosTest_combproc: PROCESS (aip1E_17high_uid301_sincosTest_a, aip1E_17high_uid301_sincosTest_b, aip1E_17high_uid301_sincosTest_s)
    BEGIN
        IF (aip1E_17high_uid301_sincosTest_s = "1") THEN
            aip1E_17high_uid301_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_17high_uid301_sincosTest_a) + SIGNED(aip1E_17high_uid301_sincosTest_b));
        ELSE
            aip1E_17high_uid301_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_17high_uid301_sincosTest_a) - SIGNED(aip1E_17high_uid301_sincosTest_b));
        END IF;
    END PROCESS;
    aip1E_17high_uid301_sincosTest_q <= aip1E_17high_uid301_sincosTest_o(20 downto 0);

    -- lowRangeA_uid299_sincosTest(BITSELECT,298)@8
    lowRangeA_uid299_sincosTest_in <= redist30_aip1E_uid286_sincosTest_b_1_q(0 downto 0);
    lowRangeA_uid299_sincosTest_b <= lowRangeA_uid299_sincosTest_in(0 downto 0);

    -- aip1E_17_uid302_sincosTest(BITJOIN,301)@8
    aip1E_17_uid302_sincosTest_q <= aip1E_17high_uid301_sincosTest_q & lowRangeA_uid299_sincosTest_b;

    -- aip1E_uid305_sincosTest(BITSELECT,304)@8
    aip1E_uid305_sincosTest_in <= STD_LOGIC_VECTOR(aip1E_17_uid302_sincosTest_q(19 downto 0));
    aip1E_uid305_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid305_sincosTest_in(19 downto 0));

    -- xMSB_uid306_sincosTest(BITSELECT,305)@8
    xMSB_uid306_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid305_sincosTest_b(19 downto 19));

    -- cstArcTan2Mi_17_uid313_sincosTest(CONSTANT,312)
    cstArcTan2Mi_17_uid313_sincosTest_q <= "010000000000000000";

    -- highABits_uid319_sincosTest(BITSELECT,318)@8
    highABits_uid319_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid305_sincosTest_b(19 downto 1));

    -- aip1E_18high_uid320_sincosTest(ADDSUB,319)@8
    aip1E_18high_uid320_sincosTest_s <= xMSB_uid306_sincosTest_b;
    aip1E_18high_uid320_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((20 downto 19 => highABits_uid319_sincosTest_b(18)) & highABits_uid319_sincosTest_b));
    aip1E_18high_uid320_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((20 downto 18 => cstArcTan2Mi_17_uid313_sincosTest_q(17)) & cstArcTan2Mi_17_uid313_sincosTest_q));
    aip1E_18high_uid320_sincosTest_combproc: PROCESS (aip1E_18high_uid320_sincosTest_a, aip1E_18high_uid320_sincosTest_b, aip1E_18high_uid320_sincosTest_s)
    BEGIN
        IF (aip1E_18high_uid320_sincosTest_s = "1") THEN
            aip1E_18high_uid320_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_18high_uid320_sincosTest_a) + SIGNED(aip1E_18high_uid320_sincosTest_b));
        ELSE
            aip1E_18high_uid320_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_18high_uid320_sincosTest_a) - SIGNED(aip1E_18high_uid320_sincosTest_b));
        END IF;
    END PROCESS;
    aip1E_18high_uid320_sincosTest_q <= aip1E_18high_uid320_sincosTest_o(19 downto 0);

    -- lowRangeA_uid318_sincosTest(BITSELECT,317)@8
    lowRangeA_uid318_sincosTest_in <= aip1E_uid305_sincosTest_b(0 downto 0);
    lowRangeA_uid318_sincosTest_b <= lowRangeA_uid318_sincosTest_in(0 downto 0);

    -- aip1E_18_uid321_sincosTest(BITJOIN,320)@8
    aip1E_18_uid321_sincosTest_q <= aip1E_18high_uid320_sincosTest_q & lowRangeA_uid318_sincosTest_b;

    -- aip1E_uid324_sincosTest(BITSELECT,323)@8
    aip1E_uid324_sincosTest_in <= STD_LOGIC_VECTOR(aip1E_18_uid321_sincosTest_q(18 downto 0));
    aip1E_uid324_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid324_sincosTest_in(18 downto 0));

    -- xMSB_uid325_sincosTest(BITSELECT,324)@8
    xMSB_uid325_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid324_sincosTest_b(18 downto 18));

    -- cstArcTan2Mi_18_uid332_sincosTest(CONSTANT,331)
    cstArcTan2Mi_18_uid332_sincosTest_q <= "01000000000000000";

    -- highABits_uid338_sincosTest(BITSELECT,337)@8
    highABits_uid338_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid324_sincosTest_b(18 downto 1));

    -- aip1E_19high_uid339_sincosTest(ADDSUB,338)@8
    aip1E_19high_uid339_sincosTest_s <= xMSB_uid325_sincosTest_b;
    aip1E_19high_uid339_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((19 downto 18 => highABits_uid338_sincosTest_b(17)) & highABits_uid338_sincosTest_b));
    aip1E_19high_uid339_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((19 downto 17 => cstArcTan2Mi_18_uid332_sincosTest_q(16)) & cstArcTan2Mi_18_uid332_sincosTest_q));
    aip1E_19high_uid339_sincosTest_combproc: PROCESS (aip1E_19high_uid339_sincosTest_a, aip1E_19high_uid339_sincosTest_b, aip1E_19high_uid339_sincosTest_s)
    BEGIN
        IF (aip1E_19high_uid339_sincosTest_s = "1") THEN
            aip1E_19high_uid339_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_19high_uid339_sincosTest_a) + SIGNED(aip1E_19high_uid339_sincosTest_b));
        ELSE
            aip1E_19high_uid339_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_19high_uid339_sincosTest_a) - SIGNED(aip1E_19high_uid339_sincosTest_b));
        END IF;
    END PROCESS;
    aip1E_19high_uid339_sincosTest_q <= aip1E_19high_uid339_sincosTest_o(18 downto 0);

    -- lowRangeA_uid337_sincosTest(BITSELECT,336)@8
    lowRangeA_uid337_sincosTest_in <= aip1E_uid324_sincosTest_b(0 downto 0);
    lowRangeA_uid337_sincosTest_b <= lowRangeA_uid337_sincosTest_in(0 downto 0);

    -- aip1E_19_uid340_sincosTest(BITJOIN,339)@8
    aip1E_19_uid340_sincosTest_q <= aip1E_19high_uid339_sincosTest_q & lowRangeA_uid337_sincosTest_b;

    -- aip1E_uid343_sincosTest(BITSELECT,342)@8
    aip1E_uid343_sincosTest_in <= STD_LOGIC_VECTOR(aip1E_19_uid340_sincosTest_q(17 downto 0));
    aip1E_uid343_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid343_sincosTest_in(17 downto 0));

    -- redist20_aip1E_uid343_sincosTest_b_1(DELAY,510)
    redist20_aip1E_uid343_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 18, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid343_sincosTest_b, xout => redist20_aip1E_uid343_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- xMSB_uid344_sincosTest(BITSELECT,343)@9
    xMSB_uid344_sincosTest_b <= STD_LOGIC_VECTOR(redist20_aip1E_uid343_sincosTest_b_1_q(17 downto 17));

    -- cstArcTan2Mi_19_uid351_sincosTest(CONSTANT,350)
    cstArcTan2Mi_19_uid351_sincosTest_q <= "0100000000000000";

    -- highABits_uid357_sincosTest(BITSELECT,356)@9
    highABits_uid357_sincosTest_b <= STD_LOGIC_VECTOR(redist20_aip1E_uid343_sincosTest_b_1_q(17 downto 1));

    -- aip1E_20high_uid358_sincosTest(ADDSUB,357)@9
    aip1E_20high_uid358_sincosTest_s <= xMSB_uid344_sincosTest_b;
    aip1E_20high_uid358_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((18 downto 17 => highABits_uid357_sincosTest_b(16)) & highABits_uid357_sincosTest_b));
    aip1E_20high_uid358_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((18 downto 16 => cstArcTan2Mi_19_uid351_sincosTest_q(15)) & cstArcTan2Mi_19_uid351_sincosTest_q));
    aip1E_20high_uid358_sincosTest_combproc: PROCESS (aip1E_20high_uid358_sincosTest_a, aip1E_20high_uid358_sincosTest_b, aip1E_20high_uid358_sincosTest_s)
    BEGIN
        IF (aip1E_20high_uid358_sincosTest_s = "1") THEN
            aip1E_20high_uid358_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_20high_uid358_sincosTest_a) + SIGNED(aip1E_20high_uid358_sincosTest_b));
        ELSE
            aip1E_20high_uid358_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_20high_uid358_sincosTest_a) - SIGNED(aip1E_20high_uid358_sincosTest_b));
        END IF;
    END PROCESS;
    aip1E_20high_uid358_sincosTest_q <= aip1E_20high_uid358_sincosTest_o(17 downto 0);

    -- lowRangeA_uid356_sincosTest(BITSELECT,355)@9
    lowRangeA_uid356_sincosTest_in <= redist20_aip1E_uid343_sincosTest_b_1_q(0 downto 0);
    lowRangeA_uid356_sincosTest_b <= lowRangeA_uid356_sincosTest_in(0 downto 0);

    -- aip1E_20_uid359_sincosTest(BITJOIN,358)@9
    aip1E_20_uid359_sincosTest_q <= aip1E_20high_uid358_sincosTest_q & lowRangeA_uid356_sincosTest_b;

    -- aip1E_uid362_sincosTest(BITSELECT,361)@9
    aip1E_uid362_sincosTest_in <= STD_LOGIC_VECTOR(aip1E_20_uid359_sincosTest_q(16 downto 0));
    aip1E_uid362_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid362_sincosTest_in(16 downto 0));

    -- xMSB_uid363_sincosTest(BITSELECT,362)@9
    xMSB_uid363_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid362_sincosTest_b(16 downto 16));

    -- cstArcTan2Mi_20_uid370_sincosTest(CONSTANT,369)
    cstArcTan2Mi_20_uid370_sincosTest_q <= "010000000000000";

    -- highABits_uid376_sincosTest(BITSELECT,375)@9
    highABits_uid376_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid362_sincosTest_b(16 downto 1));

    -- aip1E_21high_uid377_sincosTest(ADDSUB,376)@9
    aip1E_21high_uid377_sincosTest_s <= xMSB_uid363_sincosTest_b;
    aip1E_21high_uid377_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((17 downto 16 => highABits_uid376_sincosTest_b(15)) & highABits_uid376_sincosTest_b));
    aip1E_21high_uid377_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((17 downto 15 => cstArcTan2Mi_20_uid370_sincosTest_q(14)) & cstArcTan2Mi_20_uid370_sincosTest_q));
    aip1E_21high_uid377_sincosTest_combproc: PROCESS (aip1E_21high_uid377_sincosTest_a, aip1E_21high_uid377_sincosTest_b, aip1E_21high_uid377_sincosTest_s)
    BEGIN
        IF (aip1E_21high_uid377_sincosTest_s = "1") THEN
            aip1E_21high_uid377_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_21high_uid377_sincosTest_a) + SIGNED(aip1E_21high_uid377_sincosTest_b));
        ELSE
            aip1E_21high_uid377_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_21high_uid377_sincosTest_a) - SIGNED(aip1E_21high_uid377_sincosTest_b));
        END IF;
    END PROCESS;
    aip1E_21high_uid377_sincosTest_q <= aip1E_21high_uid377_sincosTest_o(16 downto 0);

    -- lowRangeA_uid375_sincosTest(BITSELECT,374)@9
    lowRangeA_uid375_sincosTest_in <= aip1E_uid362_sincosTest_b(0 downto 0);
    lowRangeA_uid375_sincosTest_b <= lowRangeA_uid375_sincosTest_in(0 downto 0);

    -- aip1E_21_uid378_sincosTest(BITJOIN,377)@9
    aip1E_21_uid378_sincosTest_q <= aip1E_21high_uid377_sincosTest_q & lowRangeA_uid375_sincosTest_b;

    -- aip1E_uid381_sincosTest(BITSELECT,380)@9
    aip1E_uid381_sincosTest_in <= STD_LOGIC_VECTOR(aip1E_21_uid378_sincosTest_q(15 downto 0));
    aip1E_uid381_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid381_sincosTest_in(15 downto 0));

    -- xMSB_uid382_sincosTest(BITSELECT,381)@9
    xMSB_uid382_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid381_sincosTest_b(15 downto 15));

    -- cstArcTan2Mi_21_uid389_sincosTest(CONSTANT,388)
    cstArcTan2Mi_21_uid389_sincosTest_q <= "01000000000000";

    -- highABits_uid395_sincosTest(BITSELECT,394)@9
    highABits_uid395_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid381_sincosTest_b(15 downto 1));

    -- aip1E_22high_uid396_sincosTest(ADDSUB,395)@9
    aip1E_22high_uid396_sincosTest_s <= xMSB_uid382_sincosTest_b;
    aip1E_22high_uid396_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((16 downto 15 => highABits_uid395_sincosTest_b(14)) & highABits_uid395_sincosTest_b));
    aip1E_22high_uid396_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((16 downto 14 => cstArcTan2Mi_21_uid389_sincosTest_q(13)) & cstArcTan2Mi_21_uid389_sincosTest_q));
    aip1E_22high_uid396_sincosTest_combproc: PROCESS (aip1E_22high_uid396_sincosTest_a, aip1E_22high_uid396_sincosTest_b, aip1E_22high_uid396_sincosTest_s)
    BEGIN
        IF (aip1E_22high_uid396_sincosTest_s = "1") THEN
            aip1E_22high_uid396_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_22high_uid396_sincosTest_a) + SIGNED(aip1E_22high_uid396_sincosTest_b));
        ELSE
            aip1E_22high_uid396_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_22high_uid396_sincosTest_a) - SIGNED(aip1E_22high_uid396_sincosTest_b));
        END IF;
    END PROCESS;
    aip1E_22high_uid396_sincosTest_q <= aip1E_22high_uid396_sincosTest_o(15 downto 0);

    -- lowRangeA_uid394_sincosTest(BITSELECT,393)@9
    lowRangeA_uid394_sincosTest_in <= aip1E_uid381_sincosTest_b(0 downto 0);
    lowRangeA_uid394_sincosTest_b <= lowRangeA_uid394_sincosTest_in(0 downto 0);

    -- aip1E_22_uid397_sincosTest(BITJOIN,396)@9
    aip1E_22_uid397_sincosTest_q <= aip1E_22high_uid396_sincosTest_q & lowRangeA_uid394_sincosTest_b;

    -- aip1E_uid400_sincosTest(BITSELECT,399)@9
    aip1E_uid400_sincosTest_in <= STD_LOGIC_VECTOR(aip1E_22_uid397_sincosTest_q(14 downto 0));
    aip1E_uid400_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid400_sincosTest_in(14 downto 0));

    -- redist10_aip1E_uid400_sincosTest_b_1(DELAY,500)
    redist10_aip1E_uid400_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 15, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid400_sincosTest_b, xout => redist10_aip1E_uid400_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- xMSB_uid401_sincosTest(BITSELECT,400)@10
    xMSB_uid401_sincosTest_b <= STD_LOGIC_VECTOR(redist10_aip1E_uid400_sincosTest_b_1_q(14 downto 14));

    -- cstArcTan2Mi_22_uid408_sincosTest(CONSTANT,407)
    cstArcTan2Mi_22_uid408_sincosTest_q <= "0100000000000";

    -- highABits_uid414_sincosTest(BITSELECT,413)@10
    highABits_uid414_sincosTest_b <= STD_LOGIC_VECTOR(redist10_aip1E_uid400_sincosTest_b_1_q(14 downto 1));

    -- aip1E_23high_uid415_sincosTest(ADDSUB,414)@10
    aip1E_23high_uid415_sincosTest_s <= xMSB_uid401_sincosTest_b;
    aip1E_23high_uid415_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((15 downto 14 => highABits_uid414_sincosTest_b(13)) & highABits_uid414_sincosTest_b));
    aip1E_23high_uid415_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((15 downto 13 => cstArcTan2Mi_22_uid408_sincosTest_q(12)) & cstArcTan2Mi_22_uid408_sincosTest_q));
    aip1E_23high_uid415_sincosTest_combproc: PROCESS (aip1E_23high_uid415_sincosTest_a, aip1E_23high_uid415_sincosTest_b, aip1E_23high_uid415_sincosTest_s)
    BEGIN
        IF (aip1E_23high_uid415_sincosTest_s = "1") THEN
            aip1E_23high_uid415_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_23high_uid415_sincosTest_a) + SIGNED(aip1E_23high_uid415_sincosTest_b));
        ELSE
            aip1E_23high_uid415_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_23high_uid415_sincosTest_a) - SIGNED(aip1E_23high_uid415_sincosTest_b));
        END IF;
    END PROCESS;
    aip1E_23high_uid415_sincosTest_q <= aip1E_23high_uid415_sincosTest_o(14 downto 0);

    -- lowRangeA_uid413_sincosTest(BITSELECT,412)@10
    lowRangeA_uid413_sincosTest_in <= redist10_aip1E_uid400_sincosTest_b_1_q(0 downto 0);
    lowRangeA_uid413_sincosTest_b <= lowRangeA_uid413_sincosTest_in(0 downto 0);

    -- aip1E_23_uid416_sincosTest(BITJOIN,415)@10
    aip1E_23_uid416_sincosTest_q <= aip1E_23high_uid415_sincosTest_q & lowRangeA_uid413_sincosTest_b;

    -- aip1E_uid419_sincosTest(BITSELECT,418)@10
    aip1E_uid419_sincosTest_in <= STD_LOGIC_VECTOR(aip1E_23_uid416_sincosTest_q(13 downto 0));
    aip1E_uid419_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid419_sincosTest_in(13 downto 0));

    -- xMSB_uid420_sincosTest(BITSELECT,419)@10
    xMSB_uid420_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid419_sincosTest_b(13 downto 13));

    -- cstArcTan2Mi_23_uid427_sincosTest(CONSTANT,426)
    cstArcTan2Mi_23_uid427_sincosTest_q <= "010000000000";

    -- highABits_uid433_sincosTest(BITSELECT,432)@10
    highABits_uid433_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid419_sincosTest_b(13 downto 1));

    -- aip1E_24high_uid434_sincosTest(ADDSUB,433)@10
    aip1E_24high_uid434_sincosTest_s <= xMSB_uid420_sincosTest_b;
    aip1E_24high_uid434_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 13 => highABits_uid433_sincosTest_b(12)) & highABits_uid433_sincosTest_b));
    aip1E_24high_uid434_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 12 => cstArcTan2Mi_23_uid427_sincosTest_q(11)) & cstArcTan2Mi_23_uid427_sincosTest_q));
    aip1E_24high_uid434_sincosTest_combproc: PROCESS (aip1E_24high_uid434_sincosTest_a, aip1E_24high_uid434_sincosTest_b, aip1E_24high_uid434_sincosTest_s)
    BEGIN
        IF (aip1E_24high_uid434_sincosTest_s = "1") THEN
            aip1E_24high_uid434_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_24high_uid434_sincosTest_a) + SIGNED(aip1E_24high_uid434_sincosTest_b));
        ELSE
            aip1E_24high_uid434_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_24high_uid434_sincosTest_a) - SIGNED(aip1E_24high_uid434_sincosTest_b));
        END IF;
    END PROCESS;
    aip1E_24high_uid434_sincosTest_q <= aip1E_24high_uid434_sincosTest_o(13 downto 0);

    -- lowRangeA_uid432_sincosTest(BITSELECT,431)@10
    lowRangeA_uid432_sincosTest_in <= aip1E_uid419_sincosTest_b(0 downto 0);
    lowRangeA_uid432_sincosTest_b <= lowRangeA_uid432_sincosTest_in(0 downto 0);

    -- aip1E_24_uid435_sincosTest(BITJOIN,434)@10
    aip1E_24_uid435_sincosTest_q <= aip1E_24high_uid434_sincosTest_q & lowRangeA_uid432_sincosTest_b;

    -- aip1E_uid438_sincosTest(BITSELECT,437)@10
    aip1E_uid438_sincosTest_in <= STD_LOGIC_VECTOR(aip1E_24_uid435_sincosTest_q(12 downto 0));
    aip1E_uid438_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid438_sincosTest_in(12 downto 0));

    -- xMSB_uid439_sincosTest(BITSELECT,438)@10
    xMSB_uid439_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid438_sincosTest_b(12 downto 12));

    -- cstArcTan2Mi_24_uid446_sincosTest(CONSTANT,445)
    cstArcTan2Mi_24_uid446_sincosTest_q <= "01000000000";

    -- highABits_uid452_sincosTest(BITSELECT,451)@10
    highABits_uid452_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid438_sincosTest_b(12 downto 1));

    -- aip1E_25high_uid453_sincosTest(ADDSUB,452)@10
    aip1E_25high_uid453_sincosTest_s <= xMSB_uid439_sincosTest_b;
    aip1E_25high_uid453_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((13 downto 12 => highABits_uid452_sincosTest_b(11)) & highABits_uid452_sincosTest_b));
    aip1E_25high_uid453_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((13 downto 11 => cstArcTan2Mi_24_uid446_sincosTest_q(10)) & cstArcTan2Mi_24_uid446_sincosTest_q));
    aip1E_25high_uid453_sincosTest_combproc: PROCESS (aip1E_25high_uid453_sincosTest_a, aip1E_25high_uid453_sincosTest_b, aip1E_25high_uid453_sincosTest_s)
    BEGIN
        IF (aip1E_25high_uid453_sincosTest_s = "1") THEN
            aip1E_25high_uid453_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_25high_uid453_sincosTest_a) + SIGNED(aip1E_25high_uid453_sincosTest_b));
        ELSE
            aip1E_25high_uid453_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_25high_uid453_sincosTest_a) - SIGNED(aip1E_25high_uid453_sincosTest_b));
        END IF;
    END PROCESS;
    aip1E_25high_uid453_sincosTest_q <= aip1E_25high_uid453_sincosTest_o(12 downto 0);

    -- lowRangeA_uid451_sincosTest(BITSELECT,450)@10
    lowRangeA_uid451_sincosTest_in <= aip1E_uid438_sincosTest_b(0 downto 0);
    lowRangeA_uid451_sincosTest_b <= lowRangeA_uid451_sincosTest_in(0 downto 0);

    -- aip1E_25_uid454_sincosTest(BITJOIN,453)@10
    aip1E_25_uid454_sincosTest_q <= aip1E_25high_uid453_sincosTest_q & lowRangeA_uid451_sincosTest_b;

    -- aip1E_uid457_sincosTest(BITSELECT,456)@10
    aip1E_uid457_sincosTest_in <= STD_LOGIC_VECTOR(aip1E_25_uid454_sincosTest_q(11 downto 0));
    aip1E_uid457_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid457_sincosTest_in(11 downto 0));

    -- xMSB_uid458_sincosTest(BITSELECT,457)@10
    xMSB_uid458_sincosTest_b <= STD_LOGIC_VECTOR(aip1E_uid457_sincosTest_b(11 downto 11));

    -- redist0_xMSB_uid458_sincosTest_b_15(DELAY,490)
    redist0_xMSB_uid458_sincosTest_b_15 : dspba_delay
    GENERIC MAP ( width => 1, depth => 15, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid458_sincosTest_b, xout => redist0_xMSB_uid458_sincosTest_b_15_q, clk => clk, aclr => areset );

    -- signOfSelectionSignal_uid460_sincosTest(LOGICAL,459)@25
    signOfSelectionSignal_uid460_sincosTest_q <= not (redist0_xMSB_uid458_sincosTest_b_15_q);

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- redist3_xMSB_uid439_sincosTest_b_14(DELAY,493)
    redist3_xMSB_uid439_sincosTest_b_14 : dspba_delay
    GENERIC MAP ( width => 1, depth => 14, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid439_sincosTest_b, xout => redist3_xMSB_uid439_sincosTest_b_14_q, clk => clk, aclr => areset );

    -- redist6_xMSB_uid420_sincosTest_b_13(DELAY,496)
    redist6_xMSB_uid420_sincosTest_b_13 : dspba_delay
    GENERIC MAP ( width => 1, depth => 13, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid420_sincosTest_b, xout => redist6_xMSB_uid420_sincosTest_b_13_q, clk => clk, aclr => areset );

    -- signOfSelectionSignal_uid422_sincosTest(LOGICAL,421)@23
    signOfSelectionSignal_uid422_sincosTest_q <= not (redist6_xMSB_uid420_sincosTest_b_13_q);

    -- redist9_xMSB_uid401_sincosTest_b_12(DELAY,499)
    redist9_xMSB_uid401_sincosTest_b_12 : dspba_delay
    GENERIC MAP ( width => 1, depth => 12, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid401_sincosTest_b, xout => redist9_xMSB_uid401_sincosTest_b_12_q, clk => clk, aclr => areset );

    -- redist13_xMSB_uid382_sincosTest_b_12(DELAY,503)
    redist13_xMSB_uid382_sincosTest_b_12 : dspba_delay
    GENERIC MAP ( width => 1, depth => 12, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid382_sincosTest_b, xout => redist13_xMSB_uid382_sincosTest_b_12_q, clk => clk, aclr => areset );

    -- signOfSelectionSignal_uid384_sincosTest(LOGICAL,383)@21
    signOfSelectionSignal_uid384_sincosTest_q <= not (redist13_xMSB_uid382_sincosTest_b_12_q);

    -- redist16_xMSB_uid363_sincosTest_b_11(DELAY,506)
    redist16_xMSB_uid363_sincosTest_b_11 : dspba_delay
    GENERIC MAP ( width => 1, depth => 11, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid363_sincosTest_b, xout => redist16_xMSB_uid363_sincosTest_b_11_q, clk => clk, aclr => areset );

    -- redist19_xMSB_uid344_sincosTest_b_10(DELAY,509)
    redist19_xMSB_uid344_sincosTest_b_10 : dspba_delay
    GENERIC MAP ( width => 1, depth => 10, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid344_sincosTest_b, xout => redist19_xMSB_uid344_sincosTest_b_10_q, clk => clk, aclr => areset );

    -- signOfSelectionSignal_uid346_sincosTest(LOGICAL,345)@19
    signOfSelectionSignal_uid346_sincosTest_q <= not (redist19_xMSB_uid344_sincosTest_b_10_q);

    -- redist23_xMSB_uid325_sincosTest_b_10(DELAY,513)
    redist23_xMSB_uid325_sincosTest_b_10 : dspba_delay
    GENERIC MAP ( width => 1, depth => 10, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid325_sincosTest_b, xout => redist23_xMSB_uid325_sincosTest_b_10_q, clk => clk, aclr => areset );

    -- redist26_xMSB_uid306_sincosTest_b_9(DELAY,516)
    redist26_xMSB_uid306_sincosTest_b_9 : dspba_delay
    GENERIC MAP ( width => 1, depth => 9, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid306_sincosTest_b, xout => redist26_xMSB_uid306_sincosTest_b_9_q, clk => clk, aclr => areset );

    -- signOfSelectionSignal_uid308_sincosTest(LOGICAL,307)@17
    signOfSelectionSignal_uid308_sincosTest_q <= not (redist26_xMSB_uid306_sincosTest_b_9_q);

    -- redist29_xMSB_uid287_sincosTest_b_8(DELAY,519)
    redist29_xMSB_uid287_sincosTest_b_8 : dspba_delay
    GENERIC MAP ( width => 1, depth => 8, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid287_sincosTest_b, xout => redist29_xMSB_uid287_sincosTest_b_8_q, clk => clk, aclr => areset );

    -- redist33_xMSB_uid268_sincosTest_b_8(DELAY,523)
    redist33_xMSB_uid268_sincosTest_b_8 : dspba_delay
    GENERIC MAP ( width => 1, depth => 8, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid268_sincosTest_b, xout => redist33_xMSB_uid268_sincosTest_b_8_q, clk => clk, aclr => areset );

    -- signOfSelectionSignal_uid270_sincosTest(LOGICAL,269)@15
    signOfSelectionSignal_uid270_sincosTest_q <= not (redist33_xMSB_uid268_sincosTest_b_8_q);

    -- redist36_xMSB_uid249_sincosTest_b_7(DELAY,526)
    redist36_xMSB_uid249_sincosTest_b_7 : dspba_delay
    GENERIC MAP ( width => 1, depth => 7, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid249_sincosTest_b, xout => redist36_xMSB_uid249_sincosTest_b_7_q, clk => clk, aclr => areset );

    -- redist40_xMSB_uid230_sincosTest_b_7(DELAY,530)
    redist40_xMSB_uid230_sincosTest_b_7 : dspba_delay
    GENERIC MAP ( width => 1, depth => 7, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid230_sincosTest_b, xout => redist40_xMSB_uid230_sincosTest_b_7_q, clk => clk, aclr => areset );

    -- signOfSelectionSignal_uid232_sincosTest(LOGICAL,231)@13
    signOfSelectionSignal_uid232_sincosTest_q <= not (redist40_xMSB_uid230_sincosTest_b_7_q);

    -- redist43_xMSB_uid211_sincosTest_b_6(DELAY,533)
    redist43_xMSB_uid211_sincosTest_b_6 : dspba_delay
    GENERIC MAP ( width => 1, depth => 6, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid211_sincosTest_b, xout => redist43_xMSB_uid211_sincosTest_b_6_q, clk => clk, aclr => areset );

    -- redist47_xMSB_uid195_sincosTest_b_6(DELAY,537)
    redist47_xMSB_uid195_sincosTest_b_6 : dspba_delay
    GENERIC MAP ( width => 1, depth => 6, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid195_sincosTest_b, xout => redist47_xMSB_uid195_sincosTest_b_6_q, clk => clk, aclr => areset );

    -- signOfSelectionSignal_uid197_sincosTest(LOGICAL,196)@11
    signOfSelectionSignal_uid197_sincosTest_q <= not (redist47_xMSB_uid195_sincosTest_b_6_q);

    -- redist50_xMSB_uid179_sincosTest_b_5(DELAY,540)
    redist50_xMSB_uid179_sincosTest_b_5 : dspba_delay
    GENERIC MAP ( width => 1, depth => 5, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid179_sincosTest_b, xout => redist50_xMSB_uid179_sincosTest_b_5_q, clk => clk, aclr => areset );

    -- redist54_xMSB_uid163_sincosTest_b_5(DELAY,544)
    redist54_xMSB_uid163_sincosTest_b_5 : dspba_delay
    GENERIC MAP ( width => 1, depth => 5, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid163_sincosTest_b, xout => redist54_xMSB_uid163_sincosTest_b_5_q, clk => clk, aclr => areset );

    -- signOfSelectionSignal_uid165_sincosTest(LOGICAL,164)@9
    signOfSelectionSignal_uid165_sincosTest_q <= not (redist54_xMSB_uid163_sincosTest_b_5_q);

    -- redist57_xMSB_uid147_sincosTest_b_4(DELAY,547)
    redist57_xMSB_uid147_sincosTest_b_4 : dspba_delay
    GENERIC MAP ( width => 1, depth => 4, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid147_sincosTest_b, xout => redist57_xMSB_uid147_sincosTest_b_4_q, clk => clk, aclr => areset );

    -- redist61_xMSB_uid131_sincosTest_b_4(DELAY,551)
    redist61_xMSB_uid131_sincosTest_b_4 : dspba_delay
    GENERIC MAP ( width => 1, depth => 4, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid131_sincosTest_b, xout => redist61_xMSB_uid131_sincosTest_b_4_q, clk => clk, aclr => areset );

    -- signOfSelectionSignal_uid133_sincosTest(LOGICAL,132)@7
    signOfSelectionSignal_uid133_sincosTest_q <= not (redist61_xMSB_uid131_sincosTest_b_4_q);

    -- redist64_xMSB_uid115_sincosTest_b_3(DELAY,554)
    redist64_xMSB_uid115_sincosTest_b_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid115_sincosTest_b, xout => redist64_xMSB_uid115_sincosTest_b_3_q, clk => clk, aclr => areset );

    -- redist68_xMSB_uid99_sincosTest_b_3(DELAY,558)
    redist68_xMSB_uid99_sincosTest_b_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid99_sincosTest_b, xout => redist68_xMSB_uid99_sincosTest_b_3_q, clk => clk, aclr => areset );

    -- signOfSelectionSignal_uid101_sincosTest(LOGICAL,100)@5
    signOfSelectionSignal_uid101_sincosTest_q <= not (redist68_xMSB_uid99_sincosTest_b_3_q);

    -- redist71_xMSB_uid83_sincosTest_b_2(DELAY,561)
    redist71_xMSB_uid83_sincosTest_b_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid83_sincosTest_b, xout => redist71_xMSB_uid83_sincosTest_b_2_q, clk => clk, aclr => areset );

    -- redist75_xMSB_uid67_sincosTest_b_2(DELAY,565)
    redist75_xMSB_uid67_sincosTest_b_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid67_sincosTest_b, xout => redist75_xMSB_uid67_sincosTest_b_2_q, clk => clk, aclr => areset );

    -- signOfSelectionSignal_uid69_sincosTest(LOGICAL,68)@3
    signOfSelectionSignal_uid69_sincosTest_q <= not (redist75_xMSB_uid67_sincosTest_b_2_q);

    -- redist78_xMSB_uid51_sincosTest_b_1(DELAY,568)
    redist78_xMSB_uid51_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid51_sincosTest_b, xout => redist78_xMSB_uid51_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- redist82_xMSB_uid35_sincosTest_b_1(DELAY,572)
    redist82_xMSB_uid35_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid35_sincosTest_b, xout => redist82_xMSB_uid35_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- signOfSelectionSignal_uid37_sincosTest(LOGICAL,36)@1
    signOfSelectionSignal_uid37_sincosTest_q <= not (redist82_xMSB_uid35_sincosTest_b_1_q);

    -- cstOneOverK_uid6_sincosTest(CONSTANT,5)
    cstOneOverK_uid6_sincosTest_q <= "10011011011101001110110110101000010000110101111000";

    -- xip1E_1_uid16_sincosTest(BITJOIN,15)@1
    xip1E_1_uid16_sincosTest_q <= STD_LOGIC_VECTOR((2 downto 1 => GND_q(0)) & GND_q) & cstOneOverK_uid6_sincosTest_q;

    -- xip1_1_topRange_uid25_sincosTest(BITSELECT,24)@1
    xip1_1_topRange_uid25_sincosTest_in <= xip1E_1_uid16_sincosTest_q(51 downto 0);
    xip1_1_topRange_uid25_sincosTest_b <= xip1_1_topRange_uid25_sincosTest_in(51 downto 0);

    -- xip1_1_mergedSignalTM_uid26_sincosTest(BITJOIN,25)@1
    xip1_1_mergedSignalTM_uid26_sincosTest_q <= GND_q & xip1_1_topRange_uid25_sincosTest_b;

    -- twoToMiSiXip_uid40_sincosTest(BITSELECT,39)@1
    twoToMiSiXip_uid40_sincosTest_b <= STD_LOGIC_VECTOR(xip1_1_mergedSignalTM_uid26_sincosTest_q(52 downto 1));

    -- xMSB_uid28_sincosTest(BITSELECT,27)@1
    xMSB_uid28_sincosTest_b <= STD_LOGIC_VECTOR(yip1E_1sumAHighB_uid19_sincosTest_q(51 downto 51));

    -- yip1E_1CostZeroPaddingA_uid17_sincosTest(CONSTANT,16)
    yip1E_1CostZeroPaddingA_uid17_sincosTest_q <= "00000000000000000000000000000000000000000000000000";

    -- yip1E_1NA_uid18_sincosTest(BITJOIN,17)@0
    yip1E_1NA_uid18_sincosTest_q <= GND_q & yip1E_1CostZeroPaddingA_uid17_sincosTest_q;

    -- yip1E_1sumAHighB_uid19_sincosTest(ADDSUB,18)@0 + 1
    yip1E_1sumAHighB_uid19_sincosTest_s <= VCC_q;
    yip1E_1sumAHighB_uid19_sincosTest_a <= STD_LOGIC_VECTOR("00" & yip1E_1NA_uid18_sincosTest_q);
    yip1E_1sumAHighB_uid19_sincosTest_b <= STD_LOGIC_VECTOR("000" & cstOneOverK_uid6_sincosTest_q);
    yip1E_1sumAHighB_uid19_sincosTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            yip1E_1sumAHighB_uid19_sincosTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (yip1E_1sumAHighB_uid19_sincosTest_s = "1") THEN
                yip1E_1sumAHighB_uid19_sincosTest_o <= STD_LOGIC_VECTOR(UNSIGNED(yip1E_1sumAHighB_uid19_sincosTest_a) + UNSIGNED(yip1E_1sumAHighB_uid19_sincosTest_b));
            ELSE
                yip1E_1sumAHighB_uid19_sincosTest_o <= STD_LOGIC_VECTOR(UNSIGNED(yip1E_1sumAHighB_uid19_sincosTest_a) - UNSIGNED(yip1E_1sumAHighB_uid19_sincosTest_b));
            END IF;
        END IF;
    END PROCESS;
    yip1E_1sumAHighB_uid19_sincosTest_q <= yip1E_1sumAHighB_uid19_sincosTest_o(51 downto 0);

    -- yip1_1_mergedSignalTM_uid32_sincosTest(BITJOIN,31)@1
    yip1_1_mergedSignalTM_uid32_sincosTest_q <= xMSB_uid28_sincosTest_b & yip1E_1sumAHighB_uid19_sincosTest_q;

    -- yip1E_2_uid45_sincosTest(ADDSUB,44)@1
    yip1E_2_uid45_sincosTest_s <= signOfSelectionSignal_uid37_sincosTest_q;
    yip1E_2_uid45_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => yip1_1_mergedSignalTM_uid32_sincosTest_q(52)) & yip1_1_mergedSignalTM_uid32_sincosTest_q));
    yip1E_2_uid45_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 52 => twoToMiSiXip_uid40_sincosTest_b(51)) & twoToMiSiXip_uid40_sincosTest_b));
    yip1E_2_uid45_sincosTest_combproc: PROCESS (yip1E_2_uid45_sincosTest_a, yip1E_2_uid45_sincosTest_b, yip1E_2_uid45_sincosTest_s)
    BEGIN
        IF (yip1E_2_uid45_sincosTest_s = "1") THEN
            yip1E_2_uid45_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_2_uid45_sincosTest_a) + SIGNED(yip1E_2_uid45_sincosTest_b));
        ELSE
            yip1E_2_uid45_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_2_uid45_sincosTest_a) - SIGNED(yip1E_2_uid45_sincosTest_b));
        END IF;
    END PROCESS;
    yip1E_2_uid45_sincosTest_q <= yip1E_2_uid45_sincosTest_o(53 downto 0);

    -- yip1_2_uid49_sincosTest(BITSELECT,48)@1
    yip1_2_uid49_sincosTest_in <= STD_LOGIC_VECTOR(yip1E_2_uid45_sincosTest_q(52 downto 0));
    yip1_2_uid49_sincosTest_b <= STD_LOGIC_VECTOR(yip1_2_uid49_sincosTest_in(52 downto 0));

    -- redist80_yip1_2_uid49_sincosTest_b_1(DELAY,570)
    redist80_yip1_2_uid49_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_2_uid49_sincosTest_b, xout => redist80_yip1_2_uid49_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- twoToMiSiYip_uid57_sincosTest(BITSELECT,56)@2
    twoToMiSiYip_uid57_sincosTest_b <= STD_LOGIC_VECTOR(redist80_yip1_2_uid49_sincosTest_b_1_q(52 downto 2));

    -- twoToMiSiYip_uid41_sincosTest(BITSELECT,40)@1
    twoToMiSiYip_uid41_sincosTest_b <= STD_LOGIC_VECTOR(yip1_1_mergedSignalTM_uid32_sincosTest_q(52 downto 1));

    -- xip1E_2_uid44_sincosTest(ADDSUB,43)@1
    xip1E_2_uid44_sincosTest_s <= redist82_xMSB_uid35_sincosTest_b_1_q;
    xip1E_2_uid44_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => xip1_1_mergedSignalTM_uid26_sincosTest_q(52)) & xip1_1_mergedSignalTM_uid26_sincosTest_q));
    xip1E_2_uid44_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 52 => twoToMiSiYip_uid41_sincosTest_b(51)) & twoToMiSiYip_uid41_sincosTest_b));
    xip1E_2_uid44_sincosTest_combproc: PROCESS (xip1E_2_uid44_sincosTest_a, xip1E_2_uid44_sincosTest_b, xip1E_2_uid44_sincosTest_s)
    BEGIN
        IF (xip1E_2_uid44_sincosTest_s = "1") THEN
            xip1E_2_uid44_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_2_uid44_sincosTest_a) + SIGNED(xip1E_2_uid44_sincosTest_b));
        ELSE
            xip1E_2_uid44_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_2_uid44_sincosTest_a) - SIGNED(xip1E_2_uid44_sincosTest_b));
        END IF;
    END PROCESS;
    xip1E_2_uid44_sincosTest_q <= xip1E_2_uid44_sincosTest_o(53 downto 0);

    -- xip1_2_uid48_sincosTest(BITSELECT,47)@1
    xip1_2_uid48_sincosTest_in <= STD_LOGIC_VECTOR(xip1E_2_uid44_sincosTest_q(52 downto 0));
    xip1_2_uid48_sincosTest_b <= STD_LOGIC_VECTOR(xip1_2_uid48_sincosTest_in(52 downto 0));

    -- redist81_xip1_2_uid48_sincosTest_b_1(DELAY,571)
    redist81_xip1_2_uid48_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_2_uid48_sincosTest_b, xout => redist81_xip1_2_uid48_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- xip1E_3_uid60_sincosTest(ADDSUB,59)@2
    xip1E_3_uid60_sincosTest_s <= redist78_xMSB_uid51_sincosTest_b_1_q;
    xip1E_3_uid60_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist81_xip1_2_uid48_sincosTest_b_1_q(52)) & redist81_xip1_2_uid48_sincosTest_b_1_q));
    xip1E_3_uid60_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 51 => twoToMiSiYip_uid57_sincosTest_b(50)) & twoToMiSiYip_uid57_sincosTest_b));
    xip1E_3_uid60_sincosTest_combproc: PROCESS (xip1E_3_uid60_sincosTest_a, xip1E_3_uid60_sincosTest_b, xip1E_3_uid60_sincosTest_s)
    BEGIN
        IF (xip1E_3_uid60_sincosTest_s = "1") THEN
            xip1E_3_uid60_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_3_uid60_sincosTest_a) + SIGNED(xip1E_3_uid60_sincosTest_b));
        ELSE
            xip1E_3_uid60_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_3_uid60_sincosTest_a) - SIGNED(xip1E_3_uid60_sincosTest_b));
        END IF;
    END PROCESS;
    xip1E_3_uid60_sincosTest_q <= xip1E_3_uid60_sincosTest_o(53 downto 0);

    -- xip1_3_uid64_sincosTest(BITSELECT,63)@2
    xip1_3_uid64_sincosTest_in <= STD_LOGIC_VECTOR(xip1E_3_uid60_sincosTest_q(52 downto 0));
    xip1_3_uid64_sincosTest_b <= STD_LOGIC_VECTOR(xip1_3_uid64_sincosTest_in(52 downto 0));

    -- redist77_xip1_3_uid64_sincosTest_b_1(DELAY,567)
    redist77_xip1_3_uid64_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_3_uid64_sincosTest_b, xout => redist77_xip1_3_uid64_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- twoToMiSiXip_uid72_sincosTest(BITSELECT,71)@3
    twoToMiSiXip_uid72_sincosTest_b <= STD_LOGIC_VECTOR(redist77_xip1_3_uid64_sincosTest_b_1_q(52 downto 3));

    -- signOfSelectionSignal_uid53_sincosTest(LOGICAL,52)@2
    signOfSelectionSignal_uid53_sincosTest_q <= not (redist78_xMSB_uid51_sincosTest_b_1_q);

    -- twoToMiSiXip_uid56_sincosTest(BITSELECT,55)@2
    twoToMiSiXip_uid56_sincosTest_b <= STD_LOGIC_VECTOR(redist81_xip1_2_uid48_sincosTest_b_1_q(52 downto 2));

    -- yip1E_3_uid61_sincosTest(ADDSUB,60)@2
    yip1E_3_uid61_sincosTest_s <= signOfSelectionSignal_uid53_sincosTest_q;
    yip1E_3_uid61_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist80_yip1_2_uid49_sincosTest_b_1_q(52)) & redist80_yip1_2_uid49_sincosTest_b_1_q));
    yip1E_3_uid61_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 51 => twoToMiSiXip_uid56_sincosTest_b(50)) & twoToMiSiXip_uid56_sincosTest_b));
    yip1E_3_uid61_sincosTest_combproc: PROCESS (yip1E_3_uid61_sincosTest_a, yip1E_3_uid61_sincosTest_b, yip1E_3_uid61_sincosTest_s)
    BEGIN
        IF (yip1E_3_uid61_sincosTest_s = "1") THEN
            yip1E_3_uid61_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_3_uid61_sincosTest_a) + SIGNED(yip1E_3_uid61_sincosTest_b));
        ELSE
            yip1E_3_uid61_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_3_uid61_sincosTest_a) - SIGNED(yip1E_3_uid61_sincosTest_b));
        END IF;
    END PROCESS;
    yip1E_3_uid61_sincosTest_q <= yip1E_3_uid61_sincosTest_o(53 downto 0);

    -- yip1_3_uid65_sincosTest(BITSELECT,64)@2
    yip1_3_uid65_sincosTest_in <= STD_LOGIC_VECTOR(yip1E_3_uid61_sincosTest_q(52 downto 0));
    yip1_3_uid65_sincosTest_b <= STD_LOGIC_VECTOR(yip1_3_uid65_sincosTest_in(52 downto 0));

    -- redist76_yip1_3_uid65_sincosTest_b_1(DELAY,566)
    redist76_yip1_3_uid65_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_3_uid65_sincosTest_b, xout => redist76_yip1_3_uid65_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- yip1E_4_uid77_sincosTest(ADDSUB,76)@3
    yip1E_4_uid77_sincosTest_s <= signOfSelectionSignal_uid69_sincosTest_q;
    yip1E_4_uid77_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist76_yip1_3_uid65_sincosTest_b_1_q(52)) & redist76_yip1_3_uid65_sincosTest_b_1_q));
    yip1E_4_uid77_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 50 => twoToMiSiXip_uid72_sincosTest_b(49)) & twoToMiSiXip_uid72_sincosTest_b));
    yip1E_4_uid77_sincosTest_combproc: PROCESS (yip1E_4_uid77_sincosTest_a, yip1E_4_uid77_sincosTest_b, yip1E_4_uid77_sincosTest_s)
    BEGIN
        IF (yip1E_4_uid77_sincosTest_s = "1") THEN
            yip1E_4_uid77_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_4_uid77_sincosTest_a) + SIGNED(yip1E_4_uid77_sincosTest_b));
        ELSE
            yip1E_4_uid77_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_4_uid77_sincosTest_a) - SIGNED(yip1E_4_uid77_sincosTest_b));
        END IF;
    END PROCESS;
    yip1E_4_uid77_sincosTest_q <= yip1E_4_uid77_sincosTest_o(53 downto 0);

    -- yip1_4_uid81_sincosTest(BITSELECT,80)@3
    yip1_4_uid81_sincosTest_in <= STD_LOGIC_VECTOR(yip1E_4_uid77_sincosTest_q(52 downto 0));
    yip1_4_uid81_sincosTest_b <= STD_LOGIC_VECTOR(yip1_4_uid81_sincosTest_in(52 downto 0));

    -- redist73_yip1_4_uid81_sincosTest_b_1(DELAY,563)
    redist73_yip1_4_uid81_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_4_uid81_sincosTest_b, xout => redist73_yip1_4_uid81_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- twoToMiSiYip_uid89_sincosTest(BITSELECT,88)@4
    twoToMiSiYip_uid89_sincosTest_b <= STD_LOGIC_VECTOR(redist73_yip1_4_uid81_sincosTest_b_1_q(52 downto 4));

    -- twoToMiSiYip_uid73_sincosTest(BITSELECT,72)@3
    twoToMiSiYip_uid73_sincosTest_b <= STD_LOGIC_VECTOR(redist76_yip1_3_uid65_sincosTest_b_1_q(52 downto 3));

    -- xip1E_4_uid76_sincosTest(ADDSUB,75)@3
    xip1E_4_uid76_sincosTest_s <= redist75_xMSB_uid67_sincosTest_b_2_q;
    xip1E_4_uid76_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist77_xip1_3_uid64_sincosTest_b_1_q(52)) & redist77_xip1_3_uid64_sincosTest_b_1_q));
    xip1E_4_uid76_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 50 => twoToMiSiYip_uid73_sincosTest_b(49)) & twoToMiSiYip_uid73_sincosTest_b));
    xip1E_4_uid76_sincosTest_combproc: PROCESS (xip1E_4_uid76_sincosTest_a, xip1E_4_uid76_sincosTest_b, xip1E_4_uid76_sincosTest_s)
    BEGIN
        IF (xip1E_4_uid76_sincosTest_s = "1") THEN
            xip1E_4_uid76_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_4_uid76_sincosTest_a) + SIGNED(xip1E_4_uid76_sincosTest_b));
        ELSE
            xip1E_4_uid76_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_4_uid76_sincosTest_a) - SIGNED(xip1E_4_uid76_sincosTest_b));
        END IF;
    END PROCESS;
    xip1E_4_uid76_sincosTest_q <= xip1E_4_uid76_sincosTest_o(53 downto 0);

    -- xip1_4_uid80_sincosTest(BITSELECT,79)@3
    xip1_4_uid80_sincosTest_in <= STD_LOGIC_VECTOR(xip1E_4_uid76_sincosTest_q(52 downto 0));
    xip1_4_uid80_sincosTest_b <= STD_LOGIC_VECTOR(xip1_4_uid80_sincosTest_in(52 downto 0));

    -- redist74_xip1_4_uid80_sincosTest_b_1(DELAY,564)
    redist74_xip1_4_uid80_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_4_uid80_sincosTest_b, xout => redist74_xip1_4_uid80_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- xip1E_5_uid92_sincosTest(ADDSUB,91)@4
    xip1E_5_uid92_sincosTest_s <= redist71_xMSB_uid83_sincosTest_b_2_q;
    xip1E_5_uid92_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist74_xip1_4_uid80_sincosTest_b_1_q(52)) & redist74_xip1_4_uid80_sincosTest_b_1_q));
    xip1E_5_uid92_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 49 => twoToMiSiYip_uid89_sincosTest_b(48)) & twoToMiSiYip_uid89_sincosTest_b));
    xip1E_5_uid92_sincosTest_combproc: PROCESS (xip1E_5_uid92_sincosTest_a, xip1E_5_uid92_sincosTest_b, xip1E_5_uid92_sincosTest_s)
    BEGIN
        IF (xip1E_5_uid92_sincosTest_s = "1") THEN
            xip1E_5_uid92_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_5_uid92_sincosTest_a) + SIGNED(xip1E_5_uid92_sincosTest_b));
        ELSE
            xip1E_5_uid92_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_5_uid92_sincosTest_a) - SIGNED(xip1E_5_uid92_sincosTest_b));
        END IF;
    END PROCESS;
    xip1E_5_uid92_sincosTest_q <= xip1E_5_uid92_sincosTest_o(53 downto 0);

    -- xip1_5_uid96_sincosTest(BITSELECT,95)@4
    xip1_5_uid96_sincosTest_in <= STD_LOGIC_VECTOR(xip1E_5_uid92_sincosTest_q(52 downto 0));
    xip1_5_uid96_sincosTest_b <= STD_LOGIC_VECTOR(xip1_5_uid96_sincosTest_in(52 downto 0));

    -- redist70_xip1_5_uid96_sincosTest_b_1(DELAY,560)
    redist70_xip1_5_uid96_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_5_uid96_sincosTest_b, xout => redist70_xip1_5_uid96_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- twoToMiSiXip_uid104_sincosTest(BITSELECT,103)@5
    twoToMiSiXip_uid104_sincosTest_b <= STD_LOGIC_VECTOR(redist70_xip1_5_uid96_sincosTest_b_1_q(52 downto 5));

    -- signOfSelectionSignal_uid85_sincosTest(LOGICAL,84)@4
    signOfSelectionSignal_uid85_sincosTest_q <= not (redist71_xMSB_uid83_sincosTest_b_2_q);

    -- twoToMiSiXip_uid88_sincosTest(BITSELECT,87)@4
    twoToMiSiXip_uid88_sincosTest_b <= STD_LOGIC_VECTOR(redist74_xip1_4_uid80_sincosTest_b_1_q(52 downto 4));

    -- yip1E_5_uid93_sincosTest(ADDSUB,92)@4
    yip1E_5_uid93_sincosTest_s <= signOfSelectionSignal_uid85_sincosTest_q;
    yip1E_5_uid93_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist73_yip1_4_uid81_sincosTest_b_1_q(52)) & redist73_yip1_4_uid81_sincosTest_b_1_q));
    yip1E_5_uid93_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 49 => twoToMiSiXip_uid88_sincosTest_b(48)) & twoToMiSiXip_uid88_sincosTest_b));
    yip1E_5_uid93_sincosTest_combproc: PROCESS (yip1E_5_uid93_sincosTest_a, yip1E_5_uid93_sincosTest_b, yip1E_5_uid93_sincosTest_s)
    BEGIN
        IF (yip1E_5_uid93_sincosTest_s = "1") THEN
            yip1E_5_uid93_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_5_uid93_sincosTest_a) + SIGNED(yip1E_5_uid93_sincosTest_b));
        ELSE
            yip1E_5_uid93_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_5_uid93_sincosTest_a) - SIGNED(yip1E_5_uid93_sincosTest_b));
        END IF;
    END PROCESS;
    yip1E_5_uid93_sincosTest_q <= yip1E_5_uid93_sincosTest_o(53 downto 0);

    -- yip1_5_uid97_sincosTest(BITSELECT,96)@4
    yip1_5_uid97_sincosTest_in <= STD_LOGIC_VECTOR(yip1E_5_uid93_sincosTest_q(52 downto 0));
    yip1_5_uid97_sincosTest_b <= STD_LOGIC_VECTOR(yip1_5_uid97_sincosTest_in(52 downto 0));

    -- redist69_yip1_5_uid97_sincosTest_b_1(DELAY,559)
    redist69_yip1_5_uid97_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_5_uid97_sincosTest_b, xout => redist69_yip1_5_uid97_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- yip1E_6_uid109_sincosTest(ADDSUB,108)@5
    yip1E_6_uid109_sincosTest_s <= signOfSelectionSignal_uid101_sincosTest_q;
    yip1E_6_uid109_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist69_yip1_5_uid97_sincosTest_b_1_q(52)) & redist69_yip1_5_uid97_sincosTest_b_1_q));
    yip1E_6_uid109_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 48 => twoToMiSiXip_uid104_sincosTest_b(47)) & twoToMiSiXip_uid104_sincosTest_b));
    yip1E_6_uid109_sincosTest_combproc: PROCESS (yip1E_6_uid109_sincosTest_a, yip1E_6_uid109_sincosTest_b, yip1E_6_uid109_sincosTest_s)
    BEGIN
        IF (yip1E_6_uid109_sincosTest_s = "1") THEN
            yip1E_6_uid109_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_6_uid109_sincosTest_a) + SIGNED(yip1E_6_uid109_sincosTest_b));
        ELSE
            yip1E_6_uid109_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_6_uid109_sincosTest_a) - SIGNED(yip1E_6_uid109_sincosTest_b));
        END IF;
    END PROCESS;
    yip1E_6_uid109_sincosTest_q <= yip1E_6_uid109_sincosTest_o(53 downto 0);

    -- yip1_6_uid113_sincosTest(BITSELECT,112)@5
    yip1_6_uid113_sincosTest_in <= STD_LOGIC_VECTOR(yip1E_6_uid109_sincosTest_q(52 downto 0));
    yip1_6_uid113_sincosTest_b <= STD_LOGIC_VECTOR(yip1_6_uid113_sincosTest_in(52 downto 0));

    -- redist66_yip1_6_uid113_sincosTest_b_1(DELAY,556)
    redist66_yip1_6_uid113_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_6_uid113_sincosTest_b, xout => redist66_yip1_6_uid113_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- twoToMiSiYip_uid121_sincosTest(BITSELECT,120)@6
    twoToMiSiYip_uid121_sincosTest_b <= STD_LOGIC_VECTOR(redist66_yip1_6_uid113_sincosTest_b_1_q(52 downto 6));

    -- twoToMiSiYip_uid105_sincosTest(BITSELECT,104)@5
    twoToMiSiYip_uid105_sincosTest_b <= STD_LOGIC_VECTOR(redist69_yip1_5_uid97_sincosTest_b_1_q(52 downto 5));

    -- xip1E_6_uid108_sincosTest(ADDSUB,107)@5
    xip1E_6_uid108_sincosTest_s <= redist68_xMSB_uid99_sincosTest_b_3_q;
    xip1E_6_uid108_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist70_xip1_5_uid96_sincosTest_b_1_q(52)) & redist70_xip1_5_uid96_sincosTest_b_1_q));
    xip1E_6_uid108_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 48 => twoToMiSiYip_uid105_sincosTest_b(47)) & twoToMiSiYip_uid105_sincosTest_b));
    xip1E_6_uid108_sincosTest_combproc: PROCESS (xip1E_6_uid108_sincosTest_a, xip1E_6_uid108_sincosTest_b, xip1E_6_uid108_sincosTest_s)
    BEGIN
        IF (xip1E_6_uid108_sincosTest_s = "1") THEN
            xip1E_6_uid108_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_6_uid108_sincosTest_a) + SIGNED(xip1E_6_uid108_sincosTest_b));
        ELSE
            xip1E_6_uid108_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_6_uid108_sincosTest_a) - SIGNED(xip1E_6_uid108_sincosTest_b));
        END IF;
    END PROCESS;
    xip1E_6_uid108_sincosTest_q <= xip1E_6_uid108_sincosTest_o(53 downto 0);

    -- xip1_6_uid112_sincosTest(BITSELECT,111)@5
    xip1_6_uid112_sincosTest_in <= STD_LOGIC_VECTOR(xip1E_6_uid108_sincosTest_q(52 downto 0));
    xip1_6_uid112_sincosTest_b <= STD_LOGIC_VECTOR(xip1_6_uid112_sincosTest_in(52 downto 0));

    -- redist67_xip1_6_uid112_sincosTest_b_1(DELAY,557)
    redist67_xip1_6_uid112_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_6_uid112_sincosTest_b, xout => redist67_xip1_6_uid112_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- xip1E_7_uid124_sincosTest(ADDSUB,123)@6
    xip1E_7_uid124_sincosTest_s <= redist64_xMSB_uid115_sincosTest_b_3_q;
    xip1E_7_uid124_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist67_xip1_6_uid112_sincosTest_b_1_q(52)) & redist67_xip1_6_uid112_sincosTest_b_1_q));
    xip1E_7_uid124_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 47 => twoToMiSiYip_uid121_sincosTest_b(46)) & twoToMiSiYip_uid121_sincosTest_b));
    xip1E_7_uid124_sincosTest_combproc: PROCESS (xip1E_7_uid124_sincosTest_a, xip1E_7_uid124_sincosTest_b, xip1E_7_uid124_sincosTest_s)
    BEGIN
        IF (xip1E_7_uid124_sincosTest_s = "1") THEN
            xip1E_7_uid124_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_7_uid124_sincosTest_a) + SIGNED(xip1E_7_uid124_sincosTest_b));
        ELSE
            xip1E_7_uid124_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_7_uid124_sincosTest_a) - SIGNED(xip1E_7_uid124_sincosTest_b));
        END IF;
    END PROCESS;
    xip1E_7_uid124_sincosTest_q <= xip1E_7_uid124_sincosTest_o(53 downto 0);

    -- xip1_7_uid128_sincosTest(BITSELECT,127)@6
    xip1_7_uid128_sincosTest_in <= STD_LOGIC_VECTOR(xip1E_7_uid124_sincosTest_q(52 downto 0));
    xip1_7_uid128_sincosTest_b <= STD_LOGIC_VECTOR(xip1_7_uid128_sincosTest_in(52 downto 0));

    -- redist63_xip1_7_uid128_sincosTest_b_1(DELAY,553)
    redist63_xip1_7_uid128_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_7_uid128_sincosTest_b, xout => redist63_xip1_7_uid128_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- twoToMiSiXip_uid136_sincosTest(BITSELECT,135)@7
    twoToMiSiXip_uid136_sincosTest_b <= STD_LOGIC_VECTOR(redist63_xip1_7_uid128_sincosTest_b_1_q(52 downto 7));

    -- signOfSelectionSignal_uid117_sincosTest(LOGICAL,116)@6
    signOfSelectionSignal_uid117_sincosTest_q <= not (redist64_xMSB_uid115_sincosTest_b_3_q);

    -- twoToMiSiXip_uid120_sincosTest(BITSELECT,119)@6
    twoToMiSiXip_uid120_sincosTest_b <= STD_LOGIC_VECTOR(redist67_xip1_6_uid112_sincosTest_b_1_q(52 downto 6));

    -- yip1E_7_uid125_sincosTest(ADDSUB,124)@6
    yip1E_7_uid125_sincosTest_s <= signOfSelectionSignal_uid117_sincosTest_q;
    yip1E_7_uid125_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist66_yip1_6_uid113_sincosTest_b_1_q(52)) & redist66_yip1_6_uid113_sincosTest_b_1_q));
    yip1E_7_uid125_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 47 => twoToMiSiXip_uid120_sincosTest_b(46)) & twoToMiSiXip_uid120_sincosTest_b));
    yip1E_7_uid125_sincosTest_combproc: PROCESS (yip1E_7_uid125_sincosTest_a, yip1E_7_uid125_sincosTest_b, yip1E_7_uid125_sincosTest_s)
    BEGIN
        IF (yip1E_7_uid125_sincosTest_s = "1") THEN
            yip1E_7_uid125_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_7_uid125_sincosTest_a) + SIGNED(yip1E_7_uid125_sincosTest_b));
        ELSE
            yip1E_7_uid125_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_7_uid125_sincosTest_a) - SIGNED(yip1E_7_uid125_sincosTest_b));
        END IF;
    END PROCESS;
    yip1E_7_uid125_sincosTest_q <= yip1E_7_uid125_sincosTest_o(53 downto 0);

    -- yip1_7_uid129_sincosTest(BITSELECT,128)@6
    yip1_7_uid129_sincosTest_in <= STD_LOGIC_VECTOR(yip1E_7_uid125_sincosTest_q(52 downto 0));
    yip1_7_uid129_sincosTest_b <= STD_LOGIC_VECTOR(yip1_7_uid129_sincosTest_in(52 downto 0));

    -- redist62_yip1_7_uid129_sincosTest_b_1(DELAY,552)
    redist62_yip1_7_uid129_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_7_uid129_sincosTest_b, xout => redist62_yip1_7_uid129_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- yip1E_8_uid141_sincosTest(ADDSUB,140)@7
    yip1E_8_uid141_sincosTest_s <= signOfSelectionSignal_uid133_sincosTest_q;
    yip1E_8_uid141_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist62_yip1_7_uid129_sincosTest_b_1_q(52)) & redist62_yip1_7_uid129_sincosTest_b_1_q));
    yip1E_8_uid141_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 46 => twoToMiSiXip_uid136_sincosTest_b(45)) & twoToMiSiXip_uid136_sincosTest_b));
    yip1E_8_uid141_sincosTest_combproc: PROCESS (yip1E_8_uid141_sincosTest_a, yip1E_8_uid141_sincosTest_b, yip1E_8_uid141_sincosTest_s)
    BEGIN
        IF (yip1E_8_uid141_sincosTest_s = "1") THEN
            yip1E_8_uid141_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_8_uid141_sincosTest_a) + SIGNED(yip1E_8_uid141_sincosTest_b));
        ELSE
            yip1E_8_uid141_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_8_uid141_sincosTest_a) - SIGNED(yip1E_8_uid141_sincosTest_b));
        END IF;
    END PROCESS;
    yip1E_8_uid141_sincosTest_q <= yip1E_8_uid141_sincosTest_o(53 downto 0);

    -- yip1_8_uid145_sincosTest(BITSELECT,144)@7
    yip1_8_uid145_sincosTest_in <= STD_LOGIC_VECTOR(yip1E_8_uid141_sincosTest_q(52 downto 0));
    yip1_8_uid145_sincosTest_b <= STD_LOGIC_VECTOR(yip1_8_uid145_sincosTest_in(52 downto 0));

    -- redist59_yip1_8_uid145_sincosTest_b_1(DELAY,549)
    redist59_yip1_8_uid145_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_8_uid145_sincosTest_b, xout => redist59_yip1_8_uid145_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- twoToMiSiYip_uid153_sincosTest(BITSELECT,152)@8
    twoToMiSiYip_uid153_sincosTest_b <= STD_LOGIC_VECTOR(redist59_yip1_8_uid145_sincosTest_b_1_q(52 downto 8));

    -- twoToMiSiYip_uid137_sincosTest(BITSELECT,136)@7
    twoToMiSiYip_uid137_sincosTest_b <= STD_LOGIC_VECTOR(redist62_yip1_7_uid129_sincosTest_b_1_q(52 downto 7));

    -- xip1E_8_uid140_sincosTest(ADDSUB,139)@7
    xip1E_8_uid140_sincosTest_s <= redist61_xMSB_uid131_sincosTest_b_4_q;
    xip1E_8_uid140_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist63_xip1_7_uid128_sincosTest_b_1_q(52)) & redist63_xip1_7_uid128_sincosTest_b_1_q));
    xip1E_8_uid140_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 46 => twoToMiSiYip_uid137_sincosTest_b(45)) & twoToMiSiYip_uid137_sincosTest_b));
    xip1E_8_uid140_sincosTest_combproc: PROCESS (xip1E_8_uid140_sincosTest_a, xip1E_8_uid140_sincosTest_b, xip1E_8_uid140_sincosTest_s)
    BEGIN
        IF (xip1E_8_uid140_sincosTest_s = "1") THEN
            xip1E_8_uid140_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_8_uid140_sincosTest_a) + SIGNED(xip1E_8_uid140_sincosTest_b));
        ELSE
            xip1E_8_uid140_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_8_uid140_sincosTest_a) - SIGNED(xip1E_8_uid140_sincosTest_b));
        END IF;
    END PROCESS;
    xip1E_8_uid140_sincosTest_q <= xip1E_8_uid140_sincosTest_o(53 downto 0);

    -- xip1_8_uid144_sincosTest(BITSELECT,143)@7
    xip1_8_uid144_sincosTest_in <= STD_LOGIC_VECTOR(xip1E_8_uid140_sincosTest_q(52 downto 0));
    xip1_8_uid144_sincosTest_b <= STD_LOGIC_VECTOR(xip1_8_uid144_sincosTest_in(52 downto 0));

    -- redist60_xip1_8_uid144_sincosTest_b_1(DELAY,550)
    redist60_xip1_8_uid144_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_8_uid144_sincosTest_b, xout => redist60_xip1_8_uid144_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- xip1E_9_uid156_sincosTest(ADDSUB,155)@8
    xip1E_9_uid156_sincosTest_s <= redist57_xMSB_uid147_sincosTest_b_4_q;
    xip1E_9_uid156_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist60_xip1_8_uid144_sincosTest_b_1_q(52)) & redist60_xip1_8_uid144_sincosTest_b_1_q));
    xip1E_9_uid156_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 45 => twoToMiSiYip_uid153_sincosTest_b(44)) & twoToMiSiYip_uid153_sincosTest_b));
    xip1E_9_uid156_sincosTest_combproc: PROCESS (xip1E_9_uid156_sincosTest_a, xip1E_9_uid156_sincosTest_b, xip1E_9_uid156_sincosTest_s)
    BEGIN
        IF (xip1E_9_uid156_sincosTest_s = "1") THEN
            xip1E_9_uid156_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_9_uid156_sincosTest_a) + SIGNED(xip1E_9_uid156_sincosTest_b));
        ELSE
            xip1E_9_uid156_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_9_uid156_sincosTest_a) - SIGNED(xip1E_9_uid156_sincosTest_b));
        END IF;
    END PROCESS;
    xip1E_9_uid156_sincosTest_q <= xip1E_9_uid156_sincosTest_o(53 downto 0);

    -- xip1_9_uid160_sincosTest(BITSELECT,159)@8
    xip1_9_uid160_sincosTest_in <= STD_LOGIC_VECTOR(xip1E_9_uid156_sincosTest_q(52 downto 0));
    xip1_9_uid160_sincosTest_b <= STD_LOGIC_VECTOR(xip1_9_uid160_sincosTest_in(52 downto 0));

    -- redist56_xip1_9_uid160_sincosTest_b_1(DELAY,546)
    redist56_xip1_9_uid160_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_9_uid160_sincosTest_b, xout => redist56_xip1_9_uid160_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- twoToMiSiXip_uid168_sincosTest(BITSELECT,167)@9
    twoToMiSiXip_uid168_sincosTest_b <= STD_LOGIC_VECTOR(redist56_xip1_9_uid160_sincosTest_b_1_q(52 downto 9));

    -- signOfSelectionSignal_uid149_sincosTest(LOGICAL,148)@8
    signOfSelectionSignal_uid149_sincosTest_q <= not (redist57_xMSB_uid147_sincosTest_b_4_q);

    -- twoToMiSiXip_uid152_sincosTest(BITSELECT,151)@8
    twoToMiSiXip_uid152_sincosTest_b <= STD_LOGIC_VECTOR(redist60_xip1_8_uid144_sincosTest_b_1_q(52 downto 8));

    -- yip1E_9_uid157_sincosTest(ADDSUB,156)@8
    yip1E_9_uid157_sincosTest_s <= signOfSelectionSignal_uid149_sincosTest_q;
    yip1E_9_uid157_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist59_yip1_8_uid145_sincosTest_b_1_q(52)) & redist59_yip1_8_uid145_sincosTest_b_1_q));
    yip1E_9_uid157_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 45 => twoToMiSiXip_uid152_sincosTest_b(44)) & twoToMiSiXip_uid152_sincosTest_b));
    yip1E_9_uid157_sincosTest_combproc: PROCESS (yip1E_9_uid157_sincosTest_a, yip1E_9_uid157_sincosTest_b, yip1E_9_uid157_sincosTest_s)
    BEGIN
        IF (yip1E_9_uid157_sincosTest_s = "1") THEN
            yip1E_9_uid157_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_9_uid157_sincosTest_a) + SIGNED(yip1E_9_uid157_sincosTest_b));
        ELSE
            yip1E_9_uid157_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_9_uid157_sincosTest_a) - SIGNED(yip1E_9_uid157_sincosTest_b));
        END IF;
    END PROCESS;
    yip1E_9_uid157_sincosTest_q <= yip1E_9_uid157_sincosTest_o(53 downto 0);

    -- yip1_9_uid161_sincosTest(BITSELECT,160)@8
    yip1_9_uid161_sincosTest_in <= STD_LOGIC_VECTOR(yip1E_9_uid157_sincosTest_q(52 downto 0));
    yip1_9_uid161_sincosTest_b <= STD_LOGIC_VECTOR(yip1_9_uid161_sincosTest_in(52 downto 0));

    -- redist55_yip1_9_uid161_sincosTest_b_1(DELAY,545)
    redist55_yip1_9_uid161_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_9_uid161_sincosTest_b, xout => redist55_yip1_9_uid161_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- yip1E_10_uid173_sincosTest(ADDSUB,172)@9
    yip1E_10_uid173_sincosTest_s <= signOfSelectionSignal_uid165_sincosTest_q;
    yip1E_10_uid173_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist55_yip1_9_uid161_sincosTest_b_1_q(52)) & redist55_yip1_9_uid161_sincosTest_b_1_q));
    yip1E_10_uid173_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 44 => twoToMiSiXip_uid168_sincosTest_b(43)) & twoToMiSiXip_uid168_sincosTest_b));
    yip1E_10_uid173_sincosTest_combproc: PROCESS (yip1E_10_uid173_sincosTest_a, yip1E_10_uid173_sincosTest_b, yip1E_10_uid173_sincosTest_s)
    BEGIN
        IF (yip1E_10_uid173_sincosTest_s = "1") THEN
            yip1E_10_uid173_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_10_uid173_sincosTest_a) + SIGNED(yip1E_10_uid173_sincosTest_b));
        ELSE
            yip1E_10_uid173_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_10_uid173_sincosTest_a) - SIGNED(yip1E_10_uid173_sincosTest_b));
        END IF;
    END PROCESS;
    yip1E_10_uid173_sincosTest_q <= yip1E_10_uid173_sincosTest_o(53 downto 0);

    -- yip1_10_uid177_sincosTest(BITSELECT,176)@9
    yip1_10_uid177_sincosTest_in <= STD_LOGIC_VECTOR(yip1E_10_uid173_sincosTest_q(52 downto 0));
    yip1_10_uid177_sincosTest_b <= STD_LOGIC_VECTOR(yip1_10_uid177_sincosTest_in(52 downto 0));

    -- redist52_yip1_10_uid177_sincosTest_b_1(DELAY,542)
    redist52_yip1_10_uid177_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_10_uid177_sincosTest_b, xout => redist52_yip1_10_uid177_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- twoToMiSiYip_uid185_sincosTest(BITSELECT,184)@10
    twoToMiSiYip_uid185_sincosTest_b <= STD_LOGIC_VECTOR(redist52_yip1_10_uid177_sincosTest_b_1_q(52 downto 10));

    -- twoToMiSiYip_uid169_sincosTest(BITSELECT,168)@9
    twoToMiSiYip_uid169_sincosTest_b <= STD_LOGIC_VECTOR(redist55_yip1_9_uid161_sincosTest_b_1_q(52 downto 9));

    -- xip1E_10_uid172_sincosTest(ADDSUB,171)@9
    xip1E_10_uid172_sincosTest_s <= redist54_xMSB_uid163_sincosTest_b_5_q;
    xip1E_10_uid172_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist56_xip1_9_uid160_sincosTest_b_1_q(52)) & redist56_xip1_9_uid160_sincosTest_b_1_q));
    xip1E_10_uid172_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 44 => twoToMiSiYip_uid169_sincosTest_b(43)) & twoToMiSiYip_uid169_sincosTest_b));
    xip1E_10_uid172_sincosTest_combproc: PROCESS (xip1E_10_uid172_sincosTest_a, xip1E_10_uid172_sincosTest_b, xip1E_10_uid172_sincosTest_s)
    BEGIN
        IF (xip1E_10_uid172_sincosTest_s = "1") THEN
            xip1E_10_uid172_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_10_uid172_sincosTest_a) + SIGNED(xip1E_10_uid172_sincosTest_b));
        ELSE
            xip1E_10_uid172_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_10_uid172_sincosTest_a) - SIGNED(xip1E_10_uid172_sincosTest_b));
        END IF;
    END PROCESS;
    xip1E_10_uid172_sincosTest_q <= xip1E_10_uid172_sincosTest_o(53 downto 0);

    -- xip1_10_uid176_sincosTest(BITSELECT,175)@9
    xip1_10_uid176_sincosTest_in <= STD_LOGIC_VECTOR(xip1E_10_uid172_sincosTest_q(52 downto 0));
    xip1_10_uid176_sincosTest_b <= STD_LOGIC_VECTOR(xip1_10_uid176_sincosTest_in(52 downto 0));

    -- redist53_xip1_10_uid176_sincosTest_b_1(DELAY,543)
    redist53_xip1_10_uid176_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_10_uid176_sincosTest_b, xout => redist53_xip1_10_uid176_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- xip1E_11_uid188_sincosTest(ADDSUB,187)@10
    xip1E_11_uid188_sincosTest_s <= redist50_xMSB_uid179_sincosTest_b_5_q;
    xip1E_11_uid188_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist53_xip1_10_uid176_sincosTest_b_1_q(52)) & redist53_xip1_10_uid176_sincosTest_b_1_q));
    xip1E_11_uid188_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 43 => twoToMiSiYip_uid185_sincosTest_b(42)) & twoToMiSiYip_uid185_sincosTest_b));
    xip1E_11_uid188_sincosTest_combproc: PROCESS (xip1E_11_uid188_sincosTest_a, xip1E_11_uid188_sincosTest_b, xip1E_11_uid188_sincosTest_s)
    BEGIN
        IF (xip1E_11_uid188_sincosTest_s = "1") THEN
            xip1E_11_uid188_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_11_uid188_sincosTest_a) + SIGNED(xip1E_11_uid188_sincosTest_b));
        ELSE
            xip1E_11_uid188_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_11_uid188_sincosTest_a) - SIGNED(xip1E_11_uid188_sincosTest_b));
        END IF;
    END PROCESS;
    xip1E_11_uid188_sincosTest_q <= xip1E_11_uid188_sincosTest_o(53 downto 0);

    -- xip1_11_uid192_sincosTest(BITSELECT,191)@10
    xip1_11_uid192_sincosTest_in <= STD_LOGIC_VECTOR(xip1E_11_uid188_sincosTest_q(52 downto 0));
    xip1_11_uid192_sincosTest_b <= STD_LOGIC_VECTOR(xip1_11_uid192_sincosTest_in(52 downto 0));

    -- redist49_xip1_11_uid192_sincosTest_b_1(DELAY,539)
    redist49_xip1_11_uid192_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_11_uid192_sincosTest_b, xout => redist49_xip1_11_uid192_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- twoToMiSiXip_uid200_sincosTest(BITSELECT,199)@11
    twoToMiSiXip_uid200_sincosTest_b <= STD_LOGIC_VECTOR(redist49_xip1_11_uid192_sincosTest_b_1_q(52 downto 11));

    -- signOfSelectionSignal_uid181_sincosTest(LOGICAL,180)@10
    signOfSelectionSignal_uid181_sincosTest_q <= not (redist50_xMSB_uid179_sincosTest_b_5_q);

    -- twoToMiSiXip_uid184_sincosTest(BITSELECT,183)@10
    twoToMiSiXip_uid184_sincosTest_b <= STD_LOGIC_VECTOR(redist53_xip1_10_uid176_sincosTest_b_1_q(52 downto 10));

    -- yip1E_11_uid189_sincosTest(ADDSUB,188)@10
    yip1E_11_uid189_sincosTest_s <= signOfSelectionSignal_uid181_sincosTest_q;
    yip1E_11_uid189_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist52_yip1_10_uid177_sincosTest_b_1_q(52)) & redist52_yip1_10_uid177_sincosTest_b_1_q));
    yip1E_11_uid189_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 43 => twoToMiSiXip_uid184_sincosTest_b(42)) & twoToMiSiXip_uid184_sincosTest_b));
    yip1E_11_uid189_sincosTest_combproc: PROCESS (yip1E_11_uid189_sincosTest_a, yip1E_11_uid189_sincosTest_b, yip1E_11_uid189_sincosTest_s)
    BEGIN
        IF (yip1E_11_uid189_sincosTest_s = "1") THEN
            yip1E_11_uid189_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_11_uid189_sincosTest_a) + SIGNED(yip1E_11_uid189_sincosTest_b));
        ELSE
            yip1E_11_uid189_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_11_uid189_sincosTest_a) - SIGNED(yip1E_11_uid189_sincosTest_b));
        END IF;
    END PROCESS;
    yip1E_11_uid189_sincosTest_q <= yip1E_11_uid189_sincosTest_o(53 downto 0);

    -- yip1_11_uid193_sincosTest(BITSELECT,192)@10
    yip1_11_uid193_sincosTest_in <= STD_LOGIC_VECTOR(yip1E_11_uid189_sincosTest_q(52 downto 0));
    yip1_11_uid193_sincosTest_b <= STD_LOGIC_VECTOR(yip1_11_uid193_sincosTest_in(52 downto 0));

    -- redist48_yip1_11_uid193_sincosTest_b_1(DELAY,538)
    redist48_yip1_11_uid193_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_11_uid193_sincosTest_b, xout => redist48_yip1_11_uid193_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- yip1E_12_uid205_sincosTest(ADDSUB,204)@11
    yip1E_12_uid205_sincosTest_s <= signOfSelectionSignal_uid197_sincosTest_q;
    yip1E_12_uid205_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist48_yip1_11_uid193_sincosTest_b_1_q(52)) & redist48_yip1_11_uid193_sincosTest_b_1_q));
    yip1E_12_uid205_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 42 => twoToMiSiXip_uid200_sincosTest_b(41)) & twoToMiSiXip_uid200_sincosTest_b));
    yip1E_12_uid205_sincosTest_combproc: PROCESS (yip1E_12_uid205_sincosTest_a, yip1E_12_uid205_sincosTest_b, yip1E_12_uid205_sincosTest_s)
    BEGIN
        IF (yip1E_12_uid205_sincosTest_s = "1") THEN
            yip1E_12_uid205_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_12_uid205_sincosTest_a) + SIGNED(yip1E_12_uid205_sincosTest_b));
        ELSE
            yip1E_12_uid205_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_12_uid205_sincosTest_a) - SIGNED(yip1E_12_uid205_sincosTest_b));
        END IF;
    END PROCESS;
    yip1E_12_uid205_sincosTest_q <= yip1E_12_uid205_sincosTest_o(53 downto 0);

    -- yip1_12_uid209_sincosTest(BITSELECT,208)@11
    yip1_12_uid209_sincosTest_in <= STD_LOGIC_VECTOR(yip1E_12_uid205_sincosTest_q(52 downto 0));
    yip1_12_uid209_sincosTest_b <= STD_LOGIC_VECTOR(yip1_12_uid209_sincosTest_in(52 downto 0));

    -- redist45_yip1_12_uid209_sincosTest_b_1(DELAY,535)
    redist45_yip1_12_uid209_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_12_uid209_sincosTest_b, xout => redist45_yip1_12_uid209_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- twoToMiSiYip_uid217_sincosTest(BITSELECT,216)@12
    twoToMiSiYip_uid217_sincosTest_b <= STD_LOGIC_VECTOR(redist45_yip1_12_uid209_sincosTest_b_1_q(52 downto 12));

    -- twoToMiSiYip_uid201_sincosTest(BITSELECT,200)@11
    twoToMiSiYip_uid201_sincosTest_b <= STD_LOGIC_VECTOR(redist48_yip1_11_uid193_sincosTest_b_1_q(52 downto 11));

    -- xip1E_12_uid204_sincosTest(ADDSUB,203)@11
    xip1E_12_uid204_sincosTest_s <= redist47_xMSB_uid195_sincosTest_b_6_q;
    xip1E_12_uid204_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist49_xip1_11_uid192_sincosTest_b_1_q(52)) & redist49_xip1_11_uid192_sincosTest_b_1_q));
    xip1E_12_uid204_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 42 => twoToMiSiYip_uid201_sincosTest_b(41)) & twoToMiSiYip_uid201_sincosTest_b));
    xip1E_12_uid204_sincosTest_combproc: PROCESS (xip1E_12_uid204_sincosTest_a, xip1E_12_uid204_sincosTest_b, xip1E_12_uid204_sincosTest_s)
    BEGIN
        IF (xip1E_12_uid204_sincosTest_s = "1") THEN
            xip1E_12_uid204_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_12_uid204_sincosTest_a) + SIGNED(xip1E_12_uid204_sincosTest_b));
        ELSE
            xip1E_12_uid204_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_12_uid204_sincosTest_a) - SIGNED(xip1E_12_uid204_sincosTest_b));
        END IF;
    END PROCESS;
    xip1E_12_uid204_sincosTest_q <= xip1E_12_uid204_sincosTest_o(53 downto 0);

    -- xip1_12_uid208_sincosTest(BITSELECT,207)@11
    xip1_12_uid208_sincosTest_in <= STD_LOGIC_VECTOR(xip1E_12_uid204_sincosTest_q(52 downto 0));
    xip1_12_uid208_sincosTest_b <= STD_LOGIC_VECTOR(xip1_12_uid208_sincosTest_in(52 downto 0));

    -- redist46_xip1_12_uid208_sincosTest_b_1(DELAY,536)
    redist46_xip1_12_uid208_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_12_uid208_sincosTest_b, xout => redist46_xip1_12_uid208_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- xip1E_13_uid220_sincosTest(ADDSUB,219)@12
    xip1E_13_uid220_sincosTest_s <= redist43_xMSB_uid211_sincosTest_b_6_q;
    xip1E_13_uid220_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist46_xip1_12_uid208_sincosTest_b_1_q(52)) & redist46_xip1_12_uid208_sincosTest_b_1_q));
    xip1E_13_uid220_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 41 => twoToMiSiYip_uid217_sincosTest_b(40)) & twoToMiSiYip_uid217_sincosTest_b));
    xip1E_13_uid220_sincosTest_combproc: PROCESS (xip1E_13_uid220_sincosTest_a, xip1E_13_uid220_sincosTest_b, xip1E_13_uid220_sincosTest_s)
    BEGIN
        IF (xip1E_13_uid220_sincosTest_s = "1") THEN
            xip1E_13_uid220_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_13_uid220_sincosTest_a) + SIGNED(xip1E_13_uid220_sincosTest_b));
        ELSE
            xip1E_13_uid220_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_13_uid220_sincosTest_a) - SIGNED(xip1E_13_uid220_sincosTest_b));
        END IF;
    END PROCESS;
    xip1E_13_uid220_sincosTest_q <= xip1E_13_uid220_sincosTest_o(53 downto 0);

    -- xip1_13_uid227_sincosTest(BITSELECT,226)@12
    xip1_13_uid227_sincosTest_in <= STD_LOGIC_VECTOR(xip1E_13_uid220_sincosTest_q(52 downto 0));
    xip1_13_uid227_sincosTest_b <= STD_LOGIC_VECTOR(xip1_13_uid227_sincosTest_in(52 downto 0));

    -- redist42_xip1_13_uid227_sincosTest_b_1(DELAY,532)
    redist42_xip1_13_uid227_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_13_uid227_sincosTest_b, xout => redist42_xip1_13_uid227_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- twoToMiSiXip_uid235_sincosTest(BITSELECT,234)@13
    twoToMiSiXip_uid235_sincosTest_b <= STD_LOGIC_VECTOR(redist42_xip1_13_uid227_sincosTest_b_1_q(52 downto 13));

    -- signOfSelectionSignal_uid213_sincosTest(LOGICAL,212)@12
    signOfSelectionSignal_uid213_sincosTest_q <= not (redist43_xMSB_uid211_sincosTest_b_6_q);

    -- twoToMiSiXip_uid216_sincosTest(BITSELECT,215)@12
    twoToMiSiXip_uid216_sincosTest_b <= STD_LOGIC_VECTOR(redist46_xip1_12_uid208_sincosTest_b_1_q(52 downto 12));

    -- yip1E_13_uid221_sincosTest(ADDSUB,220)@12
    yip1E_13_uid221_sincosTest_s <= signOfSelectionSignal_uid213_sincosTest_q;
    yip1E_13_uid221_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist45_yip1_12_uid209_sincosTest_b_1_q(52)) & redist45_yip1_12_uid209_sincosTest_b_1_q));
    yip1E_13_uid221_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 41 => twoToMiSiXip_uid216_sincosTest_b(40)) & twoToMiSiXip_uid216_sincosTest_b));
    yip1E_13_uid221_sincosTest_combproc: PROCESS (yip1E_13_uid221_sincosTest_a, yip1E_13_uid221_sincosTest_b, yip1E_13_uid221_sincosTest_s)
    BEGIN
        IF (yip1E_13_uid221_sincosTest_s = "1") THEN
            yip1E_13_uid221_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_13_uid221_sincosTest_a) + SIGNED(yip1E_13_uid221_sincosTest_b));
        ELSE
            yip1E_13_uid221_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_13_uid221_sincosTest_a) - SIGNED(yip1E_13_uid221_sincosTest_b));
        END IF;
    END PROCESS;
    yip1E_13_uid221_sincosTest_q <= yip1E_13_uid221_sincosTest_o(53 downto 0);

    -- yip1_13_uid228_sincosTest(BITSELECT,227)@12
    yip1_13_uid228_sincosTest_in <= STD_LOGIC_VECTOR(yip1E_13_uid221_sincosTest_q(52 downto 0));
    yip1_13_uid228_sincosTest_b <= STD_LOGIC_VECTOR(yip1_13_uid228_sincosTest_in(52 downto 0));

    -- redist41_yip1_13_uid228_sincosTest_b_1(DELAY,531)
    redist41_yip1_13_uid228_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_13_uid228_sincosTest_b, xout => redist41_yip1_13_uid228_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- yip1E_14_uid240_sincosTest(ADDSUB,239)@13
    yip1E_14_uid240_sincosTest_s <= signOfSelectionSignal_uid232_sincosTest_q;
    yip1E_14_uid240_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist41_yip1_13_uid228_sincosTest_b_1_q(52)) & redist41_yip1_13_uid228_sincosTest_b_1_q));
    yip1E_14_uid240_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 40 => twoToMiSiXip_uid235_sincosTest_b(39)) & twoToMiSiXip_uid235_sincosTest_b));
    yip1E_14_uid240_sincosTest_combproc: PROCESS (yip1E_14_uid240_sincosTest_a, yip1E_14_uid240_sincosTest_b, yip1E_14_uid240_sincosTest_s)
    BEGIN
        IF (yip1E_14_uid240_sincosTest_s = "1") THEN
            yip1E_14_uid240_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_14_uid240_sincosTest_a) + SIGNED(yip1E_14_uid240_sincosTest_b));
        ELSE
            yip1E_14_uid240_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_14_uid240_sincosTest_a) - SIGNED(yip1E_14_uid240_sincosTest_b));
        END IF;
    END PROCESS;
    yip1E_14_uid240_sincosTest_q <= yip1E_14_uid240_sincosTest_o(53 downto 0);

    -- yip1_14_uid247_sincosTest(BITSELECT,246)@13
    yip1_14_uid247_sincosTest_in <= STD_LOGIC_VECTOR(yip1E_14_uid240_sincosTest_q(52 downto 0));
    yip1_14_uid247_sincosTest_b <= STD_LOGIC_VECTOR(yip1_14_uid247_sincosTest_in(52 downto 0));

    -- redist38_yip1_14_uid247_sincosTest_b_1(DELAY,528)
    redist38_yip1_14_uid247_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_14_uid247_sincosTest_b, xout => redist38_yip1_14_uid247_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- twoToMiSiYip_uid255_sincosTest(BITSELECT,254)@14
    twoToMiSiYip_uid255_sincosTest_b <= STD_LOGIC_VECTOR(redist38_yip1_14_uid247_sincosTest_b_1_q(52 downto 14));

    -- twoToMiSiYip_uid236_sincosTest(BITSELECT,235)@13
    twoToMiSiYip_uid236_sincosTest_b <= STD_LOGIC_VECTOR(redist41_yip1_13_uid228_sincosTest_b_1_q(52 downto 13));

    -- xip1E_14_uid239_sincosTest(ADDSUB,238)@13
    xip1E_14_uid239_sincosTest_s <= redist40_xMSB_uid230_sincosTest_b_7_q;
    xip1E_14_uid239_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist42_xip1_13_uid227_sincosTest_b_1_q(52)) & redist42_xip1_13_uid227_sincosTest_b_1_q));
    xip1E_14_uid239_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 40 => twoToMiSiYip_uid236_sincosTest_b(39)) & twoToMiSiYip_uid236_sincosTest_b));
    xip1E_14_uid239_sincosTest_combproc: PROCESS (xip1E_14_uid239_sincosTest_a, xip1E_14_uid239_sincosTest_b, xip1E_14_uid239_sincosTest_s)
    BEGIN
        IF (xip1E_14_uid239_sincosTest_s = "1") THEN
            xip1E_14_uid239_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_14_uid239_sincosTest_a) + SIGNED(xip1E_14_uid239_sincosTest_b));
        ELSE
            xip1E_14_uid239_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_14_uid239_sincosTest_a) - SIGNED(xip1E_14_uid239_sincosTest_b));
        END IF;
    END PROCESS;
    xip1E_14_uid239_sincosTest_q <= xip1E_14_uid239_sincosTest_o(53 downto 0);

    -- xip1_14_uid246_sincosTest(BITSELECT,245)@13
    xip1_14_uid246_sincosTest_in <= STD_LOGIC_VECTOR(xip1E_14_uid239_sincosTest_q(52 downto 0));
    xip1_14_uid246_sincosTest_b <= STD_LOGIC_VECTOR(xip1_14_uid246_sincosTest_in(52 downto 0));

    -- redist39_xip1_14_uid246_sincosTest_b_1(DELAY,529)
    redist39_xip1_14_uid246_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_14_uid246_sincosTest_b, xout => redist39_xip1_14_uid246_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- xip1E_15_uid258_sincosTest(ADDSUB,257)@14
    xip1E_15_uid258_sincosTest_s <= redist36_xMSB_uid249_sincosTest_b_7_q;
    xip1E_15_uid258_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist39_xip1_14_uid246_sincosTest_b_1_q(52)) & redist39_xip1_14_uid246_sincosTest_b_1_q));
    xip1E_15_uid258_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 39 => twoToMiSiYip_uid255_sincosTest_b(38)) & twoToMiSiYip_uid255_sincosTest_b));
    xip1E_15_uid258_sincosTest_combproc: PROCESS (xip1E_15_uid258_sincosTest_a, xip1E_15_uid258_sincosTest_b, xip1E_15_uid258_sincosTest_s)
    BEGIN
        IF (xip1E_15_uid258_sincosTest_s = "1") THEN
            xip1E_15_uid258_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_15_uid258_sincosTest_a) + SIGNED(xip1E_15_uid258_sincosTest_b));
        ELSE
            xip1E_15_uid258_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_15_uid258_sincosTest_a) - SIGNED(xip1E_15_uid258_sincosTest_b));
        END IF;
    END PROCESS;
    xip1E_15_uid258_sincosTest_q <= xip1E_15_uid258_sincosTest_o(53 downto 0);

    -- xip1_15_uid265_sincosTest(BITSELECT,264)@14
    xip1_15_uid265_sincosTest_in <= STD_LOGIC_VECTOR(xip1E_15_uid258_sincosTest_q(52 downto 0));
    xip1_15_uid265_sincosTest_b <= STD_LOGIC_VECTOR(xip1_15_uid265_sincosTest_in(52 downto 0));

    -- redist35_xip1_15_uid265_sincosTest_b_1(DELAY,525)
    redist35_xip1_15_uid265_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_15_uid265_sincosTest_b, xout => redist35_xip1_15_uid265_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- twoToMiSiXip_uid273_sincosTest(BITSELECT,272)@15
    twoToMiSiXip_uid273_sincosTest_b <= STD_LOGIC_VECTOR(redist35_xip1_15_uid265_sincosTest_b_1_q(52 downto 15));

    -- signOfSelectionSignal_uid251_sincosTest(LOGICAL,250)@14
    signOfSelectionSignal_uid251_sincosTest_q <= not (redist36_xMSB_uid249_sincosTest_b_7_q);

    -- twoToMiSiXip_uid254_sincosTest(BITSELECT,253)@14
    twoToMiSiXip_uid254_sincosTest_b <= STD_LOGIC_VECTOR(redist39_xip1_14_uid246_sincosTest_b_1_q(52 downto 14));

    -- yip1E_15_uid259_sincosTest(ADDSUB,258)@14
    yip1E_15_uid259_sincosTest_s <= signOfSelectionSignal_uid251_sincosTest_q;
    yip1E_15_uid259_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist38_yip1_14_uid247_sincosTest_b_1_q(52)) & redist38_yip1_14_uid247_sincosTest_b_1_q));
    yip1E_15_uid259_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 39 => twoToMiSiXip_uid254_sincosTest_b(38)) & twoToMiSiXip_uid254_sincosTest_b));
    yip1E_15_uid259_sincosTest_combproc: PROCESS (yip1E_15_uid259_sincosTest_a, yip1E_15_uid259_sincosTest_b, yip1E_15_uid259_sincosTest_s)
    BEGIN
        IF (yip1E_15_uid259_sincosTest_s = "1") THEN
            yip1E_15_uid259_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_15_uid259_sincosTest_a) + SIGNED(yip1E_15_uid259_sincosTest_b));
        ELSE
            yip1E_15_uid259_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_15_uid259_sincosTest_a) - SIGNED(yip1E_15_uid259_sincosTest_b));
        END IF;
    END PROCESS;
    yip1E_15_uid259_sincosTest_q <= yip1E_15_uid259_sincosTest_o(53 downto 0);

    -- yip1_15_uid266_sincosTest(BITSELECT,265)@14
    yip1_15_uid266_sincosTest_in <= STD_LOGIC_VECTOR(yip1E_15_uid259_sincosTest_q(52 downto 0));
    yip1_15_uid266_sincosTest_b <= STD_LOGIC_VECTOR(yip1_15_uid266_sincosTest_in(52 downto 0));

    -- redist34_yip1_15_uid266_sincosTest_b_1(DELAY,524)
    redist34_yip1_15_uid266_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_15_uid266_sincosTest_b, xout => redist34_yip1_15_uid266_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- yip1E_16_uid278_sincosTest(ADDSUB,277)@15
    yip1E_16_uid278_sincosTest_s <= signOfSelectionSignal_uid270_sincosTest_q;
    yip1E_16_uid278_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist34_yip1_15_uid266_sincosTest_b_1_q(52)) & redist34_yip1_15_uid266_sincosTest_b_1_q));
    yip1E_16_uid278_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 38 => twoToMiSiXip_uid273_sincosTest_b(37)) & twoToMiSiXip_uid273_sincosTest_b));
    yip1E_16_uid278_sincosTest_combproc: PROCESS (yip1E_16_uid278_sincosTest_a, yip1E_16_uid278_sincosTest_b, yip1E_16_uid278_sincosTest_s)
    BEGIN
        IF (yip1E_16_uid278_sincosTest_s = "1") THEN
            yip1E_16_uid278_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_16_uid278_sincosTest_a) + SIGNED(yip1E_16_uid278_sincosTest_b));
        ELSE
            yip1E_16_uid278_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_16_uid278_sincosTest_a) - SIGNED(yip1E_16_uid278_sincosTest_b));
        END IF;
    END PROCESS;
    yip1E_16_uid278_sincosTest_q <= yip1E_16_uid278_sincosTest_o(53 downto 0);

    -- yip1_16_uid285_sincosTest(BITSELECT,284)@15
    yip1_16_uid285_sincosTest_in <= STD_LOGIC_VECTOR(yip1E_16_uid278_sincosTest_q(52 downto 0));
    yip1_16_uid285_sincosTest_b <= STD_LOGIC_VECTOR(yip1_16_uid285_sincosTest_in(52 downto 0));

    -- redist31_yip1_16_uid285_sincosTest_b_1(DELAY,521)
    redist31_yip1_16_uid285_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_16_uid285_sincosTest_b, xout => redist31_yip1_16_uid285_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- twoToMiSiYip_uid293_sincosTest(BITSELECT,292)@16
    twoToMiSiYip_uid293_sincosTest_b <= STD_LOGIC_VECTOR(redist31_yip1_16_uid285_sincosTest_b_1_q(52 downto 16));

    -- twoToMiSiYip_uid274_sincosTest(BITSELECT,273)@15
    twoToMiSiYip_uid274_sincosTest_b <= STD_LOGIC_VECTOR(redist34_yip1_15_uid266_sincosTest_b_1_q(52 downto 15));

    -- xip1E_16_uid277_sincosTest(ADDSUB,276)@15
    xip1E_16_uid277_sincosTest_s <= redist33_xMSB_uid268_sincosTest_b_8_q;
    xip1E_16_uid277_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist35_xip1_15_uid265_sincosTest_b_1_q(52)) & redist35_xip1_15_uid265_sincosTest_b_1_q));
    xip1E_16_uid277_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 38 => twoToMiSiYip_uid274_sincosTest_b(37)) & twoToMiSiYip_uid274_sincosTest_b));
    xip1E_16_uid277_sincosTest_combproc: PROCESS (xip1E_16_uid277_sincosTest_a, xip1E_16_uid277_sincosTest_b, xip1E_16_uid277_sincosTest_s)
    BEGIN
        IF (xip1E_16_uid277_sincosTest_s = "1") THEN
            xip1E_16_uid277_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_16_uid277_sincosTest_a) + SIGNED(xip1E_16_uid277_sincosTest_b));
        ELSE
            xip1E_16_uid277_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_16_uid277_sincosTest_a) - SIGNED(xip1E_16_uid277_sincosTest_b));
        END IF;
    END PROCESS;
    xip1E_16_uid277_sincosTest_q <= xip1E_16_uid277_sincosTest_o(53 downto 0);

    -- xip1_16_uid284_sincosTest(BITSELECT,283)@15
    xip1_16_uid284_sincosTest_in <= STD_LOGIC_VECTOR(xip1E_16_uid277_sincosTest_q(52 downto 0));
    xip1_16_uid284_sincosTest_b <= STD_LOGIC_VECTOR(xip1_16_uid284_sincosTest_in(52 downto 0));

    -- redist32_xip1_16_uid284_sincosTest_b_1(DELAY,522)
    redist32_xip1_16_uid284_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_16_uid284_sincosTest_b, xout => redist32_xip1_16_uid284_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- xip1E_17_uid296_sincosTest(ADDSUB,295)@16
    xip1E_17_uid296_sincosTest_s <= redist29_xMSB_uid287_sincosTest_b_8_q;
    xip1E_17_uid296_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist32_xip1_16_uid284_sincosTest_b_1_q(52)) & redist32_xip1_16_uid284_sincosTest_b_1_q));
    xip1E_17_uid296_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 37 => twoToMiSiYip_uid293_sincosTest_b(36)) & twoToMiSiYip_uid293_sincosTest_b));
    xip1E_17_uid296_sincosTest_combproc: PROCESS (xip1E_17_uid296_sincosTest_a, xip1E_17_uid296_sincosTest_b, xip1E_17_uid296_sincosTest_s)
    BEGIN
        IF (xip1E_17_uid296_sincosTest_s = "1") THEN
            xip1E_17_uid296_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_17_uid296_sincosTest_a) + SIGNED(xip1E_17_uid296_sincosTest_b));
        ELSE
            xip1E_17_uid296_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_17_uid296_sincosTest_a) - SIGNED(xip1E_17_uid296_sincosTest_b));
        END IF;
    END PROCESS;
    xip1E_17_uid296_sincosTest_q <= xip1E_17_uid296_sincosTest_o(53 downto 0);

    -- xip1_17_uid303_sincosTest(BITSELECT,302)@16
    xip1_17_uid303_sincosTest_in <= STD_LOGIC_VECTOR(xip1E_17_uid296_sincosTest_q(52 downto 0));
    xip1_17_uid303_sincosTest_b <= STD_LOGIC_VECTOR(xip1_17_uid303_sincosTest_in(52 downto 0));

    -- redist28_xip1_17_uid303_sincosTest_b_1(DELAY,518)
    redist28_xip1_17_uid303_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_17_uid303_sincosTest_b, xout => redist28_xip1_17_uid303_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- twoToMiSiXip_uid311_sincosTest(BITSELECT,310)@17
    twoToMiSiXip_uid311_sincosTest_b <= STD_LOGIC_VECTOR(redist28_xip1_17_uid303_sincosTest_b_1_q(52 downto 17));

    -- signOfSelectionSignal_uid289_sincosTest(LOGICAL,288)@16
    signOfSelectionSignal_uid289_sincosTest_q <= not (redist29_xMSB_uid287_sincosTest_b_8_q);

    -- twoToMiSiXip_uid292_sincosTest(BITSELECT,291)@16
    twoToMiSiXip_uid292_sincosTest_b <= STD_LOGIC_VECTOR(redist32_xip1_16_uid284_sincosTest_b_1_q(52 downto 16));

    -- yip1E_17_uid297_sincosTest(ADDSUB,296)@16
    yip1E_17_uid297_sincosTest_s <= signOfSelectionSignal_uid289_sincosTest_q;
    yip1E_17_uid297_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist31_yip1_16_uid285_sincosTest_b_1_q(52)) & redist31_yip1_16_uid285_sincosTest_b_1_q));
    yip1E_17_uid297_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 37 => twoToMiSiXip_uid292_sincosTest_b(36)) & twoToMiSiXip_uid292_sincosTest_b));
    yip1E_17_uid297_sincosTest_combproc: PROCESS (yip1E_17_uid297_sincosTest_a, yip1E_17_uid297_sincosTest_b, yip1E_17_uid297_sincosTest_s)
    BEGIN
        IF (yip1E_17_uid297_sincosTest_s = "1") THEN
            yip1E_17_uid297_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_17_uid297_sincosTest_a) + SIGNED(yip1E_17_uid297_sincosTest_b));
        ELSE
            yip1E_17_uid297_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_17_uid297_sincosTest_a) - SIGNED(yip1E_17_uid297_sincosTest_b));
        END IF;
    END PROCESS;
    yip1E_17_uid297_sincosTest_q <= yip1E_17_uid297_sincosTest_o(53 downto 0);

    -- yip1_17_uid304_sincosTest(BITSELECT,303)@16
    yip1_17_uid304_sincosTest_in <= STD_LOGIC_VECTOR(yip1E_17_uid297_sincosTest_q(52 downto 0));
    yip1_17_uid304_sincosTest_b <= STD_LOGIC_VECTOR(yip1_17_uid304_sincosTest_in(52 downto 0));

    -- redist27_yip1_17_uid304_sincosTest_b_1(DELAY,517)
    redist27_yip1_17_uid304_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_17_uid304_sincosTest_b, xout => redist27_yip1_17_uid304_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- yip1E_18_uid316_sincosTest(ADDSUB,315)@17
    yip1E_18_uid316_sincosTest_s <= signOfSelectionSignal_uid308_sincosTest_q;
    yip1E_18_uid316_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist27_yip1_17_uid304_sincosTest_b_1_q(52)) & redist27_yip1_17_uid304_sincosTest_b_1_q));
    yip1E_18_uid316_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 36 => twoToMiSiXip_uid311_sincosTest_b(35)) & twoToMiSiXip_uid311_sincosTest_b));
    yip1E_18_uid316_sincosTest_combproc: PROCESS (yip1E_18_uid316_sincosTest_a, yip1E_18_uid316_sincosTest_b, yip1E_18_uid316_sincosTest_s)
    BEGIN
        IF (yip1E_18_uid316_sincosTest_s = "1") THEN
            yip1E_18_uid316_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_18_uid316_sincosTest_a) + SIGNED(yip1E_18_uid316_sincosTest_b));
        ELSE
            yip1E_18_uid316_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_18_uid316_sincosTest_a) - SIGNED(yip1E_18_uid316_sincosTest_b));
        END IF;
    END PROCESS;
    yip1E_18_uid316_sincosTest_q <= yip1E_18_uid316_sincosTest_o(53 downto 0);

    -- yip1_18_uid323_sincosTest(BITSELECT,322)@17
    yip1_18_uid323_sincosTest_in <= STD_LOGIC_VECTOR(yip1E_18_uid316_sincosTest_q(52 downto 0));
    yip1_18_uid323_sincosTest_b <= STD_LOGIC_VECTOR(yip1_18_uid323_sincosTest_in(52 downto 0));

    -- redist24_yip1_18_uid323_sincosTest_b_1(DELAY,514)
    redist24_yip1_18_uid323_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_18_uid323_sincosTest_b, xout => redist24_yip1_18_uid323_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- twoToMiSiYip_uid331_sincosTest(BITSELECT,330)@18
    twoToMiSiYip_uid331_sincosTest_b <= STD_LOGIC_VECTOR(redist24_yip1_18_uid323_sincosTest_b_1_q(52 downto 18));

    -- twoToMiSiYip_uid312_sincosTest(BITSELECT,311)@17
    twoToMiSiYip_uid312_sincosTest_b <= STD_LOGIC_VECTOR(redist27_yip1_17_uid304_sincosTest_b_1_q(52 downto 17));

    -- xip1E_18_uid315_sincosTest(ADDSUB,314)@17
    xip1E_18_uid315_sincosTest_s <= redist26_xMSB_uid306_sincosTest_b_9_q;
    xip1E_18_uid315_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist28_xip1_17_uid303_sincosTest_b_1_q(52)) & redist28_xip1_17_uid303_sincosTest_b_1_q));
    xip1E_18_uid315_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 36 => twoToMiSiYip_uid312_sincosTest_b(35)) & twoToMiSiYip_uid312_sincosTest_b));
    xip1E_18_uid315_sincosTest_combproc: PROCESS (xip1E_18_uid315_sincosTest_a, xip1E_18_uid315_sincosTest_b, xip1E_18_uid315_sincosTest_s)
    BEGIN
        IF (xip1E_18_uid315_sincosTest_s = "1") THEN
            xip1E_18_uid315_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_18_uid315_sincosTest_a) + SIGNED(xip1E_18_uid315_sincosTest_b));
        ELSE
            xip1E_18_uid315_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_18_uid315_sincosTest_a) - SIGNED(xip1E_18_uid315_sincosTest_b));
        END IF;
    END PROCESS;
    xip1E_18_uid315_sincosTest_q <= xip1E_18_uid315_sincosTest_o(53 downto 0);

    -- xip1_18_uid322_sincosTest(BITSELECT,321)@17
    xip1_18_uid322_sincosTest_in <= STD_LOGIC_VECTOR(xip1E_18_uid315_sincosTest_q(52 downto 0));
    xip1_18_uid322_sincosTest_b <= STD_LOGIC_VECTOR(xip1_18_uid322_sincosTest_in(52 downto 0));

    -- redist25_xip1_18_uid322_sincosTest_b_1(DELAY,515)
    redist25_xip1_18_uid322_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_18_uid322_sincosTest_b, xout => redist25_xip1_18_uid322_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- xip1E_19_uid334_sincosTest(ADDSUB,333)@18
    xip1E_19_uid334_sincosTest_s <= redist23_xMSB_uid325_sincosTest_b_10_q;
    xip1E_19_uid334_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist25_xip1_18_uid322_sincosTest_b_1_q(52)) & redist25_xip1_18_uid322_sincosTest_b_1_q));
    xip1E_19_uid334_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 35 => twoToMiSiYip_uid331_sincosTest_b(34)) & twoToMiSiYip_uid331_sincosTest_b));
    xip1E_19_uid334_sincosTest_combproc: PROCESS (xip1E_19_uid334_sincosTest_a, xip1E_19_uid334_sincosTest_b, xip1E_19_uid334_sincosTest_s)
    BEGIN
        IF (xip1E_19_uid334_sincosTest_s = "1") THEN
            xip1E_19_uid334_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_19_uid334_sincosTest_a) + SIGNED(xip1E_19_uid334_sincosTest_b));
        ELSE
            xip1E_19_uid334_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_19_uid334_sincosTest_a) - SIGNED(xip1E_19_uid334_sincosTest_b));
        END IF;
    END PROCESS;
    xip1E_19_uid334_sincosTest_q <= xip1E_19_uid334_sincosTest_o(53 downto 0);

    -- xip1_19_uid341_sincosTest(BITSELECT,340)@18
    xip1_19_uid341_sincosTest_in <= STD_LOGIC_VECTOR(xip1E_19_uid334_sincosTest_q(52 downto 0));
    xip1_19_uid341_sincosTest_b <= STD_LOGIC_VECTOR(xip1_19_uid341_sincosTest_in(52 downto 0));

    -- redist22_xip1_19_uid341_sincosTest_b_1(DELAY,512)
    redist22_xip1_19_uid341_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_19_uid341_sincosTest_b, xout => redist22_xip1_19_uid341_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- twoToMiSiXip_uid349_sincosTest(BITSELECT,348)@19
    twoToMiSiXip_uid349_sincosTest_b <= STD_LOGIC_VECTOR(redist22_xip1_19_uid341_sincosTest_b_1_q(52 downto 19));

    -- signOfSelectionSignal_uid327_sincosTest(LOGICAL,326)@18
    signOfSelectionSignal_uid327_sincosTest_q <= not (redist23_xMSB_uid325_sincosTest_b_10_q);

    -- twoToMiSiXip_uid330_sincosTest(BITSELECT,329)@18
    twoToMiSiXip_uid330_sincosTest_b <= STD_LOGIC_VECTOR(redist25_xip1_18_uid322_sincosTest_b_1_q(52 downto 18));

    -- yip1E_19_uid335_sincosTest(ADDSUB,334)@18
    yip1E_19_uid335_sincosTest_s <= signOfSelectionSignal_uid327_sincosTest_q;
    yip1E_19_uid335_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist24_yip1_18_uid323_sincosTest_b_1_q(52)) & redist24_yip1_18_uid323_sincosTest_b_1_q));
    yip1E_19_uid335_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 35 => twoToMiSiXip_uid330_sincosTest_b(34)) & twoToMiSiXip_uid330_sincosTest_b));
    yip1E_19_uid335_sincosTest_combproc: PROCESS (yip1E_19_uid335_sincosTest_a, yip1E_19_uid335_sincosTest_b, yip1E_19_uid335_sincosTest_s)
    BEGIN
        IF (yip1E_19_uid335_sincosTest_s = "1") THEN
            yip1E_19_uid335_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_19_uid335_sincosTest_a) + SIGNED(yip1E_19_uid335_sincosTest_b));
        ELSE
            yip1E_19_uid335_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_19_uid335_sincosTest_a) - SIGNED(yip1E_19_uid335_sincosTest_b));
        END IF;
    END PROCESS;
    yip1E_19_uid335_sincosTest_q <= yip1E_19_uid335_sincosTest_o(53 downto 0);

    -- yip1_19_uid342_sincosTest(BITSELECT,341)@18
    yip1_19_uid342_sincosTest_in <= STD_LOGIC_VECTOR(yip1E_19_uid335_sincosTest_q(52 downto 0));
    yip1_19_uid342_sincosTest_b <= STD_LOGIC_VECTOR(yip1_19_uid342_sincosTest_in(52 downto 0));

    -- redist21_yip1_19_uid342_sincosTest_b_1(DELAY,511)
    redist21_yip1_19_uid342_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_19_uid342_sincosTest_b, xout => redist21_yip1_19_uid342_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- yip1E_20_uid354_sincosTest(ADDSUB,353)@19
    yip1E_20_uid354_sincosTest_s <= signOfSelectionSignal_uid346_sincosTest_q;
    yip1E_20_uid354_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist21_yip1_19_uid342_sincosTest_b_1_q(52)) & redist21_yip1_19_uid342_sincosTest_b_1_q));
    yip1E_20_uid354_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 34 => twoToMiSiXip_uid349_sincosTest_b(33)) & twoToMiSiXip_uid349_sincosTest_b));
    yip1E_20_uid354_sincosTest_combproc: PROCESS (yip1E_20_uid354_sincosTest_a, yip1E_20_uid354_sincosTest_b, yip1E_20_uid354_sincosTest_s)
    BEGIN
        IF (yip1E_20_uid354_sincosTest_s = "1") THEN
            yip1E_20_uid354_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_20_uid354_sincosTest_a) + SIGNED(yip1E_20_uid354_sincosTest_b));
        ELSE
            yip1E_20_uid354_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_20_uid354_sincosTest_a) - SIGNED(yip1E_20_uid354_sincosTest_b));
        END IF;
    END PROCESS;
    yip1E_20_uid354_sincosTest_q <= yip1E_20_uid354_sincosTest_o(53 downto 0);

    -- yip1_20_uid361_sincosTest(BITSELECT,360)@19
    yip1_20_uid361_sincosTest_in <= STD_LOGIC_VECTOR(yip1E_20_uid354_sincosTest_q(52 downto 0));
    yip1_20_uid361_sincosTest_b <= STD_LOGIC_VECTOR(yip1_20_uid361_sincosTest_in(52 downto 0));

    -- redist17_yip1_20_uid361_sincosTest_b_1(DELAY,507)
    redist17_yip1_20_uid361_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_20_uid361_sincosTest_b, xout => redist17_yip1_20_uid361_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- twoToMiSiYip_uid369_sincosTest(BITSELECT,368)@20
    twoToMiSiYip_uid369_sincosTest_b <= STD_LOGIC_VECTOR(redist17_yip1_20_uid361_sincosTest_b_1_q(52 downto 20));

    -- twoToMiSiYip_uid350_sincosTest(BITSELECT,349)@19
    twoToMiSiYip_uid350_sincosTest_b <= STD_LOGIC_VECTOR(redist21_yip1_19_uid342_sincosTest_b_1_q(52 downto 19));

    -- xip1E_20_uid353_sincosTest(ADDSUB,352)@19
    xip1E_20_uid353_sincosTest_s <= redist19_xMSB_uid344_sincosTest_b_10_q;
    xip1E_20_uid353_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist22_xip1_19_uid341_sincosTest_b_1_q(52)) & redist22_xip1_19_uid341_sincosTest_b_1_q));
    xip1E_20_uid353_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 34 => twoToMiSiYip_uid350_sincosTest_b(33)) & twoToMiSiYip_uid350_sincosTest_b));
    xip1E_20_uid353_sincosTest_combproc: PROCESS (xip1E_20_uid353_sincosTest_a, xip1E_20_uid353_sincosTest_b, xip1E_20_uid353_sincosTest_s)
    BEGIN
        IF (xip1E_20_uid353_sincosTest_s = "1") THEN
            xip1E_20_uid353_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_20_uid353_sincosTest_a) + SIGNED(xip1E_20_uid353_sincosTest_b));
        ELSE
            xip1E_20_uid353_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_20_uid353_sincosTest_a) - SIGNED(xip1E_20_uid353_sincosTest_b));
        END IF;
    END PROCESS;
    xip1E_20_uid353_sincosTest_q <= xip1E_20_uid353_sincosTest_o(53 downto 0);

    -- xip1_20_uid360_sincosTest(BITSELECT,359)@19
    xip1_20_uid360_sincosTest_in <= STD_LOGIC_VECTOR(xip1E_20_uid353_sincosTest_q(52 downto 0));
    xip1_20_uid360_sincosTest_b <= STD_LOGIC_VECTOR(xip1_20_uid360_sincosTest_in(52 downto 0));

    -- redist18_xip1_20_uid360_sincosTest_b_1(DELAY,508)
    redist18_xip1_20_uid360_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_20_uid360_sincosTest_b, xout => redist18_xip1_20_uid360_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- xip1E_21_uid372_sincosTest(ADDSUB,371)@20
    xip1E_21_uid372_sincosTest_s <= redist16_xMSB_uid363_sincosTest_b_11_q;
    xip1E_21_uid372_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist18_xip1_20_uid360_sincosTest_b_1_q(52)) & redist18_xip1_20_uid360_sincosTest_b_1_q));
    xip1E_21_uid372_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 33 => twoToMiSiYip_uid369_sincosTest_b(32)) & twoToMiSiYip_uid369_sincosTest_b));
    xip1E_21_uid372_sincosTest_combproc: PROCESS (xip1E_21_uid372_sincosTest_a, xip1E_21_uid372_sincosTest_b, xip1E_21_uid372_sincosTest_s)
    BEGIN
        IF (xip1E_21_uid372_sincosTest_s = "1") THEN
            xip1E_21_uid372_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_21_uid372_sincosTest_a) + SIGNED(xip1E_21_uid372_sincosTest_b));
        ELSE
            xip1E_21_uid372_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_21_uid372_sincosTest_a) - SIGNED(xip1E_21_uid372_sincosTest_b));
        END IF;
    END PROCESS;
    xip1E_21_uid372_sincosTest_q <= xip1E_21_uid372_sincosTest_o(53 downto 0);

    -- xip1_21_uid379_sincosTest(BITSELECT,378)@20
    xip1_21_uid379_sincosTest_in <= STD_LOGIC_VECTOR(xip1E_21_uid372_sincosTest_q(52 downto 0));
    xip1_21_uid379_sincosTest_b <= STD_LOGIC_VECTOR(xip1_21_uid379_sincosTest_in(52 downto 0));

    -- redist15_xip1_21_uid379_sincosTest_b_1(DELAY,505)
    redist15_xip1_21_uid379_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_21_uid379_sincosTest_b, xout => redist15_xip1_21_uid379_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- twoToMiSiXip_uid387_sincosTest(BITSELECT,386)@21
    twoToMiSiXip_uid387_sincosTest_b <= STD_LOGIC_VECTOR(redist15_xip1_21_uid379_sincosTest_b_1_q(52 downto 21));

    -- signOfSelectionSignal_uid365_sincosTest(LOGICAL,364)@20
    signOfSelectionSignal_uid365_sincosTest_q <= not (redist16_xMSB_uid363_sincosTest_b_11_q);

    -- twoToMiSiXip_uid368_sincosTest(BITSELECT,367)@20
    twoToMiSiXip_uid368_sincosTest_b <= STD_LOGIC_VECTOR(redist18_xip1_20_uid360_sincosTest_b_1_q(52 downto 20));

    -- yip1E_21_uid373_sincosTest(ADDSUB,372)@20
    yip1E_21_uid373_sincosTest_s <= signOfSelectionSignal_uid365_sincosTest_q;
    yip1E_21_uid373_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist17_yip1_20_uid361_sincosTest_b_1_q(52)) & redist17_yip1_20_uid361_sincosTest_b_1_q));
    yip1E_21_uid373_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 33 => twoToMiSiXip_uid368_sincosTest_b(32)) & twoToMiSiXip_uid368_sincosTest_b));
    yip1E_21_uid373_sincosTest_combproc: PROCESS (yip1E_21_uid373_sincosTest_a, yip1E_21_uid373_sincosTest_b, yip1E_21_uid373_sincosTest_s)
    BEGIN
        IF (yip1E_21_uid373_sincosTest_s = "1") THEN
            yip1E_21_uid373_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_21_uid373_sincosTest_a) + SIGNED(yip1E_21_uid373_sincosTest_b));
        ELSE
            yip1E_21_uid373_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_21_uid373_sincosTest_a) - SIGNED(yip1E_21_uid373_sincosTest_b));
        END IF;
    END PROCESS;
    yip1E_21_uid373_sincosTest_q <= yip1E_21_uid373_sincosTest_o(53 downto 0);

    -- yip1_21_uid380_sincosTest(BITSELECT,379)@20
    yip1_21_uid380_sincosTest_in <= STD_LOGIC_VECTOR(yip1E_21_uid373_sincosTest_q(52 downto 0));
    yip1_21_uid380_sincosTest_b <= STD_LOGIC_VECTOR(yip1_21_uid380_sincosTest_in(52 downto 0));

    -- redist14_yip1_21_uid380_sincosTest_b_1(DELAY,504)
    redist14_yip1_21_uid380_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_21_uid380_sincosTest_b, xout => redist14_yip1_21_uid380_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- yip1E_22_uid392_sincosTest(ADDSUB,391)@21
    yip1E_22_uid392_sincosTest_s <= signOfSelectionSignal_uid384_sincosTest_q;
    yip1E_22_uid392_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist14_yip1_21_uid380_sincosTest_b_1_q(52)) & redist14_yip1_21_uid380_sincosTest_b_1_q));
    yip1E_22_uid392_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 32 => twoToMiSiXip_uid387_sincosTest_b(31)) & twoToMiSiXip_uid387_sincosTest_b));
    yip1E_22_uid392_sincosTest_combproc: PROCESS (yip1E_22_uid392_sincosTest_a, yip1E_22_uid392_sincosTest_b, yip1E_22_uid392_sincosTest_s)
    BEGIN
        IF (yip1E_22_uid392_sincosTest_s = "1") THEN
            yip1E_22_uid392_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_22_uid392_sincosTest_a) + SIGNED(yip1E_22_uid392_sincosTest_b));
        ELSE
            yip1E_22_uid392_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_22_uid392_sincosTest_a) - SIGNED(yip1E_22_uid392_sincosTest_b));
        END IF;
    END PROCESS;
    yip1E_22_uid392_sincosTest_q <= yip1E_22_uid392_sincosTest_o(53 downto 0);

    -- yip1_22_uid399_sincosTest(BITSELECT,398)@21
    yip1_22_uid399_sincosTest_in <= STD_LOGIC_VECTOR(yip1E_22_uid392_sincosTest_q(52 downto 0));
    yip1_22_uid399_sincosTest_b <= STD_LOGIC_VECTOR(yip1_22_uid399_sincosTest_in(52 downto 0));

    -- redist11_yip1_22_uid399_sincosTest_b_1(DELAY,501)
    redist11_yip1_22_uid399_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_22_uid399_sincosTest_b, xout => redist11_yip1_22_uid399_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- twoToMiSiYip_uid407_sincosTest(BITSELECT,406)@22
    twoToMiSiYip_uid407_sincosTest_b <= STD_LOGIC_VECTOR(redist11_yip1_22_uid399_sincosTest_b_1_q(52 downto 22));

    -- twoToMiSiYip_uid388_sincosTest(BITSELECT,387)@21
    twoToMiSiYip_uid388_sincosTest_b <= STD_LOGIC_VECTOR(redist14_yip1_21_uid380_sincosTest_b_1_q(52 downto 21));

    -- xip1E_22_uid391_sincosTest(ADDSUB,390)@21
    xip1E_22_uid391_sincosTest_s <= redist13_xMSB_uid382_sincosTest_b_12_q;
    xip1E_22_uid391_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist15_xip1_21_uid379_sincosTest_b_1_q(52)) & redist15_xip1_21_uid379_sincosTest_b_1_q));
    xip1E_22_uid391_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 32 => twoToMiSiYip_uid388_sincosTest_b(31)) & twoToMiSiYip_uid388_sincosTest_b));
    xip1E_22_uid391_sincosTest_combproc: PROCESS (xip1E_22_uid391_sincosTest_a, xip1E_22_uid391_sincosTest_b, xip1E_22_uid391_sincosTest_s)
    BEGIN
        IF (xip1E_22_uid391_sincosTest_s = "1") THEN
            xip1E_22_uid391_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_22_uid391_sincosTest_a) + SIGNED(xip1E_22_uid391_sincosTest_b));
        ELSE
            xip1E_22_uid391_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_22_uid391_sincosTest_a) - SIGNED(xip1E_22_uid391_sincosTest_b));
        END IF;
    END PROCESS;
    xip1E_22_uid391_sincosTest_q <= xip1E_22_uid391_sincosTest_o(53 downto 0);

    -- xip1_22_uid398_sincosTest(BITSELECT,397)@21
    xip1_22_uid398_sincosTest_in <= STD_LOGIC_VECTOR(xip1E_22_uid391_sincosTest_q(52 downto 0));
    xip1_22_uid398_sincosTest_b <= STD_LOGIC_VECTOR(xip1_22_uid398_sincosTest_in(52 downto 0));

    -- redist12_xip1_22_uid398_sincosTest_b_1(DELAY,502)
    redist12_xip1_22_uid398_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_22_uid398_sincosTest_b, xout => redist12_xip1_22_uid398_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- xip1E_23_uid410_sincosTest(ADDSUB,409)@22
    xip1E_23_uid410_sincosTest_s <= redist9_xMSB_uid401_sincosTest_b_12_q;
    xip1E_23_uid410_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist12_xip1_22_uid398_sincosTest_b_1_q(52)) & redist12_xip1_22_uid398_sincosTest_b_1_q));
    xip1E_23_uid410_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 31 => twoToMiSiYip_uid407_sincosTest_b(30)) & twoToMiSiYip_uid407_sincosTest_b));
    xip1E_23_uid410_sincosTest_combproc: PROCESS (xip1E_23_uid410_sincosTest_a, xip1E_23_uid410_sincosTest_b, xip1E_23_uid410_sincosTest_s)
    BEGIN
        IF (xip1E_23_uid410_sincosTest_s = "1") THEN
            xip1E_23_uid410_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_23_uid410_sincosTest_a) + SIGNED(xip1E_23_uid410_sincosTest_b));
        ELSE
            xip1E_23_uid410_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_23_uid410_sincosTest_a) - SIGNED(xip1E_23_uid410_sincosTest_b));
        END IF;
    END PROCESS;
    xip1E_23_uid410_sincosTest_q <= xip1E_23_uid410_sincosTest_o(53 downto 0);

    -- xip1_23_uid417_sincosTest(BITSELECT,416)@22
    xip1_23_uid417_sincosTest_in <= STD_LOGIC_VECTOR(xip1E_23_uid410_sincosTest_q(52 downto 0));
    xip1_23_uid417_sincosTest_b <= STD_LOGIC_VECTOR(xip1_23_uid417_sincosTest_in(52 downto 0));

    -- redist8_xip1_23_uid417_sincosTest_b_1(DELAY,498)
    redist8_xip1_23_uid417_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_23_uid417_sincosTest_b, xout => redist8_xip1_23_uid417_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- twoToMiSiXip_uid425_sincosTest(BITSELECT,424)@23
    twoToMiSiXip_uid425_sincosTest_b <= STD_LOGIC_VECTOR(redist8_xip1_23_uid417_sincosTest_b_1_q(52 downto 23));

    -- signOfSelectionSignal_uid403_sincosTest(LOGICAL,402)@22
    signOfSelectionSignal_uid403_sincosTest_q <= not (redist9_xMSB_uid401_sincosTest_b_12_q);

    -- twoToMiSiXip_uid406_sincosTest(BITSELECT,405)@22
    twoToMiSiXip_uid406_sincosTest_b <= STD_LOGIC_VECTOR(redist12_xip1_22_uid398_sincosTest_b_1_q(52 downto 22));

    -- yip1E_23_uid411_sincosTest(ADDSUB,410)@22
    yip1E_23_uid411_sincosTest_s <= signOfSelectionSignal_uid403_sincosTest_q;
    yip1E_23_uid411_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist11_yip1_22_uid399_sincosTest_b_1_q(52)) & redist11_yip1_22_uid399_sincosTest_b_1_q));
    yip1E_23_uid411_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 31 => twoToMiSiXip_uid406_sincosTest_b(30)) & twoToMiSiXip_uid406_sincosTest_b));
    yip1E_23_uid411_sincosTest_combproc: PROCESS (yip1E_23_uid411_sincosTest_a, yip1E_23_uid411_sincosTest_b, yip1E_23_uid411_sincosTest_s)
    BEGIN
        IF (yip1E_23_uid411_sincosTest_s = "1") THEN
            yip1E_23_uid411_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_23_uid411_sincosTest_a) + SIGNED(yip1E_23_uid411_sincosTest_b));
        ELSE
            yip1E_23_uid411_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_23_uid411_sincosTest_a) - SIGNED(yip1E_23_uid411_sincosTest_b));
        END IF;
    END PROCESS;
    yip1E_23_uid411_sincosTest_q <= yip1E_23_uid411_sincosTest_o(53 downto 0);

    -- yip1_23_uid418_sincosTest(BITSELECT,417)@22
    yip1_23_uid418_sincosTest_in <= STD_LOGIC_VECTOR(yip1E_23_uid411_sincosTest_q(52 downto 0));
    yip1_23_uid418_sincosTest_b <= STD_LOGIC_VECTOR(yip1_23_uid418_sincosTest_in(52 downto 0));

    -- redist7_yip1_23_uid418_sincosTest_b_1(DELAY,497)
    redist7_yip1_23_uid418_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_23_uid418_sincosTest_b, xout => redist7_yip1_23_uid418_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- yip1E_24_uid430_sincosTest(ADDSUB,429)@23
    yip1E_24_uid430_sincosTest_s <= signOfSelectionSignal_uid422_sincosTest_q;
    yip1E_24_uid430_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist7_yip1_23_uid418_sincosTest_b_1_q(52)) & redist7_yip1_23_uid418_sincosTest_b_1_q));
    yip1E_24_uid430_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 30 => twoToMiSiXip_uid425_sincosTest_b(29)) & twoToMiSiXip_uid425_sincosTest_b));
    yip1E_24_uid430_sincosTest_combproc: PROCESS (yip1E_24_uid430_sincosTest_a, yip1E_24_uid430_sincosTest_b, yip1E_24_uid430_sincosTest_s)
    BEGIN
        IF (yip1E_24_uid430_sincosTest_s = "1") THEN
            yip1E_24_uid430_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_24_uid430_sincosTest_a) + SIGNED(yip1E_24_uid430_sincosTest_b));
        ELSE
            yip1E_24_uid430_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_24_uid430_sincosTest_a) - SIGNED(yip1E_24_uid430_sincosTest_b));
        END IF;
    END PROCESS;
    yip1E_24_uid430_sincosTest_q <= yip1E_24_uid430_sincosTest_o(53 downto 0);

    -- yip1_24_uid437_sincosTest(BITSELECT,436)@23
    yip1_24_uid437_sincosTest_in <= STD_LOGIC_VECTOR(yip1E_24_uid430_sincosTest_q(52 downto 0));
    yip1_24_uid437_sincosTest_b <= STD_LOGIC_VECTOR(yip1_24_uid437_sincosTest_in(52 downto 0));

    -- redist4_yip1_24_uid437_sincosTest_b_1(DELAY,494)
    redist4_yip1_24_uid437_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_24_uid437_sincosTest_b, xout => redist4_yip1_24_uid437_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- twoToMiSiYip_uid445_sincosTest(BITSELECT,444)@24
    twoToMiSiYip_uid445_sincosTest_b <= STD_LOGIC_VECTOR(redist4_yip1_24_uid437_sincosTest_b_1_q(52 downto 24));

    -- twoToMiSiYip_uid426_sincosTest(BITSELECT,425)@23
    twoToMiSiYip_uid426_sincosTest_b <= STD_LOGIC_VECTOR(redist7_yip1_23_uid418_sincosTest_b_1_q(52 downto 23));

    -- xip1E_24_uid429_sincosTest(ADDSUB,428)@23
    xip1E_24_uid429_sincosTest_s <= redist6_xMSB_uid420_sincosTest_b_13_q;
    xip1E_24_uid429_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist8_xip1_23_uid417_sincosTest_b_1_q(52)) & redist8_xip1_23_uid417_sincosTest_b_1_q));
    xip1E_24_uid429_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 30 => twoToMiSiYip_uid426_sincosTest_b(29)) & twoToMiSiYip_uid426_sincosTest_b));
    xip1E_24_uid429_sincosTest_combproc: PROCESS (xip1E_24_uid429_sincosTest_a, xip1E_24_uid429_sincosTest_b, xip1E_24_uid429_sincosTest_s)
    BEGIN
        IF (xip1E_24_uid429_sincosTest_s = "1") THEN
            xip1E_24_uid429_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_24_uid429_sincosTest_a) + SIGNED(xip1E_24_uid429_sincosTest_b));
        ELSE
            xip1E_24_uid429_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_24_uid429_sincosTest_a) - SIGNED(xip1E_24_uid429_sincosTest_b));
        END IF;
    END PROCESS;
    xip1E_24_uid429_sincosTest_q <= xip1E_24_uid429_sincosTest_o(53 downto 0);

    -- xip1_24_uid436_sincosTest(BITSELECT,435)@23
    xip1_24_uid436_sincosTest_in <= STD_LOGIC_VECTOR(xip1E_24_uid429_sincosTest_q(52 downto 0));
    xip1_24_uid436_sincosTest_b <= STD_LOGIC_VECTOR(xip1_24_uid436_sincosTest_in(52 downto 0));

    -- redist5_xip1_24_uid436_sincosTest_b_1(DELAY,495)
    redist5_xip1_24_uid436_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_24_uid436_sincosTest_b, xout => redist5_xip1_24_uid436_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- xip1E_25_uid448_sincosTest(ADDSUB,447)@24
    xip1E_25_uid448_sincosTest_s <= redist3_xMSB_uid439_sincosTest_b_14_q;
    xip1E_25_uid448_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist5_xip1_24_uid436_sincosTest_b_1_q(52)) & redist5_xip1_24_uid436_sincosTest_b_1_q));
    xip1E_25_uid448_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 29 => twoToMiSiYip_uid445_sincosTest_b(28)) & twoToMiSiYip_uid445_sincosTest_b));
    xip1E_25_uid448_sincosTest_combproc: PROCESS (xip1E_25_uid448_sincosTest_a, xip1E_25_uid448_sincosTest_b, xip1E_25_uid448_sincosTest_s)
    BEGIN
        IF (xip1E_25_uid448_sincosTest_s = "1") THEN
            xip1E_25_uid448_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_25_uid448_sincosTest_a) + SIGNED(xip1E_25_uid448_sincosTest_b));
        ELSE
            xip1E_25_uid448_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_25_uid448_sincosTest_a) - SIGNED(xip1E_25_uid448_sincosTest_b));
        END IF;
    END PROCESS;
    xip1E_25_uid448_sincosTest_q <= xip1E_25_uid448_sincosTest_o(53 downto 0);

    -- xip1_25_uid455_sincosTest(BITSELECT,454)@24
    xip1_25_uid455_sincosTest_in <= STD_LOGIC_VECTOR(xip1E_25_uid448_sincosTest_q(52 downto 0));
    xip1_25_uid455_sincosTest_b <= STD_LOGIC_VECTOR(xip1_25_uid455_sincosTest_in(52 downto 0));

    -- redist2_xip1_25_uid455_sincosTest_b_1(DELAY,492)
    redist2_xip1_25_uid455_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_25_uid455_sincosTest_b, xout => redist2_xip1_25_uid455_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- twoToMiSiXip_uid463_sincosTest(BITSELECT,462)@25
    twoToMiSiXip_uid463_sincosTest_b <= STD_LOGIC_VECTOR(redist2_xip1_25_uid455_sincosTest_b_1_q(52 downto 25));

    -- signOfSelectionSignal_uid441_sincosTest(LOGICAL,440)@24
    signOfSelectionSignal_uid441_sincosTest_q <= not (redist3_xMSB_uid439_sincosTest_b_14_q);

    -- twoToMiSiXip_uid444_sincosTest(BITSELECT,443)@24
    twoToMiSiXip_uid444_sincosTest_b <= STD_LOGIC_VECTOR(redist5_xip1_24_uid436_sincosTest_b_1_q(52 downto 24));

    -- yip1E_25_uid449_sincosTest(ADDSUB,448)@24
    yip1E_25_uid449_sincosTest_s <= signOfSelectionSignal_uid441_sincosTest_q;
    yip1E_25_uid449_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist4_yip1_24_uid437_sincosTest_b_1_q(52)) & redist4_yip1_24_uid437_sincosTest_b_1_q));
    yip1E_25_uid449_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 29 => twoToMiSiXip_uid444_sincosTest_b(28)) & twoToMiSiXip_uid444_sincosTest_b));
    yip1E_25_uid449_sincosTest_combproc: PROCESS (yip1E_25_uid449_sincosTest_a, yip1E_25_uid449_sincosTest_b, yip1E_25_uid449_sincosTest_s)
    BEGIN
        IF (yip1E_25_uid449_sincosTest_s = "1") THEN
            yip1E_25_uid449_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_25_uid449_sincosTest_a) + SIGNED(yip1E_25_uid449_sincosTest_b));
        ELSE
            yip1E_25_uid449_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_25_uid449_sincosTest_a) - SIGNED(yip1E_25_uid449_sincosTest_b));
        END IF;
    END PROCESS;
    yip1E_25_uid449_sincosTest_q <= yip1E_25_uid449_sincosTest_o(53 downto 0);

    -- yip1_25_uid456_sincosTest(BITSELECT,455)@24
    yip1_25_uid456_sincosTest_in <= STD_LOGIC_VECTOR(yip1E_25_uid449_sincosTest_q(52 downto 0));
    yip1_25_uid456_sincosTest_b <= STD_LOGIC_VECTOR(yip1_25_uid456_sincosTest_in(52 downto 0));

    -- redist1_yip1_25_uid456_sincosTest_b_1(DELAY,491)
    redist1_yip1_25_uid456_sincosTest_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_25_uid456_sincosTest_b, xout => redist1_yip1_25_uid456_sincosTest_b_1_q, clk => clk, aclr => areset );

    -- yip1E_26_uid468_sincosTest(ADDSUB,467)@25
    yip1E_26_uid468_sincosTest_s <= signOfSelectionSignal_uid460_sincosTest_q;
    yip1E_26_uid468_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist1_yip1_25_uid456_sincosTest_b_1_q(52)) & redist1_yip1_25_uid456_sincosTest_b_1_q));
    yip1E_26_uid468_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 28 => twoToMiSiXip_uid463_sincosTest_b(27)) & twoToMiSiXip_uid463_sincosTest_b));
    yip1E_26_uid468_sincosTest_combproc: PROCESS (yip1E_26_uid468_sincosTest_a, yip1E_26_uid468_sincosTest_b, yip1E_26_uid468_sincosTest_s)
    BEGIN
        IF (yip1E_26_uid468_sincosTest_s = "1") THEN
            yip1E_26_uid468_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_26_uid468_sincosTest_a) + SIGNED(yip1E_26_uid468_sincosTest_b));
        ELSE
            yip1E_26_uid468_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_26_uid468_sincosTest_a) - SIGNED(yip1E_26_uid468_sincosTest_b));
        END IF;
    END PROCESS;
    yip1E_26_uid468_sincosTest_q <= yip1E_26_uid468_sincosTest_o(53 downto 0);

    -- yip1_26_uid475_sincosTest(BITSELECT,474)@25
    yip1_26_uid475_sincosTest_in <= STD_LOGIC_VECTOR(yip1E_26_uid468_sincosTest_q(52 downto 0));
    yip1_26_uid475_sincosTest_b <= STD_LOGIC_VECTOR(yip1_26_uid475_sincosTest_in(52 downto 0));

    -- ySumPreRnd_uid481_sincosTest(BITSELECT,480)@25
    ySumPreRnd_uid481_sincosTest_in <= yip1_26_uid475_sincosTest_b(50 downto 0);
    ySumPreRnd_uid481_sincosTest_b <= ySumPreRnd_uid481_sincosTest_in(50 downto 25);

    -- ySumPostRnd_uid484_sincosTest(ADD,483)@25
    ySumPostRnd_uid484_sincosTest_a <= STD_LOGIC_VECTOR("0" & ySumPreRnd_uid481_sincosTest_b);
    ySumPostRnd_uid484_sincosTest_b <= STD_LOGIC_VECTOR("00000000000000000000000000" & VCC_q);
    ySumPostRnd_uid484_sincosTest_o <= STD_LOGIC_VECTOR(UNSIGNED(ySumPostRnd_uid484_sincosTest_a) + UNSIGNED(ySumPostRnd_uid484_sincosTest_b));
    ySumPostRnd_uid484_sincosTest_q <= ySumPostRnd_uid484_sincosTest_o(26 downto 0);

    -- yPostExc_uid486_sincosTest(BITSELECT,485)@25
    yPostExc_uid486_sincosTest_in <= ySumPostRnd_uid484_sincosTest_q(25 downto 0);
    yPostExc_uid486_sincosTest_b <= yPostExc_uid486_sincosTest_in(25 downto 1);

    -- twoToMiSiYip_uid464_sincosTest(BITSELECT,463)@25
    twoToMiSiYip_uid464_sincosTest_b <= STD_LOGIC_VECTOR(redist1_yip1_25_uid456_sincosTest_b_1_q(52 downto 25));

    -- xip1E_26_uid467_sincosTest(ADDSUB,466)@25
    xip1E_26_uid467_sincosTest_s <= redist0_xMSB_uid458_sincosTest_b_15_q;
    xip1E_26_uid467_sincosTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 53 => redist2_xip1_25_uid455_sincosTest_b_1_q(52)) & redist2_xip1_25_uid455_sincosTest_b_1_q));
    xip1E_26_uid467_sincosTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 28 => twoToMiSiYip_uid464_sincosTest_b(27)) & twoToMiSiYip_uid464_sincosTest_b));
    xip1E_26_uid467_sincosTest_combproc: PROCESS (xip1E_26_uid467_sincosTest_a, xip1E_26_uid467_sincosTest_b, xip1E_26_uid467_sincosTest_s)
    BEGIN
        IF (xip1E_26_uid467_sincosTest_s = "1") THEN
            xip1E_26_uid467_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_26_uid467_sincosTest_a) + SIGNED(xip1E_26_uid467_sincosTest_b));
        ELSE
            xip1E_26_uid467_sincosTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_26_uid467_sincosTest_a) - SIGNED(xip1E_26_uid467_sincosTest_b));
        END IF;
    END PROCESS;
    xip1E_26_uid467_sincosTest_q <= xip1E_26_uid467_sincosTest_o(53 downto 0);

    -- xip1_26_uid474_sincosTest(BITSELECT,473)@25
    xip1_26_uid474_sincosTest_in <= STD_LOGIC_VECTOR(xip1E_26_uid467_sincosTest_q(52 downto 0));
    xip1_26_uid474_sincosTest_b <= STD_LOGIC_VECTOR(xip1_26_uid474_sincosTest_in(52 downto 0));

    -- xSumPreRnd_uid477_sincosTest(BITSELECT,476)@25
    xSumPreRnd_uid477_sincosTest_in <= xip1_26_uid474_sincosTest_b(50 downto 0);
    xSumPreRnd_uid477_sincosTest_b <= xSumPreRnd_uid477_sincosTest_in(50 downto 25);

    -- xSumPostRnd_uid480_sincosTest(ADD,479)@25
    xSumPostRnd_uid480_sincosTest_a <= STD_LOGIC_VECTOR("0" & xSumPreRnd_uid477_sincosTest_b);
    xSumPostRnd_uid480_sincosTest_b <= STD_LOGIC_VECTOR("00000000000000000000000000" & VCC_q);
    xSumPostRnd_uid480_sincosTest_o <= STD_LOGIC_VECTOR(UNSIGNED(xSumPostRnd_uid480_sincosTest_a) + UNSIGNED(xSumPostRnd_uid480_sincosTest_b));
    xSumPostRnd_uid480_sincosTest_q <= xSumPostRnd_uid480_sincosTest_o(26 downto 0);

    -- xPostExc_uid485_sincosTest(BITSELECT,484)@25
    xPostExc_uid485_sincosTest_in <= xSumPostRnd_uid480_sincosTest_q(25 downto 0);
    xPostExc_uid485_sincosTest_b <= xPostExc_uid485_sincosTest_in(25 downto 1);

    -- xOut(GPOUT,4)@25
    c <= xPostExc_uid485_sincosTest_b;
    s <= yPostExc_uid486_sincosTest_b;

END normal;
