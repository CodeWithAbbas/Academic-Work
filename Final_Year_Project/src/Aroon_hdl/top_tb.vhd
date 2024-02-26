/*************************************************************************
@file 	top_tb.vhdl
@brief 	Testbench for the top-level module

@author Lead FPGA Engineer Abbas Ali (18jzele0237@uetpeshawar.edu.pk)

@note 	The VHDL code represents the testbench for the top-level module. 
		It initializes signals, generates clock, and reads data from files 
		("Aroon_data.txt" and "arron_down_data.txt") to simulate the 
		behavior of the system. The testbench includes a process for 
		handling the stimulus and observing the output.

********************************************************************************/

library IEEE;
use IEEE.Std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

USE ieee.std_logic_textio.all;
LIBRARY std;
USE std.textio.all;

entity top_tb is
	generic (N : integer := 18);  -- Generic parameter for specifying the number of bits
end;

architecture bench of top_tb is

  signal clk: std_logic:= '1';
  signal rst: std_logic:= '1';
  signal Go: std_logic:= '0';
  signal we_ramA: std_logic;
  signal we_ramB: std_logic;
  signal high_price: std_logic_vector(N-1 downto 0);
  signal low_price: std_logic_vector(N-1 downto 0);
  signal addr_read: std_logic_vector(N-1 downto 0);
  signal order_signal: std_logic_vector(1 downto 0);
  signal Done: std_logic;
  constant clk_period: time := 6.532 ns;
		
begin

	-- Insert values for generic parameters !!
	uut: entity work.top generic map ( N => N ) port map ( clk => clk, rst => rst, Go => Go, we_ramA => we_ramA, we_ramB => we_ramB , addr_read => addr_read, high_price => high_price, low_price => low_price, order_signal => order_signal, Done => Done);

	-- Clock 
	clk <= not clk after clk_period/2;
  
	stimulus: process
  
		FILE vectorFile: TEXT OPEN READ_MODE is "Aroon_data.txt";  -- File for high price data
        FILE vectorFile_1: TEXT OPEN READ_MODE is "arron_down_data.txt";  -- File for low price data

		VARIABLE VectorLine: LINE;  -- Line by line access
		VARIABLE test_input: integer;
        VARIABLE VectorLine_1: LINE;  -- Line by line access
        VARIABLE test_input_1: integer;
        file file_pointer : text;
        variable line_num : line;
        file file_pointer_1 : text;
        variable line_num_1 : line;
          
	begin
		-- Hold reset state for 100 ns.
		wait for 10*clk_period;
		rst <= '0';
		we_ramA <= '1';
		we_ramB <= '1';
		
		-- Open output files for writing
		file_open(file_pointer, "D:\University Data\FYP Material\FPGA Programs in Vivado\Top Level Designing\Aroon Indicator\Vivado_Implementation\Aroon_with_Clock\Aroon_clk\Arron_down_output.txt", WRITE_MODE); 
	    file_open(file_pointer_1, "D:\University Data\FYP Material\FPGA Programs in Vivado\Top Level Designing\Aroon Indicator\Vivado_Implementation\Aroon_with_Clock\Aroon_clk\Arron_up_output.txt", WRITE_MODE); 

		-- Reading close price data from Memory
		for i in 0 to 199 loop
			readline(vectorFile, VectorLine);  -- Put file data into line
			read(VectorLine, test_input);
			readline(vectorFile_1, VectorLine_1);  -- Put file data into line
            read(VectorLine_1, test_input_1);
			addr_read <= std_logic_vector(to_unsigned(i, addr_read'Length));
			high_price <= std_logic_vector(to_unsigned(test_input, high_price'Length));
			low_price <= std_logic_vector(to_unsigned(test_input_1, low_price'Length));
			
			wait for clk_period;
		end loop;
	
		we_ramA <= '0'; 
		we_ramB <= '0'; 
		addr_read <= (others => '0');
		Go <= '1';  
		
		wait until Done = '1'; 
		wait; 
	end process;
end;
