/*************************************************************************
@file 	reg.vhdl
@brief 	Sequential Register module in VHDL

@author Lead FPGA Engineer Abbas Ali (18jzele0237@uetpeshawar.edu.pk)

@note 	The VHDL code represents a sequential register module with a specified
		number of bits (N). It has ports for clock input (clk), reset (rst),
		enable (en), data input (D), and data output (Q).

		The register is designed to hold N bits of data. It is synchronous, 
		updating its output (Q) on the rising edge of the clock when enabled.
		The register has an optional asynchronous reset functionality.

********************************************************************************/

library ieee;
use ieee.std_logic_1164.all;

entity reg is
	Generic (N : INTEGER := 16);  -- N will specify the reg bits  
	Port
		(
		-- Input 
		clk : in std_logic;            -- Clock input
		rst : in std_logic;            -- Reset input (active high)
		en  : in std_logic;            -- Enable input
		D 	: in std_logic_vector (N-1 downto 0);  -- Data input
		-- Output
		Q 	: out std_logic_vector (N-1 downto 0)  -- Data output
		);
end reg;

architecture arch of reg is
 signal output : std_logic_vector(N-1 downto 0);  -- Internal signal to hold register content
 
begin
	-- Sequential Process for Register Behavior
	process (clk) 
	begin
		if rising_edge(clk) then
			if (rst = '1') then
				-- Reset the register to zero
				output <= (others => '0');
			elsif (en = '1') then
				-- Update the register with input data when enabled
				output <= D;
			end if;
		end if;
	end process;
	
	-- Assign the output of the register
	Q <= output; 

end arch;
