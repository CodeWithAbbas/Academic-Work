/*************************************************************************
@file 	RAM.vhdl
@brief 	RAM (Random Access Memory) module in VHDL

@author Lead FPGA Engineer Abbas Ali (18jzele0237@uetpeshawar.edu.pk)

@note 	The VHDL code represents a RAM module with a specified address width,
		data width, and the number of memory locations. It has ports for 
		address input (ADDR), data input (DIN), write enable (WE), clock (CLK),
		and data output (DOUT).

		The RAM has a generic parameterized address width and data width.
		The total number of memory locations is calculated as 2^Addr_width.
		The RAM module initializes all memory locations with zeros.

		The RAM memory is implemented as an array of std_logic_vectors.

********************************************************************************/

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity RAM is
Generic 
(     
	addr_width  	: integer := 2;  -- Address is 2 bits
    data_width   	: integer := 8   -- Data is 8 bits
    -- 2^Addr_width * data_width = 2^2 * 8 RAM = 4 * 8 RAM => 4 Memory Locations each having 8 bits of data
);
Port
(
	 ADDR: in std_logic_vector(addr_width-1 downto 0);  -- Address input
	 DIN: in std_logic_vector(data_width-1 downto 0);   -- Data input
	 WE: in std_logic;                                  -- Write enable signal
	 CLK: in std_logic;                                 -- Clock signal
	 DOUT: out std_logic_vector(data_width-1 downto 0) -- Data output
);
end RAM;

architecture arch of RAM is
    -- RAM memory array
	type ram_array is array (0 to 2**9-1) of std_logic_vector (data_width-1 downto 0);
	signal ram_memory : ram_array := (others => (others => '0'));  -- All memory locations initialize with 0

	signal addr_reg : std_logic_vector(addr_width-1 downto 0);  -- Internal signal to hold the address

begin
	-- Process for synchronous behavior
	process(CLK)
	begin
		if(rising_edge(CLK)) then
			-- Check if write enable is active
			if(WE='1') then 
				-- Write data to the specified address
				ram_memory(conv_integer(ADDR)) <= DIN;
			end if;
			
			-- Update internal address register
			addr_reg <= ADDR;
		end if;
	end process;
	
	-- Output the data from the specified address
	DOUT <= ram_memory(conv_integer(addr_reg));
end arch;
