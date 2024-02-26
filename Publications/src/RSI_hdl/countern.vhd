/*************************************************************************
@file 	up_counter.vhdl
@brief 	Up counter module

@author Lead FPGA Engineer Abbas Ali (18jzele0237@uetpeshawar.edu.pk)

@note 	The VHDL code represents an up counter module. It is a generic counter 
		with configurable width (N bits). The counter increments on each rising 
		edge of the clock signal when the enable (en) signal is asserted. 
		The counter can be loaded with a new value using the load (ld) signal.
		Reset (rst) is asynchronous.

********************************************************************************/

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Up Counter Entity
entity countern is
	generic (N : integer := 4);  -- Generic parameter for specifying counter width
	port ( 	  
		clk : in std_logic;   -- Clock input
		rst : in std_logic;   -- Reset input (asynchronous)
	    ld 	: in std_logic;   -- Load input
	    en 	: in std_logic;   -- Enable input
		input  : in std_logic_vector(N-1 downto 0);  -- Input data for loading
        output : out std_logic_vector(N-1 downto 0)  -- Counter output
	);
end countern;

architecture up of countern is
	signal temp : std_logic_vector(N-1 downto 0);  -- Internal signal to hold counter value
begin
	
	process( clk )
	begin
		if rising_edge( clk ) then
			if (rst = '1') then
				temp <= (others => '0');  -- Reset the counter to zero
			elsif (ld = '1') then
				temp <= input;  -- Load new value into the counter
			elsif ( en = '1' ) then
				temp <= temp + 1;  -- Increment the counter
			end if;
		end if;
	end process;  
	
	output <= temp;  -- Output the counter value
end up;
