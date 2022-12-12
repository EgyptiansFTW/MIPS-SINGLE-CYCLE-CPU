------------------------------------------------------
-- Class:    ECE 524 L                              --
-- Engineer: Ben Cooper                             --
--                                                  --
-- Create Date: 12/05/22                            --
-- Module Name: Datapath.vhd                        --
--                                                  --
-- Dependencies:                                    --
--                                                  --
------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.ComponentPkg.ALL;

entity Datapath is
    port(
        signal CLK_in   : in std_logic;
        signal RegDst   : in std_logic;      --Control Sig
        signal JUMP     : in std_logic;      --Control Sig
        signal BRANCH   : in std_logic;      --Control Sig
        signal MemToReg : in std_logic;      --Control Sig
        signal ALUSrc   : in std_logic;      --Control Sig
        signal MemWrite : in STD_LOGIC;      --Control Sig  
        signal MemRead  : in STD_LOGIC;      --Control Sig
        signal RegWrite : in STD_LOGIC;      --Control Sig
        signal ALUOP_DP : in std_logic_vector(1 downto 0); --Control Sig
        signal OPCODE_DP: out std_logic_vector(5 downto 0) --INST(31-26)
        );
end Datapath;

architecture Behavioral of Datapath is

--    component ALUcontrol is
--        port(
--            signal ALUOP : in std_logic_vector(1 downto 0); --CTL SIG
--            signal FUNCT : in std_logic_vector(5 downto 0); --INST(5-0)
--            signal OPCODE : out std_logic_vector(3 downto 0)--To ALU
--        );
--    end component ALUcontrol;
    
--    component ALU is
--        port(
--            signal OPCODE : in std_logic_vector(3 downto 0);--From CTL
--            signal SHAMT : in std_logic_vector(4 downto 0); --
--            signal X, Y : in std_logic_vector(31 downto 0);
--            signal Z : out std_logic;
--            signal R, LO, HI : out std_logic_vector(31 downto 0)
--        );
--    end component  ALU;
    
--    component Registers is
--        generic(
--            width: INTEGER := 32);
--        port(
--            CLK       : in STD_LOGIC;
--            WEN       : in STD_LOGIC;
--            AddrR1    : in STD_LOGIC_VECTOR (4 downto 0);
--            AddrR2    : in STD_LOGIC_VECTOR (4 downto 0);
--            AddrWR    : in STD_LOGIC_VECTOR (4 downto 0);
--            LO        : in STD_LOGIC_VECTOR (width-1 downto 0);
--            HI        : in STD_LOGIC_VECTOR (width-1 downto 0);
--            WriteReg  : in STD_LOGIC_VECTOR (width-1 downto 0);
--            ReadReg1  : out STD_LOGIC_VECTOR (width-1 downto 0);
--            ReadReg2  : out STD_LOGIC_VECTOR (width-1 downto 0));
--    end component Registers;
    
--    component SignExtend is
--        port(
--            InstrInput: in std_logic_vector(15 downto 0);
--            ExtendOut : out std_logic_vector(31 downto 0)
--        );
--    end component SignExtend;
    
--    component ShiftRegister is
--        port(
--            ShiftInput : in std_logic_vector(31 downto 0);
--            ShiftOutput: out std_logic_vector(31 downto 0) 
--        );
--    end component ShiftRegister;
    
--    component InstructionMemory is
--        generic(
--            width : INTEGER := 8;       -- Using 32b instruction set
--            addr  : INTEGER := 11;        -- 8 Bit address used to read/write
--            depth : INTEGER := 2**11 );   -- Using 32 x 2**8 memory array
--        port(
--            Clk          : in STD_LOGIC;
--            Address      : in STD_LOGIC_VECTOR (31 downto 0);
--            Instruction  : out STD_LOGIC_VECTOR (31 downto 0) );
--    end component InstructionMemory;
    
--    component DataMemory is
--        generic(
--            width : INTEGER := 8;       -- Using 32b instruction set
--            addr  : INTEGER := 11;        -- 8 Bit address used to read/write
--            depth : INTEGER := 2**11 );   -- Using 32 x 2**8 memory array
--        port(
--            CLK       : in STD_LOGIC;
--            WEN       : in STD_LOGIC;
--            REN       : in STD_LOGIC;
--            WriteData : in STD_LOGIC_VECTOR (31 downto 0);
--            Address   : in STD_LOGIC_VECTOR (31 downto 0);
--            ReadData  : out STD_LOGIC_VECTOR (31 downto 0) );
--    end component DataMemory;
    
