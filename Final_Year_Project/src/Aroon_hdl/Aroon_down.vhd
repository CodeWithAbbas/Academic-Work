/*************************************************************************
@file 	down_dp.vhdl
@brief 	Aroon Down Data Path (down_dp) module in VHDL

@author Lead FPGA Engineer Abbas Ali (18jzele0237@uetpeshawar.edu.pk)
 
@note 	The VHDL code represents a Downward Data Path module with configurable width.
		It includes inputs such as clock, reset, enable signals, Zj_max signal,
		LL (Load) signal, clrL (Clear) signal, ramB_out signal, and outputs lwL (Less Than),
		and dout (output data vector).

		The module uses a register (reg1_out), a comparator (lwL), a counter (couter_H),
		and a ROM (Rom_high) to process the input data.

		The generic parameter N specifies the width of the data.

********************************************************************************/

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

-- down_dp
entity down_dp is
  generic (N : integer := 18);
  port 
  ( 	
    -- inputs	
    clk : in std_logic;
    rst : in std_logic := '1';

    en_reg1 : in std_logic;  
    enL : in std_logic;
    Zj_max : in std_logic;  	
    LL : in std_logic;  
    lwL : out std_logic;  
    clrL : in std_logic := '0';  
    ramB_out : in  std_logic_vector(N-1 downto 0);  
    dout : out std_logic_vector(7 downto 0)
  );
end down_dp;

architecture arch of down_dp is

  signal reg1_out : std_logic_vector(N-1 downto 0); 
  signal aroon_down : std_logic_vector(7 downto 0); 
  signal down_count : std_logic_vector(3 downto 0); 

  constant cntr_in : std_logic_vector(3 downto 0) := (others => '0');

begin
  -- Register
  reg_1 : entity work.reg generic map (N => N) port map (clk => clk, rst => rst, en => en_reg1, D => ramB_out, Q => reg1_out); 
  
  -- Comparator
  lwL <= '1' when (ramB_out < reg1_out) else '0';

  -- Counter H
  couter_H : entity work.countern generic map (N => 4) port map (clk => clk, rst => clrL, ld => LL, en => enL, input => cntr_in, output => down_count);

  -- ROM
  Rom_high: entity work.div_rom14 port map(addr  => down_count, cout => aroon_down);	

  dout <= aroon_down when Zj_max = '1' else (others => '0');
  
end arch;
