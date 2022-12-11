library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Adder is
    Port ( X : in STD_LOGIC_VECTOR (31 downto 0);
           Y : in STD_LOGIC_VECTOR (31 downto 0);
           SUM : out STD_LOGIC_VECTOR (31 downto 0));
end Adder;

architecture Behavioral of Adder is

begin

    SUM <= std_logic_vector(signed(X) + signed(Y));

end Behavioral;