--    component Adder is
--        Port ( X : in STD_LOGIC_VECTOR (31 downto 0);
--               Y : in STD_LOGIC_VECTOR (31 downto 0);
--    end component Adder;
    
--    component MUX is
--        port(
--            signal SEL : in std_logic;
--            signal A, B : in std_logic_vector(31 downto 0);
--            signal O : out std_logic_vector(31 downto 0)
--        );
--    end component MUX;
  
    constant width: INTEGER := 32;       -- Using 32b instruction set
    constant MEMwidth: INTEGER := 8;       -- Using 8b word set
    constant addr : INTEGER := 11;    -- 9b address used to read/write
    constant depth: INTEGER := 2**11;  -- Using 32 x 2**8 memory array
    
------ ALU CONTROL SIGNALS -----------------------------------------
    signal FUNCT_DP : std_logic_vector(5 downto 0);
    signal ALU_OPCODE : std_logic_vector(3 downto 0);
    
------ ALU SIGNALS -------------------------------------------------
    signal SHAMT_DP : std_logic_vector(4 downto 0);
    signal Z_DP : std_logic;
    signal R_DP, LO_DP, HI_DP : std_logic_vector(width-1 downto 0);
    
------ REGISTER SIGNALS --------------------------------------------
    signal ReadReg1_DP  : STD_LOGIC_VECTOR (width-1 downto 0);
    signal ReadReg2_DP  : STD_LOGIC_VECTOR (width-1 downto 0);
    
------ SIGN EXTEND SIGNALS -----------------------------------------
    signal ExtendOut_DP : std_logic_vector(width-1 downto 0);
    
------ SHIFT SIGNALS -----------------------------------------------
    signal ShiftInput_DP : std_logic_vector(31 downto 0);

------ INSTRUCTION MEMORY SIGNALS ----------------------------------
    signal Instruction_DP  : STD_LOGIC_VECTOR (width-1 downto 0);
    
------ DATA MEMORY SIGNALS -----------------------------------------
    signal ReadData_DP : STD_LOGIC_VECTOR (width-1 downto 0);
    
-------- ADDER SIGNALS -----------------------------------------------
    signal BRANCH_PRE_ADD : std_logic_vector(width-1 downto 0);
        -- Sign extend is shifted left by 2, pre-adder signal 
    signal BRANCH_POST_ADD : std_logic_vector(width-1 downto 0);
        -- BRANCH_PRE_ADD is added with PC+4
    
    signal PC_CURRENT : std_logic_vector(width-1 downto 0) := (others => '0');
    signal PC_PLUS4 : std_logic_vector(width-1 downto 0);
    
------ WIRING SIGNALS -------------------------------------------------
    signal PC_NEXT : std_logic_vector(width-1 downto 0);
    
    signal JUMP_ADDR_NO_PC : std_logic_vector(width-1 downto 0); 
        -- Has Instruction 25-0 shifted left by 2    
    signal JUMP_ADDR : std_logic_vector(width-1 downto 0); 
        -- Has Instruction 25-0 shifted left by 2 & PC+4 in 31-28
    signal BRANCH_ADDR : std_logic_vector(width-1 downto 0);
        -- Result of MUX between Branch_Post_Add & PC+4
    signal WRITE_ADDR : std_logic_vector(4 downto 0);
        -- MUX out from Instruction 20-16 or 15-11 (RegDst Control Signal)    
    signal ALU_2ndValue : std_logic_vector(width-1 downto 0);
        -- MUX out SignExtend or Read Data 2 (ALUSrc Control Signal)
    signal WRITE_BACK_DATA : std_logic_vector(width-1 downto 0);
        -- MUX out ReadData (DMem) or ALU Result goes back to write data
    
begin

    ALU_CTL: ALUcontrol port map (ALUOP  => ALUOP_DP, 
                                  FUNCT  => FUNCT_DP, 
                                  OPCODE => ALU_OPCODE);
    
    ALU1: ALU port map(OPCODE => ALU_OPCODE, 
                       SHAMT => SHAMT_DP, 
                       X => ReadReg1_DP, 
                       Y => ALU_2ndValue,
                       Z => Z_DP, 
                       R => R_DP, 
                       LO => LO_DP, 
                       HI => HI_DP);
                       
    S_EXT: SignExtend port map(InstrInput => Instruction_DP(15 downto 0), 
                               ExtendOut => ExtendOut_DP);
    
    SHFT_J: ShiftRegister port map(ShiftInput => ShiftInput_DP, 
                                   ShiftOutput => JUMP_ADDR_NO_PC);
    
    SHFT_B: ShiftRegister port map(ShiftInput => ExtendOut_DP, 
                                   ShiftOutput => BRANCH_PRE_ADD);
    
    RegFile: Registers generic map(width => 32)
                       port map(CLK => CLK_in, 
                                WEN => RegWrite, 
                                AddrR1 => Instruction_DP(25 downto 21), 
                                AddrR2 => Instruction_DP(20 downto 16), 
                                AddrWR => WRITE_ADDR, 
                                WriteReg => WRITE_BACK_DATA, 
                                LO => LO_DP,
                                HI => HI_DP,
                                ReadReg1 => ReadReg1_DP, 
                                ReadReg2 => ReadReg2_DP);
    
    InstMem: InstructionMemory generic map(width => MEMwidth, addr => addr, depth => depth)
                               port map (Address => PC_CURRENT, Clk => CLK_in,
                                         Instruction => Instruction_DP);
                               
    DatMem: DataMemory generic map(width => MEMwidth, addr => addr, depth => depth)
                       port map(CLK => CLK_in, 
                                WEN => MemWrite, 
                                REN => MemRead, 
                                WriteData => ReadReg2_DP, 
                                Address => R_DP, 
                                ReadData => ReadData_DP);
                    
    ADD_PC_Plus4: Adder port map(X => PC_CURRENT,
                                 Y => x"00000004",
                                 SUM => PC_PLUS4);
                                 
    ADD_PC_Branch: Adder port map(X => PC_PLUS4,
                                  Y => BRANCH_PRE_ADD,
                                  SUM => BRANCH_POST_ADD);
    
    --M1: MUX port map(SEL, A, B, O);
    
    ALU_2ndValue <= ExtendOut_DP when ALUSrc = '1' else ReadReg2_DP;
        -- MUX based on control signal ALUSrc
        
    WRITE_ADDR <= Instruction_DP(15 downto 11) when RegDst = '1' else Instruction_DP(20 downto 16);
        -- MUX based on control signal RegDst
        
    BRANCH_ADDR <= BRANCH_POST_ADD when (BRANCH AND Z_DP) = '1' else PC_PLUS4;
        -- MUX based on control signal Branch and Zero flag from ALU
        
    PC_NEXT <= JUMP_ADDR when JUMP = '1' else BRANCH_ADDR;
        -- MUX based on control signal JUMP (either PC+4, Branch, or JUMP) 
        
    WRITE_BACK_DATA <= ReadData_DP when MemToReg = '1' else R_DP;
        -- MUX based on control signal MemToReg (either Read from DataMem or ALU result) 
        
    JUMP_ADDR <= PC_PLUS4(31 downto 28) & JUMP_ADDR_NO_PC(27 downto 0);
        -- Assign JumpADDR first 4 bits of PC & INST(25-0) shifted by 2
        
    ShiftInput_DP <= "000000" & Instruction_DP(25 downto 0);
        -- Input INST(25-0) that will be shifted into JUMP_ADDR_NO_PC
        
    SHAMT_DP <= Instruction_DP(10 downto 6);
        -- Shift amount for ALU instruction 
        
    FUNCT_DP <= Instruction_DP(5 downto 0);
        -- ALU Control function based on INST(5)
        
    OPCODE_DP <= Instruction_DP(31 downto 26);
        -- Assign opcode based on INST(31-26)
    
    process(CLK_in)
        begin
        if rising_edge(CLK_in) then
            PC_CURRENT <= PC_NEXT;
        end if;
    end process;
    
end Behavioral;