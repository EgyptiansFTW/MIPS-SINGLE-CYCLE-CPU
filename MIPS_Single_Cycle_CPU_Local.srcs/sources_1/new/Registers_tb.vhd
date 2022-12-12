----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/06/2022 02:20:52 AM
-- Design Name: 
-- Module Name: Registers_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Registers_tb is
--  Port ( );
end Registers_tb;

architecture Behavioral of Registers_tb is

    component Registers is
        generic(
            width: INTEGER := 32);
        port(
            CLK       : in STD_LOGIC;
            WEN       : in STD_LOGIC;
            AddrR1    : in STD_LOGIC_VECTOR (4 downto 0);
            AddrR2    : in STD_LOGIC_VECTOR (4 downto 0);
            AddrWR    : in STD_LOGIC_VECTOR (4 downto 0);
            LO        : in STD_LOGIC_VECTOR (width-1 downto 0);
            HI        : in STD_LOGIC_VECTOR (width-1 downto 0);
            WriteReg  : in STD_LOGIC_VECTOR (width-1 downto 0);
            ReadReg1  : out STD_LOGIC_VECTOR (width-1 downto 0);
            ReadReg2  : out STD_LOGIC_VECTOR (width-1 downto 0));
    end component Registers;

    constant width_tb: INTEGER := 32;
    
    signal CLK_tb, WEN_tb: std_logic := '0';
    signal AddrR1_tb, AddrR2_tb, AddrWR_tb: std_logic_vector(4 downto 0) := (others => '0');
    signal WriteReg_tb, ReadReg1_tb, ReadReg2_tb, LO_tb, HI_tb: std_logic_vector(width_tb-1 downto 0) := (others => '0');

begin

    RegF: Registers generic map(width => width_tb)
                    port map(CLK => CLK_tb, WEN => WEN_tb, AddrR1 => AddrR1_tb, 
                             AddrR2 => AddrR2_tb, AddrWR => AddrWR_tb, WriteReg => WriteReg_tb,
                             ReadReg1 => ReadReg1_tb, ReadReg2 => ReadReg2_tb, LO => LO_tb, HI => HI_tb);

    process
        begin
        wait for 8ns;
        CLK_tb <= NOT CLK_tb;
    end process;
    
    -- CLK begins @ 0 and every 16ns swaps 
    process
        begin
            -- Read initial conditions from R0 / R1
            AddrR1_tb <= "00000";
            AddrR2_tb <= "00001";
        wait for 16ns;
            -- Write dab0dab0 value to R0
            WEN_tb <= '1';
            WriteReg_tb <= x"dab0dab0";
        wait for 16ns;
            -- Write beef0000 value to R1
            AddrWR_tb <= "00001";
            WriteReg_tb <= x"beef0000";
        wait for 16ns;
            -- Write using read registers R0 & R1
            AddrWR_tb <= "00010";
            WriteReg_tb <= ReadReg1_tb XOR ReadReg2_tb;
        wait for 16ns;
            -- Read written value stored in R3
            WEN_tb <= '0';
            AddrR1_tb <= "00010";
        wait for 16ns;
            -- Test writing and reading to LO
            WEN_tb <= '1';
            AddrR1_tb <= "11110";
            LO_tb <= x"ADDE0000";
        wait for 16ns;
            -- Test writing and reading to LO
            AddrR2_tb <= "11111";
            HI_tb <= x"0000ADDE";
        wait;
    end process;

end Behavioral;
