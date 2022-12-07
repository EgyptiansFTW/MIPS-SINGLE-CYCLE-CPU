------------------------------------------------------
-- Class:    ECE 524 L                              --
-- Engineer: Ben Cooper                             --
--                                                  --
-- Create Date: 12/01/22                            --
-- Module Name: DataMemory.vhd                      --
--                                                  --
-- Dependencies:                                    --
--                                                  --
------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use std.textio.all;

entity DataMemory is
    generic(
        width : INTEGER := 32;       -- Using 32b instruction set
        addr  : INTEGER := 9;        -- 8 Bit address used to read/write
        depth : INTEGER := 2**9 );   -- Using 32 x 2**8 memory array
    port(
        CLK       : in STD_LOGIC;
        WEN       : in STD_LOGIC;
        REN       : in STD_LOGIC;
        WriteData : in STD_LOGIC_VECTOR (31 downto 0);
        Address   : in STD_LOGIC_VECTOR (addr-1 downto 0);
        ReadData  : out STD_LOGIC_VECTOR (31 downto 0) );
end DataMemory;

architecture Behavioral of DataMemory is

    type memory is array(0 to depth-1) of bit_vector(width-1 downto 0);
        -- Memory stored 0 -> 512 | File(0) == memory(0)

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
    
--    signal DataMemory: memory := (others => (others => '0'));
        -- Initialize all memory locations to be '0'
    
    signal DataMemory : memory := InitRamFromFile("dataMem.data");
        -- Initialize all memory locations from specified file
    
begin
    
    process(CLK, WEN, REN) 
    begin
        if rising_edge(CLK) then
            if WEN = '1' then
                DataMemory(to_integer(unsigned(Address))) <= to_bitvector(WriteData);
            end if;
        end if;
    end process;

    ReadData <= to_stdlogicvector(DataMemory(to_integer(unsigned(Address)))) when REN = '1' 
                else (others => '0');

end Behavioral;