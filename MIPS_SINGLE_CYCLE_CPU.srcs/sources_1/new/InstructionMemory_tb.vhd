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
            width: INTEGER := 8;
            addr : INTEGER := 11;
            depth: INTEGER := 2**11 );
        port(
            Clk          : in STD_LOGIC;
            Address      : in STD_LOGIC_VECTOR (31 downto 0);
            Instruction  : out STD_LOGIC_VECTOR (31 downto 0) );
    end component InstructionMemory;

    signal Clk_tb: std_logic := '0';
    signal Address_tb: std_logic_vector(31 downto 0);
    signal Instruction_tb: std_logic_vector(31 downto 0);

begin

    IMem: InstructionMemory generic map(width => 8, addr => 11, depth => 2**11)
                            port map(Clk => Clk_tb, Address => Address_tb, Instruction => Instruction_tb);
    
    process
        begin
        wait for 8ns;
        Clk_tb <= NOT Clk_tb;
    end process;
    
    process 
        begin 
            Address_tb <= x"0"; --Addr 0
        wait for 16ns;    
            Address_tb <= x"2"; --Addr 2
        wait for 16ns;    
            Address_tb <= x"4"; --Addr 4
        wait for 16ns;    
            Address_tb <= x"8"; --Addr 8
        wait for 16ns;    
            Address_tb <= "11111111100"; --Addr 2044
        wait;
    end process;

end Behavioral;
