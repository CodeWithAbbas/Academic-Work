/*************************************************************************
@file 	reg.vhdl
@brief 	Register module in VHDL

@author Lead FPGA Engineer Abbas Ali (18jzele0237@uetpeshawar.edu.pk)

@note 	The VHDL code represents a register module with configurable width.
		The register is positive edge-triggered and has asynchronous reset.
		It includes inputs such as clock (clk), reset (rst), enable (en),
		and data input (D). The output is the register's stored value (Q).
********************************************************************************/

library ieee;
use ieee.std_logic_1164.all;

entity reg is
  Generic (N : INTEGER := 16);  -- N specifies the width of the register
  Port
  (
    -- Input 
    clk : in std_logic;
    rst : in std_logic;
    en  : in std_logic;
    D 	: in std_logic_vector (N-1 downto 0);
    -- Output
    Q 	: out std_logic_vector (N-1 downto 0)
  );
end reg;

architecture arch of reg is
  signal output : std_logic_vector(N-1 downto 0);
 
begin
  process (clk) 
  begin
    if rising_edge(clk) then
      if (rst = '1') then
        output <= (others => '0');  -- Reset the register to all zeros when the reset signal is active
      elsif (en = '1') then
        output <= D;  -- Store the input data when the enable signal is active
      end if;
    end if;
  end process;
	
  Q <= output;  -- Output the stored value of the register

end arch;
