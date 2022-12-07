library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity ALU_TB is
--  Port ( );
end ALU_TB;

architecture Behavioral of ALU_TB is

    component ALU is
        port(
            signal OPCODE : in std_logic_vector(3 downto 0);
            signal SHAMT : in std_logic_vector(4 downto 0);
            signal X, Y : in std_logic_vector(31 downto 0);
            signal Z : out std_logic;
            signal R, LO, HI : out std_logic_vector(31 downto 0)
        );
    end component ALU;
    
    signal OPCODE_tb :std_logic_vector(3 downto 0);
    signal SHAMT_tb : std_logic_vector(4 downto 0);
    signal X_tb, Y_tb : std_logic_vector(31 downto 0);
    signal Z_tb : std_logic;
    signal R_tb, LO_tb, HI_tb : std_logic_vector(31 downto 0);

begin 

    UUT: entity work.ALU port map (OPCODE => OPCODE_tb, SHAMT => SHAMT_tb, X => X_tb, Y => Y_tb, Z => Z_tb, R=>R_tb, LO => LO_tb, HI=> HI_tb);

process
    begin 
        --add
        OPCODE_tb <= "0001";
        X_tb <= X"00000005";
        Y_tb<= X"00000005";
    wait for 20 ns;
        --sub
        OPCODE_tb <= "0010";
        X_tb <= X"00000010";
        Y_tb<= X"00000006";
    wait for 20 ns;
        --mul
        OPCODE_tb <= "0011";
        X_tb <= X"11111111";
        Y_tb<= X"11111111";
    wait for 20 ns;
        --div
        OPCODE_tb <= "0100";
        X_tb <= X"0000000A";
        Y_tb<= X"00000003";
        --AND
        OPCODE_tb <= "0101";
        X_tb <= X"00000004";
        Y_tb<= X"00000004";
    wait for 20 ns;
        --OR
        OPCODE_tb <= "0110";
        X_tb <= X"00000008";
        Y_tb<= X"00000002";
    wait for 20 ns;
        --NOR
        OPCODE_tb <= "0111";
        X_tb <= X"FFFFFFFF";
        Y_tb<= X"00000000";
    wait for 20 ns;
        --XOR
        OPCODE_tb <= "1000";
        X_tb <= X"FFFFFFFF";
        Y_tb<= X"00000000";
    wait for 20 ns;
        --SET IF LESS THAN
        OPCODE_tb <= "1101";
        X_tb <= X"00000002";
        Y_tb<= X"00000003";
    wait for 20 ns;
        --Logical Shift left
        OPCODE_tb <= "1001";
        Y_tb<= X"00000003";
        SHAMT_tb<="00001";
    wait for 20 ns;
        --Logical Shift right
        OPCODE_tb <= "1010";
        Y_tb<= X"00000003";
        SHAMT_tb<="00001";
    wait for 20 ns;
        --Rotate left
        OPCODE_tb <= "1011";
        Y_tb<= X"00000003";
        SHAMT_tb<="00001";
    wait for 20 ns;
        --Rotate right
        OPCODE_tb <= "1100";
        Y_tb<= X"00000003";
        SHAMT_tb<="00001";
    wait for 20 ns;
end process;

end Behavioral;