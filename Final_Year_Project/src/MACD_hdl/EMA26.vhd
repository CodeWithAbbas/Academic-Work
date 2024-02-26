/*************************************************************************
@file 	ema26.vhdl
@brief  Exponential Moving Average (EMA26) module in VHDL

@author Lead FPGA Engineer Abbas Ali (18jzele0237@uetpeshawar.edu.pk)

@note 	The VHDL code represents an EMA26 module with configurable width.
		It includes inputs such as clock, reset, selection signal, two input vectors,
		and enable signals. The output is the Exponential Moving Average (EMA26) output.
********************************************************************************/

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

-- ema26
entity ema26 is
  generic (N : integer := 17; M : integer := 5);
  port 
  ( 	
    -- Inputs
    clk : in std_logic;
    rst : in std_logic;
    in_1 : in std_logic_vector(N+M-1 downto 0); 
    in_2 : in std_logic_vector(N-1 downto 0); 
    csel  : in std_logic;
    en_reg1  : in std_logic; 
    en_reg2  : in std_logic; 
    en_reg3  : in std_logic; 

    ema26_out : out std_logic_vector(N-1 downto 0)
  );
end ema26;

architecture arch of ema26 is
  -- Internal signals
  signal mult1 : std_logic_vector(43 downto 0);
  signal mult2 : std_logic_vector(32 downto 0);
  signal mult3 : std_logic_vector(32 downto 0);
  signal ema26 : std_logic_vector(N-1 downto 0); 
  signal sma_26 : std_logic_vector(N-1 downto 0); 
  signal mux_out : std_logic_vector(N-1 downto 0); 
  signal reg1_out : std_logic_vector(N-1 downto 0); 
  signal reg2_out : std_logic_vector(N-1 downto 0); 
  signal reg3_out : std_logic_vector(N-1 downto 0); 
  signal adder_out: std_logic_vector(32 downto 0); 
  signal r_shift16 : std_logic_vector(N-1 downto 0); 
  signal mult1_trunc : std_logic_vector(32 downto 0); 
  signal adder_trunc : std_logic_vector(32 downto 0); 
	
  -- Constants
  constant K1_constant1 : std_logic_vector(15 downto 0):=x"12F6";
  constant K1_constant2 : std_logic_vector(15 downto 0):=x"ED09";

begin
  -- Calculation of SMA i.e. Avg
  mult1 <= std_logic_vector(unsigned(in_1)*2520); -- Multiply in_1 by a constant (33 bits result)
  mult1_trunc <= mult1(32 downto 0); -- Truncate to 33 bits
  sma_26 <= mult1_trunc(32 downto 16);  -- Right shift by 16 (17 bits)
	
  mux_out <= sma_26 when (csel = '1') else r_shift16;
	
  -- Register instantiation for the second input
  reg2 : entity work.reg generic map (N => N) port map (clk => clk, rst => rst, en => en_reg2, D => mux_out, Q => reg2_out); 
  -- Register instantiation for the first input
  reg1 : entity work.reg generic map (N => N) port map (clk => clk, rst => rst, en => en_reg1, D => in_2, Q => reg1_out); 
	
  -- Multiplications with constants
  mult2 <= std_logic_vector(unsigned(reg2_out) * unsigned(K1_constant2)); -- 33 bits
  mult3 <= std_logic_vector(unsigned(reg1_out) * unsigned(K1_constant1)); -- 30 bits
	
  -- Addition of the multiplication results
  adder_out <= mult2 + mult3;
	
  adder_trunc <= adder_out(32 downto 0); -- Truncate to 33 bits
  r_shift16 <= adder_trunc(32 downto 16);  -- Right shift by 16 (17 bits)
	
  ema26 <= mux_out;  -- EMA output
  -- Register instantiation for the EMA output
  reg_3 : entity work.reg generic map (N => N) port map (clk => clk, rst => rst, en => en_reg3, D => ema26, Q => reg3_out); 
  ema26_out <= reg3_out;  -- Output

end arch;
