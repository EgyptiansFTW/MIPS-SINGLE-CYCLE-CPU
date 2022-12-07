
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Adder_tb is
--  Port ( );
end Adder_tb;


architecture Behavioral of Adder_tb is

    component Adder is
        Port ( X : in STD_LOGIC_VECTOR (31 downto 0);
               Y : in STD_LOGIC_VECTOR (31 downto 0);
               SUM : out STD_LOGIC_VECTOR (31 downto 0));
    end component;

    signal X_tb, Y_tb: std_logic_vector(31 downto 0);
    signal SUM_tb: std_logic_vector(31 downto 0);

begin 

    UUT: entity work.Adder port map (X => X_tb, Y => Y_tb, SUM => SUM_tb);

process
    begin 
        X_tb <=x"00000000";
        Y_tb <= x"00000000";
    wait for 10 ns; 
        X_tb <=x"00000001";
        Y_tb <= x"00000001";
    wait for 10 ns; 
        X_tb <=x"00000005";
        Y_tb <= x"00000005";
    wait for 10 ns; 
        X_tb <=x"0000000F";
        Y_tb <= x"0000000F";
    wait;
end process; 

end Behavioral;
