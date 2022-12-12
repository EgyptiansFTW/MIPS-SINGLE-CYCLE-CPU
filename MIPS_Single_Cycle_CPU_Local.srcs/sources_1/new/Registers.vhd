------------------------------------------------------
-- Class:    ECE 524 L                              --
-- Engineer: Ben Cooper                             --
--                                                  --
-- Create Date: 12/05/22                            --
-- Module Name: Registers_tb.vhd                    --
--                                                  --
-- Dependencies: Registers.vhd                      --
--                                                  --
------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Registers is
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
        ReadReg1  : out STD_LOGIC_VECTOR (width-1 downto 0) := (others => '0');
        ReadReg2  : out STD_LOGIC_VECTOR (width-1 downto 0) := (others => '0'));
end Registers;

architecture Behavioral of Registers is

    type regArray is array(0 to width-1) of STD_LOGIC_VECTOR(width-1 downto 0);
        -- 5b Address gives 32 addressable registers of width 32 [32x32]
    
    signal RegFile: regArray := (others => (others => '0'));   
        -- Initialize all registers in file to 0
        
    signal LO_previous: STD_LOGIC_VECTOR (width-1 downto 0) := (others => '0');
    signal HI_previous: STD_LOGIC_VECTOR (width-1 downto 0) := (others => '0');
                
begin

    process (CLK, WEN)
        begin
        if rising_edge(CLK) then
            if WEN = '1' then
                if NOT( (AddrR1 = x"1e") OR (AddrR1 = x"1f") OR (AddrR2 = x"1e") OR (AddrR2 = x"1f") ) then 
                    RegFile(to_integer(unsigned(AddrWR))) <= WriteReg;
                else
                    if NOT(LO = LO_previous) then
                        RegFile(30) <= LO;
                        LO_previous <= LO;
                    elsif NOT(HI = HI_previous) then
                        RegFile(31) <= HI;
                        HI_previous <= HI;
                    end if;
                end if;
            end if;
        end if;
    end process;

    ReadReg1 <= RegFile(to_integer(unsigned(AddrR1)));
    ReadReg2 <= RegFile(to_integer(unsigned(AddrR2)));

end Behavioral;