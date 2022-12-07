library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity MUX_tb is
--  Port ( );
end MUX_tb;

architecture Behavioral of MUX_tb is
component MUX is
    port(
        signal SEL : in std_logic;
        signal A, B : in std_logic_vector(31 downto 0);
        signal O : out std_logic_vector(31 downto 0)
    );
end component MUX;
signal SEL_tb: std_logic;
signal A_tb, B_tb, O_tb:std_logic_vector(31 downto 0);
 
begin
UUT: entity work.MUX port map (SEL => SEL_tb, A => A_tb, B => B_tb,O => O_tb );
process
begin 
SEL_tb <= '1';
A_tb <= X"00000000";
B_tb <= X"0000000E";
wait for 10 ns;
SEL_tb <= '0';
A_tb <= X"00000000";
B_tb <= X"0000000E";
wait for 10 ns;



end process;
end Behavioral;
