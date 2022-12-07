------------------------------------------------------
-- Class:    ECE 524 L                              --
-- Engineer: Ben Cooper                             --
--                                                  --
-- Create Date: 12/05/22                            --
-- Module Name: SignExtend.vhd                      --
--                                                  --
-- Dependencies:                                    --
--                                                  --
------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SignExtend is
    port(
        InstrInput: in std_logic_vector(15 downto 0);
        ExtendOut : out std_logic_vector(31 downto 0)
    );
end SignExtend;

architecture Behavioral of SignExtend is

begin

    -- Keep LSB of Input -> Output
    ExtendOut(15 downto 0) <= InstrInput;
    
    -- Assign FFFF for extending 1's and 0000 for extending 0s
    ExtendOut(31 downto 16) <= x"FFFF" when InstrInput(15) = '1' 
                               else x"0000";

end Behavioral;