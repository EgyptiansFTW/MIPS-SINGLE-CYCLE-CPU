library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity ALU_CONTROL_TB is
--  Port ( );
end ALU_CONTROL_TB;

architecture Behavioral of ALU_CONTROL_TB is

    component ALUcontrol is
        port(
            signal ALUOP : in std_logic_vector(1 downto 0);
            signal FUNCT : in std_logic_vector(5 downto 0);
            signal OPCODE : out std_logic_vector(3 downto 0)
        );
    end component ALUcontrol;

    signal ALUOP_tb: std_logic_vector(1 downto 0);
    signal FUNCT_tb: std_logic_vector(5 downto 0);
    signal OPCODE_tb: std_logic_vector(3 downto 0);

begin 
  
    UUT: entity work.ALUcontrol port map (ALUOP => ALUOP_tb, FUNCT => FUNCT_tb, OPCODE => OPCODE_tb);

process
    begin 
        ALUOP_tb <="00";
        FUNCT_tb <= "100000";
    wait for 10 ns;
        ALUOP_tb <="01";
        FUNCT_tb <= "100000";
    wait for 10 ns; 
        ALUOP_tb <="10";
        FUNCT_tb <= "100000";
    wait for 10 ns; 
        ALUOP_tb <="11";
        FUNCT_tb <= "100000";
    wait for 10 ns; 
        ALUOP_tb <="11";
        FUNCT_tb <= "100101";
    wait for 10 ns; 
        ALUOP_tb <="11";
        FUNCT_tb <= "111111";
    wait for 10 ns; 
    wait;
end process; 

end Behavioral;
