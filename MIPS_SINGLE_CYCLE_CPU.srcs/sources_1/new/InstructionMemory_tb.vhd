------------------------------------------------------
-- Class:    ECE 524 L                              --
-- Engineer: Ben Cooper                             --
--                                                  --
-- Create Date: 12/01/22                            --
-- Module Name: InstructionMemory_tb.vhd            --
--                                                  --
-- Dependencies: InstructionMemory.vhd              --
--                                                  --
------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity InstructionMemory_tb is
--  Port ( );
end InstructionMemory_tb;

architecture Behavioral of InstructionMemory_tb is

    component InstructionMemory is
        generic(
            width: INTEGER := 32;
            addr : INTEGER := 8;
            depth: INTEGER := 2**8 );
        port(
            Address   : in STD_LOGIC_VECTOR (addr-1 downto 0);
            Instruction  : out STD_LOGIC_VECTOR (31 downto 0) );
    end component InstructionMemory;

    signal Address_tb: std_logic_vector(7 downto 0);
    signal Instruction_tb: std_logic_vector(31 downto 0);

begin

    IMem: InstructionMemory generic map(width => 32, addr => 8, depth => 2**8)
                            port map(Address => Address_tb, Instruction => Instruction_tb);

end Behavioral;
