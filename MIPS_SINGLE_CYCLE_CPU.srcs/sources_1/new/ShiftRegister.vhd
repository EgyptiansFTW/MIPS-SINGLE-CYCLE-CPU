------------------------------------------------------
-- Class:    ECE 524 L                              --
-- Engineer: Ben Cooper                             --
--                                                  --
-- Create Date: 12/05/22                            --
-- Module Name: ShiftRegister.vhd                   --
--                                                  --
-- Dependencies:                                    --
--                                                  --
------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ShiftRegister is
    port(
        ShiftInput : in std_logic_vector(31 downto 0);
        ShiftOutput: out std_logic_vector(31 downto 0) );
end ShiftRegister;

architecture Behavioral of ShiftRegister is
    
begin

    ShiftOutput <= ShiftInput(29 downto 0) & "00";

end Behavioral;