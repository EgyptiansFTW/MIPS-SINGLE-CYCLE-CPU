------------------------------------------------------
-- Class:    ECE 524 L                              --
-- Engineer: Ben Cooper                             --
--                                                  --
-- Create Date: 12/01/22                            --
-- Module Name: DataMemory_tb.vhd                   --
--                                                  --
-- Dependencies: DataMemory.vhd                     --
--                                                  --
------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DataMemory_tb is
--  Port ( );
end DataMemory_tb;

architecture Behavioral of DataMemory_tb is

    component DataMemory is
        generic(
            width: INTEGER := 32;
            addr : INTEGER := 9;
            depth: INTEGER := 2**9 );
        port(
            CLK : in STD_LOGIC;
            WEN : in STD_LOGIC;
            REN : in STD_LOGIC;
            WriteData : in STD_LOGIC_VECTOR (31 downto 0);
            Address   : in STD_LOGIC_VECTOR (addr-1 downto 0);
            ReadData  : out STD_LOGIC_VECTOR (31 downto 0) );
    end component DataMemory;

    signal CLK_tb, WEN_tb, REN_tb: std_logic;
    signal Address_tb: std_logic_vector(8 downto 0);
    signal WriteData_tb, ReadData_tb: std_logic_vector(31 downto 0);

begin

    DMem: DataMemory generic map(width => 32, addr => 9, depth => 2**9)
                     port map(CLK => CLK_tb, WEN => WEN_tb, REN => REN_tb, 
                     WriteData => WriteData_tb, Address => Address_tb, ReadData => ReadData_tb);

end Behavioral;
