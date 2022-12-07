------------------------------------------------------
-- Class:    ECE 524 L                              --
-- Engineer: Ben Cooper                             --
--                                                  --
-- Create Date: 12/05/22                            --
-- Module Name: SignExtend_tb.vhd                   --
--                                                  --
-- Dependencies: SignExtend.vhd                     --
--                                                  --
------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SignExtend_tb is
--  Port ( );
end SignExtend_tb;

architecture Behavioral of SignExtend_tb is

    component SignExtend is
        port(
            InstrInput: in std_logic_vector(15 downto 0);
            ExtendOut : out std_logic_vector(31 downto 0)
        );
    end component SignExtend;
    
    signal InstrInput_tb: std_logic_vector(15 downto 0);
    signal ExtendOut_tb: std_logic_vector(31 downto 0);

begin

    EXT: SignExtend port map(InstrInput => InstrInput_tb, ExtendOut => ExtendOut_tb);
    
    process 
        begin
        InstrInput_tb <= x"beef";
        wait for 10ns;
        InstrInput_tb <= x"0dab";
        wait;
    end process;

end Behavioral;