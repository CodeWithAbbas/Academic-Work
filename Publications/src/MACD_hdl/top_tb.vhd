/*************************************************************************
@file 	top_tb.vhdl
@brief 	Testbench for the top-level module in VHDL

@author Lead FPGA Engineer Abbas Ali (18jzele0237@uetpeshawar.edu.pk)

@note 	The VHDL testbench code verifies the functionality of the top-level
		module by providing stimuli and checking the results. It uses a clock
		(clk), reset (rst), go signal (go), write enable for RAM (we_ram),
		input vector (cp_in), and read address (addr_read). The outputs include
		done signal (done) and order signal (order_signal).
********************************************************************************/

library IEEE;
use IEEE.Std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

USE ieee.std_logic_textio.all;
LIBRARY std;
USE std.textio.all;

entity top_tb is
  generic (N : integer := 17);
end;

architecture bench of top_tb is

  signal clk: std_logic:= '1';
  signal rst: std_logic:= '1';
  signal go: std_logic:= '0';
  signal we_ram :  std_logic;
  signal cp_in : std_logic_vector(N-1 downto 0);
  signal addr_read : std_logic_vector(N-1 downto 0);

  signal done : std_logic;
  signal order_signal : std_logic_vector(1 downto 0);

  constant clk_period: time := 10 ns;

begin

  -- Insert values for generic parameters !!
  uut: entity work.top generic map ( N => N ) port map ( clk => clk, rst => rst, go => go, we_ram => we_ram, addr_read => addr_read, cp_in => cp_in, order_signal=>order_signal, done => done);

  -- Clock 
  clk <= not clk after clk_period/2;

  stimulus: process
  
    FILE vectorFile: TEXT OPEN READ_MODE is "MACD_Stock_data.txt"; -- file read
    VARIABLE VectorLine: LINE; -- line by line access
    VARIABLE space: CHARACTER;
    VARIABLE test_input: integer;
		
    begin
      -- hold reset state for 100 ns.
      wait for 10*clk_period;
      rst <= '0';
      we_ram <= '1';

      -- Receiving close price data from Memory
      for i in 0 to 199 loop
        readline(vectorFile, VectorLine); 				-- Put file data into line
        read(VectorLine,test_input);
      
        addr_read <= std_logic_vector(to_unsigned(i, addr_read'Length));
        cp_in <= std_logic_vector (to_unsigned(test_input, cp_in'Length));
        wait for clk_period;
      end loop;
    
      we_ram <= '0'; 
      go <= '1';  
      
      wait until done = '1'; 
      wait; 
    end process;
end;
