library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity control_tb is
--  Port ( );
end control_tb;


architecture Behavioral of control_tb is

component control is
    port(
        signal OPCODE : in std_logic_vector(5 downto 0);
        signal REGDST, ALUSRC, MEMTOREG, REGWRITE, MEMREAD : out std_logic;
        signal MEMWRITE, BRANCH, JUMP, JPLINK, JUMPRST  : out std_logic;
        signal ALUOP : out std_logic_vector(1 downto 0)  
    );
end component control;
signal ALUOP_tb: std_logic_vector(1 downto 0);
signal REGDST_tb, ALUSRC_tb, MEMTOREG_tb, REGWRITE_tb, MEMREAD_tb :  std_logic;
signal MEMWRITE_tb, BRANCH_tb, JUMP_tb, JPLINK_tb, JUMPRST_tb  :  std_logic;
signal OPCODE_tb: std_logic_vector(5 downto 0);

begin 
UUT: entity work.control port map (ALUOP => ALUOP_tb, REGDST => REGDST_tb, OPCODE => OPCODE_tb, ALUSRC => ALUSRC_tb, 
MEMTOREG =>MEMTOREG_tb, REGWRITE => REGWRITE_tb, MEMREAD=> MEMREAD_tb, MEMWRITE => MEMWRITE_tb, BRANCH => BRANCH_tb, JUMP=> JUMP_tb,
 JUMPRST=> JUMPRST_tb, JPLINK=> JPLINK_tb);

process
begin 
OPCODE_tb <= "000000";
wait for 10 ns;
OPCODE_tb <= "100011";
wait for 10 ns;
OPCODE_tb <= "101011";
wait for 10 ns;
OPCODE_tb <= "000100";
wait for 10 ns;
OPCODE_tb <= "000010";
wait for 10 ns;
OPCODE_tb <= "001000";
wait for 10 ns;
OPCODE_tb <= "001010";
wait for 10 ns;
OPCODE_tb <= "000011";
wait for 10 ns;
OPCODE_tb <= "000110";
wait for 10 ns;
end process;
end Behavioral;
