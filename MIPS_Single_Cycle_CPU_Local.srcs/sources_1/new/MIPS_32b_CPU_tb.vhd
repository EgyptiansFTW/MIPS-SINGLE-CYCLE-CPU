------------------------------------------------------
-- Class:    ECE 524 L                              --
-- Engineer: Ben Cooper                             --
--                                                  --
-- Create Date: 12/11/22                            --
-- Module Name: 32b_MIPS_CPU_tb.vhd                 --
--                                                  --
-- Dependencies: Datapath.vhd, ALU_CONTROL.vhd      --
--               Adder.vhd, ALU.vhd, SignExtend.vhd --
--               ShiftRegister.vhd, Registers.vhd   --
--               InstructionMemory.vhd              --
--               DataMemory.vhd, 32b_MIPS_CPU.vhd   --
------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.ComponentPkg.ALL;

entity MIPS_32b_CPU_tb is
--  Port ( );
end MIPS_32b_CPU_tb;

architecture Behavioral of MIPS_32b_CPU_tb is

    component MIPS_32b_CPU is
        port(
            clk: in std_logic
        );
    end component MIPS_32b_CPU;
    
--    signal Instruction: std_logic_vector(31 downto 0) := (others => '0');
    
    signal clk_tb: std_logic := '0';

begin

    MIPS_CPU: MIPS_32b_CPU port map (clk => clk_tb);

--    Instruction <= << signal .MIPS_32b_CPU.Datapath.Instruction_DP: std_logic_vector(31 downto 0) >>;

    process
    begin
        wait for 8ns;
        clk_tb <= NOT clk_tb;
    end process;

end Behavioral;
