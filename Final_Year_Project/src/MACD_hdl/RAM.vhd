/*************************************************************************
@file 	RAM.vhdl
@brief 	8-bit RAM module in VHDL

@author Lead FPGA Engineer Abbas Ali (18jzele0237@uetpeshawar.edu.pk)

@note 	The VHDL code represents an 8-bit RAM module with configurable
		address width and data width. It supports write enable (WE), 
		clock (CLK), read and write addresses (ADDR), and data input (DIN).
		The output is the data output (DOUT) corresponding to the read address.
********************************************************************************/

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity RAM is
  Generic 
  (     
    addr_width  : integer := 2;  -- Address is 2 bits
    data_width  : integer := 8   -- Data is 8 bits
    -- 2^Addr_width * data_width = 2^2 * 8 RAM = 4 * 8 RAM => 4 Memory Locations each having 8 bits of data
  );
  Port
  (
    ADDR: in std_logic_vector(addr_width-1 downto 0); 
    DIN: in std_logic_vector(data_width-1 downto 0);
    WE: in std_logic; 
    CLK: in std_logic; 
    DOUT: out std_logic_vector(data_width-1 downto 0)
  );
end RAM;

architecture arch of RAM is

  type ram_array is array (0 to 2**9-1) of std_logic_vector (data_width-1 downto 0);
  signal ram_memory : ram_array := (others => (others => '0'));  -- All memory locations initialize with 0

begin
  process(CLK)
  begin
    if(rising_edge(CLK)) then
      if(WE='1') then 
        ram_memory(conv_integer(ADDR)) <= DIN;  -- Write data to the specified address if WE is active
      end if;
    end if;
  end process;
  
  DOUT <= ram_memory(conv_integer(ADDR));  -- Read data from the specified address and provide it at the output

end arch;
