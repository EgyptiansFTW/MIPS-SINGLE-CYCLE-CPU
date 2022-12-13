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
        width : INTEGER := 8;       -- Using 32b instruction set
        addr  : INTEGER := 11;        -- 8 Bit address used to read/write
        depth : INTEGER := 2**11 );   -- Using 32 x 2**8 memory array
    port(
        CLK       : in STD_LOGIC;
        WEN       : in STD_LOGIC;
        REN       : in STD_LOGIC;
        WriteData : in STD_LOGIC_VECTOR (31 downto 0);
        Address   : in STD_LOGIC_VECTOR (31 downto 0);
        ReadData  : out STD_LOGIC_VECTOR (31 downto 0) := (others => '0') );
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
    
    signal DatMem: memory := (others => (others => '0'));
        -- Initialize all memory locations to be '0'
    
--    signal DatMem : memory := InitRamFromFile("instrMem.data");
        -- Initialize all memory locations from specified file
    
begin

    -- Take smaller 8b words and compile them into Instruction 32b word. Big Endian
        -- ie:  0x74_45_be_af -> stored as -> { 0-af | 1-be | 2-45 | 3-74 }
    process(Clk, WEN, REN) 
        begin
        if rising_edge(Clk) then
            if  (to_integer(unsigned(Address(addr-1 downto 0))) mod 4) = 0 then
                if WEN = '1' then
                    DatMem(to_integer(unsigned(Address(addr-1 downto 0)))) <= to_bitvector(WriteData(31 downto 24));
                    DatMem(to_integer(unsigned(Address(addr-1 downto 0)))+1) <= to_bitvector(WriteData(23 downto 16));
                    DatMem(to_integer(unsigned(Address(addr-1 downto 0)))+2) <= to_bitvector(WriteData(15 downto 8));
                    DatMem(to_integer(unsigned(Address(addr-1 downto 0)))+3) <= to_bitvector(WriteData(7 downto 0));
                end if;
            end if;
        end if;
    end process;

    process(REN)
        begin
        if REN = '1' then
            ReadData(31 downto 24) <= to_stdlogicvector( DatMem(to_integer(unsigned(Address(addr-1 downto 0)))) );
            ReadData(23 downto 16) <= to_stdlogicvector( DatMem(to_integer(unsigned(Address(addr-1 downto 0)))+1) );
            ReadData(15 downto 8) <= to_stdlogicvector( DatMem(to_integer(unsigned(Address(addr-1 downto 0)))+2) );
            ReadData(7 downto 0) <= to_stdlogicvector( DatMem(to_integer(unsigned(Address(addr-1 downto 0)))+3) );
        end if;
    end process;

end Behavioral;