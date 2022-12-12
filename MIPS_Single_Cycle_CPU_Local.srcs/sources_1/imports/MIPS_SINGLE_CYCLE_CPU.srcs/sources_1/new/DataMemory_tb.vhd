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
            width: INTEGER := 8;
            addr : INTEGER := 11;
            depth: INTEGER := 2**11 );
        port(
            CLK : in STD_LOGIC;
            WEN : in STD_LOGIC;
            REN : in STD_LOGIC;
            WriteData : in STD_LOGIC_VECTOR (31 downto 0);
            Address   : in STD_LOGIC_VECTOR (addr-1 downto 0);
            ReadData  : out STD_LOGIC_VECTOR (31 downto 0) );
    end component DataMemory;

    signal CLK_tb, WEN_tb, REN_tb: std_logic := '0';
    signal Address_tb: std_logic_vector(10 downto 0);
    signal WriteData_tb, ReadData_tb: std_logic_vector(31 downto 0);

begin

    DMem: DataMemory generic map(width => 8, addr => 11, depth => 2**11)
                     port map(CLK => CLK_tb, WEN => WEN_tb, REN => REN_tb, 
                     WriteData => WriteData_tb, Address => Address_tb, ReadData => ReadData_tb);

    process
        begin
        wait for 8ns;
        Clk_tb <= NOT Clk_tb;
    end process;
    
    process 
        begin 
            Address_tb <= "00000000000"; --Addr 0
            WriteData_tb <= x"babe0000";
        wait for 16ns;
            WEN_tb <= '1';    
        wait for 16ns;    
            WriteData_tb <= x"0000beef";
            WEN_tb <= '0'; 
            REN_tb <= '1'; 
        wait for 16ns;    
            WEN_tb <= '1'; 
        wait for 16ns;    
            WEN_tb <= '0'; 
        wait for 16ns;    
            Address_tb <= "11111111101"; --Addr 2044
        wait for 16ns;
            Address_tb <= "11111111100"; --Addr 2044
        wait;
    end process;

end Behavioral;
