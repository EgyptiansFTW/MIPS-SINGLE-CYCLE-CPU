------------------------------------------------------
-- Class:    ECE 524 L                              --
-- Engineer: Ben Cooper                             --
--                                                  --
-- Create Date: 12/01/22                            --
-- Module Name: InstructionMemory.vhd               --
--                                                  --
-- Dependencies:                                    --
--                                                  --
------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use std.textio.all;

entity InstructionMemory is
    generic(
        width : INTEGER := 8;         -- Using 32b instruction set
        addr  : INTEGER := 11;        -- 8 Bit address used to read/write
        depth : INTEGER := 2**11 );   -- Using 32 x 2**8 memory array
    port(
        Clk          : in STD_LOGIC;
        Address      : in STD_LOGIC_VECTOR (31 downto 0);
        Instruction  : out STD_LOGIC_VECTOR (31 downto 0) );
end InstructionMemory;

architecture Behavioral of InstructionMemory is

    type memory is array(0 to depth-1) of bit_vector(width-1 downto 0);
        -- Memory stored 0 -> 2048 | File(0) == memory(0)

    -- Function will read contents of file into Memory Array
    impure function InitRamFromFile (RamFileName : in string) return memory is
        FILE RamFile : text open read_mode is in RamFileName;
        variable RamFileLine : line;
        variable tmp_bv : bit_vector(width-1 downto 0);
        variable emt_bv : bit_vector(width-1 downto 0) := (others => '0');
        variable tmpMEM : memory;
    begin
        for I in memory'range loop
            if(not endfile(RamFile)) then
                readline (RamFile, RamFileLine);
                read (RamFileLine, tmp_bv);
                tmpMEM(I) := (tmp_bv);
            else 
                tmpMEM(I):= (emt_bv);
            end if;
        end loop;
        return tmpMEM;
    end function;
    
--    signal IstrMem: memory := (others => (others => '0'));
        -- Initialize all memory locations to be '0'
    
    signal IstrMem : memory := InitRamFromFile("instrMem.data");
        -- Initialize all memory locations from specified file
    
begin
    -- Take smaller 8b words and compile them into Instruction 32b word. Big Endian
        -- ie:  0x74_45_be_af -> stored as -> { 3-af | 2-be | 1-45 | 0-74 }
    process(Clk) --(Address)(Clk)
        begin
        if rising_edge(Clk) then
            if  (to_integer(unsigned(Address(addr-1 downto 0))) mod 4) = 0 then
                Instruction(31 downto 24) <= to_stdlogicvector( IstrMem(to_integer(unsigned(Address(addr-1 downto 0)))) );
                Instruction(23 downto 16) <= to_stdlogicvector( IstrMem(to_integer(unsigned(Address(addr-1 downto 0)))+1) );
                Instruction(15 downto 8) <= to_stdlogicvector( IstrMem(to_integer(unsigned(Address(addr-1 downto 0)))+2) );
                Instruction(7 downto 0) <= to_stdlogicvector( IstrMem(to_integer(unsigned(Address(addr-1 downto 0)))+3) );
            end if;
        end if;
    end process;
        
end Behavioral;