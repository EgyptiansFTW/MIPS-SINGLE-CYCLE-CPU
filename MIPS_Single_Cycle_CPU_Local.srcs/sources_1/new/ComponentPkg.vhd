library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package ComponentPkg is

    component ALUcontrol is
        port(
            signal ALUOP : in std_logic_vector(1 downto 0); --CTL SIG
            signal FUNCT : in std_logic_vector(5 downto 0); --INST(5-0)
            signal OPCODE : out std_logic_vector(3 downto 0)--To ALU
        );
    end component ALUcontrol;
    
    component ALU is
        port(
            signal OPCODE : in std_logic_vector(3 downto 0);--From CTL
            signal SHAMT : in std_logic_vector(4 downto 0); --
            signal X, Y : in std_logic_vector(31 downto 0);
            signal Z : out std_logic;
            signal R, LO, HI : out std_logic_vector(31 downto 0)
        );
    end component  ALU;
    
    component Registers is
        generic(
            width: INTEGER := 32);
        port(
            CLK       : in STD_LOGIC;
            WEN       : in STD_LOGIC;
            AddrR1    : in STD_LOGIC_VECTOR (4 downto 0);
            AddrR2    : in STD_LOGIC_VECTOR (4 downto 0);
            AddrWR    : in STD_LOGIC_VECTOR (4 downto 0);
            LO        : in STD_LOGIC_VECTOR (width-1 downto 0);
            HI        : in STD_LOGIC_VECTOR (width-1 downto 0);
            WriteReg  : in STD_LOGIC_VECTOR (width-1 downto 0);
            ReadReg1  : out STD_LOGIC_VECTOR (width-1 downto 0);
            ReadReg2  : out STD_LOGIC_VECTOR (width-1 downto 0));
    end component Registers;
    
    component SignExtend is
        port(
            InstrInput: in std_logic_vector(15 downto 0);
            ExtendOut : out std_logic_vector(31 downto 0)
        );
    end component SignExtend;
    
    component ShiftRegister is
        port(
            ShiftInput : in std_logic_vector(31 downto 0);
            ShiftOutput: out std_logic_vector(31 downto 0) 
        );
    end component ShiftRegister;
    
    component InstructionMemory is
        generic(
            width : INTEGER := 8;       -- Using 32b instruction set
            addr  : INTEGER := 11;        -- 8 Bit address used to read/write
            depth : INTEGER := 2**11 );   -- Using 32 x 2**8 memory array
        port(
            Clk          : in STD_LOGIC;
            Address      : in STD_LOGIC_VECTOR (31 downto 0);
            Instruction  : out STD_LOGIC_VECTOR (31 downto 0) );
    end component InstructionMemory;
    
    component DataMemory is
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
            ReadData  : out STD_LOGIC_VECTOR (31 downto 0) );
    end component DataMemory;
    
    component Adder is
        Port ( X : in STD_LOGIC_VECTOR (31 downto 0);
               Y : in STD_LOGIC_VECTOR (31 downto 0);
               SUM : out STD_LOGIC_VECTOR (31 downto 0));
    end component Adder;
    
    component MUX is
        port(
            signal SEL : in std_logic;
            signal A, B : in std_logic_vector(31 downto 0);
            signal O : out std_logic_vector(31 downto 0)
        );
    end component MUX;
   
end package;