------------------------------------------------------
-- Class:    ECE 524 L                              --
-- Engineer: Ben Cooper                             --
--                                                  --
-- Create Date: 12/05/22                            --
-- Module Name: ShiftRegister_tb.vhd                --
--                                                  --
-- Dependencies: ShiftRegister                      --
--                                                  --
------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftRegister_tb is
--  Port ( );
end ShiftRegister_tb;

architecture Behavioral of ShiftRegister_tb is

    component ShiftRegister is
        port(
            ShiftInput : in std_logic_vector(31 downto 0);
            ShiftOutput: out std_logic_vector(31 downto 0) );
    end component ShiftRegister;
    
    signal ShiftInput_tb: std_logic_vector(31 downto 0);
    signal ShiftOutput_tb: std_logic_vector(31 downto 0);

begin

    SFT: ShiftRegister port map(ShiftInput => ShiftInput_tb, 
                                ShiftOutput => ShiftOutput_tb);

    process
        begin
        ShiftInput_tb <= "00" & x"00FABE";
        wait for 10ns;
        ShiftInput_tb <= "11" & x"BABE00";
        wait;
    end process;

end Behavioral;