/*************************************************************************
@file 	div_rom14.vhdl
@brief 	Division ROM module in VHDL

@author Lead FPGA Engineer Abbas Ali (18jzele0237@uetpeshawar.edu.pk)

@note 	The VHDL code represents a ROM module that stores 14-bit division 
		constants. It takes a 4-bit address as input and outputs an 8-bit 
		constant (Cout) based on the address.

		The memory array 'memory' contains 16 8-bit constants. The ROM
		module selects the constant based on the input address. The ROM
		module uses the "to_integer(unsigned(addr))" conversion to access
		the correct entry in the memory array.

********************************************************************************/

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity div_rom14 is
    Port ( addr : in STD_LOGIC_VECTOR (3 downto 0);  -- 4-bit address input
           Cout : out STD_LOGIC_VECTOR (7 downto 0));  -- 8-bit output for division constant
end div_rom14;

architecture Behavioral of div_rom14 is
    type vector is Array(0 to 15) of Std_logic_vector(7 downto 0);
    -- Memory array containing 14-bit division constants
    Constant memory: vector:=
        (0=>x"64",
         1=>x"5D",
         2=>x"56",
         3=>x"4F",
         4=>x"47",
         5=>x"40",
         6=>x"39",
         7=>x"32",
         8=>x"2B",
         9=>x"24",
         10=>x"1D",
         11=>x"15",
         12=>x"0E",
         13=>x"07",
         14=>x"00",
         15=>x"00"
        );
begin
    -- Assigning the output based on the address
    Cout <= memory(to_integer(unsigned(addr)));
end Behavioral;
