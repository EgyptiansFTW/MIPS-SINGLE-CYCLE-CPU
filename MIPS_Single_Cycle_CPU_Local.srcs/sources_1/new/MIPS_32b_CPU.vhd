------------------------------------------------------
-- Class:    ECE 524 L                              --
-- Engineer: Ben Cooper                             --
--                                                  --
-- Create Date: 12/11/22                            --
-- Module Name: 32b_MIPS_CPU.vhd                    --
--                                                  --
-- Dependencies: Datapath.vhd, ALU_CONTROL.vhd      --
--               Adder.vhd, ALU.vhd, SignExtend.vhd --
--               ShiftRegister.vhd, Registers.vhd   --
--               InstructionMemory.vhd              --
--               DataMemory.vhd                     --
------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MIPS_32b_CPU is
    port(
        clk: in std_logic
    );
end MIPS_32b_CPU;

architecture Behavioral of MIPS_32b_CPU is

    component Datapath is
        port(
            signal CLK_in   : in std_logic;
            signal RegDst   : in std_logic;      --Control Sig
            signal JUMP     : in std_logic;      --Control Sig
            signal BRANCH   : in std_logic;      --Control Sig
            signal MemToReg : in std_logic;      --Control Sig
            signal ALUSrc   : in std_logic;      --Control Sig
            signal MemWrite : in STD_LOGIC;      --Control Sig  
            signal MemRead  : in STD_LOGIC;      --Control Sig
            signal RegWrite : in STD_LOGIC;      --Control Sig
            signal ALUOP_DP : in std_logic_vector(1 downto 0); --Control Sig
            signal OPCODE_DP: out std_logic_vector(5 downto 0) --INST(31-26)
            );
    end component Datapath;

    component control is
        port(
            signal OPCODE : in std_logic_vector(5 downto 0);
            signal REGDST, ALUSRC, MEMTOREG, REGWRITE, MEMREAD : out std_logic;
            signal MEMWRITE, BRANCH, JUMP: out std_logic;
            signal ALUOP : out std_logic_vector(1 downto 0)  
        );
    end component control;

    signal RegDst_top  : std_logic;      --Control Sig
    signal JUMP_top    : std_logic;      --Control Sig
    signal BRANCH_top  : std_logic;      --Control Sig
    signal MemToReg_top: std_logic;      --Control Sig
    signal ALUSrc_top  : std_logic;      --Control Sig
    signal MemWrite_top: STD_LOGIC;      --Control Sig  
    signal MemRead_top : STD_LOGIC;      --Control Sig
    signal RegWrite_top: STD_LOGIC;      --Control Sig
    signal ALUOP_top   : std_logic_vector(1 downto 0); --Control Sig
    signal OPCODE_top  : std_logic_vector(5 downto 0); --INST(31-26)

begin

    DataPath_MIPS: Datapath port map (CLK_in => clk,
                                      RegDst => RegDst_top,
                                      JUMP => JUMP_top,
                                      BRANCH => BRANCH_top,
                                      MemToReg => MemToReg_top,
                                      ALUSrc => ALUSrc_top,
                                      MemWrite => MemWrite_top, 
                                      MemRead => MemRead_top,
                                      RegWrite => RegWrite_top,
                                      ALUOP_DP => ALUOP_top,
                                      OPCODE_DP => OPCODE_top);
    
    Control_MIPS: control port map (OPCODE => OPCODE_top,
                                    REGDST => RegDst_top,
                                    ALUSRC => ALUSrc_top,
                                    MEMTOREG => MemToReg_top,
                                    REGWRITE => RegWrite_top,
                                    MEMREAD => MemRead_top,
                                    MEMWRITE => MemWrite_top,
                                    BRANCH => BRANCH_top,
                                    JUMP => JUMP_top,
                                    ALUOP => ALUOP_top);
                        
end Behavioral;
