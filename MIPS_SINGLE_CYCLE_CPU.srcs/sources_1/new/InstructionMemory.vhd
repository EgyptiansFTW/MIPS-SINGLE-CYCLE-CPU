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
        width : INTEGER := 32;       -- Using 32b instruction set
        addr  : INTEGER := 8;        -- 8 Bit address used to read/write
        depth : INTEGER := 2**8 );   -- Using 32 x 2**8 memory array
    port(
        Address      : in STD_LOGIC_VECTOR (addr-1 downto 0);
        Instruction  : out STD_LOGIC_VECTOR (31 downto 0) );
end InstructionMemory;

architecture Behavioral of InstructionMemory is

    type memory is array(depth-1 downto 0) of bit_vector(width-1 downto 0);

    -- Function will read contents of file into Memory Array
    impure function InitRamFromFile (RamFileName : in string) return memory is
        FILE RamFile : text open read_mode is in RamFileName;
        variable RamFileLine : line;
        variable tmp_bv : bit_vector(width-1 downto 0);
        variable tmpMEM : memory;
    begin
        if(not endfile(RamFile)) then
            for I in memory'range loop
                readline (RamFile, RamFileLine);
                read (RamFileLine, tmp_bv);
                tmpMEM(I) := (tmp_bv);
            end loop;
        end if;
        return tmpMEM;
    end function;
    
--    signal InstructionMemory: memory := (others => (others => '0'));
        -- Initialize all memory locations to be '0'
    
    signal InstructionMemory : memory := InitRamFromFile("dataMem.data");
        -- Initialize all memory locations from specified file
    
begin
    
    Instruction <= to_stdlogicvector(InstructionMemory(to_integer(unsigned(Address))));

end Behavioral;