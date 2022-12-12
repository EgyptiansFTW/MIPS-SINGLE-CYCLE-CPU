
library ieee;
use ieee.std_logic_1164.all;


entity MUX is
    port(
        signal SEL : in std_logic;
        signal A, B : in std_logic_vector(31 downto 0);
        signal O : out std_logic_vector(31 downto 0)
    );
end entity MUX;


architecture behavior of MUX is
    begin
        process(A, B, SEL)
            begin
                if SEL = '0' then
                    O <= A;
                elsif SEL = '1' then
                    O <= B;
                end if;
        end process;
end architecture behavior;
