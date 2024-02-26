/*************************************************************************
@file   countern.vhdl
@brief  Up counter module in VHDL

@author Lead FPGA Engineer Abbas Ali (18jzele0237@uetpeshawar.edu.pk)

@note   The VHDL code represents an up counter module with configurable
        bit-width (N). The counter is synchronous and increments on the
        rising edge of the clock (clk) signal. It supports features such
        as reset (rst), load (ld), and enable (en) signals.

        The counter value is stored in the 'temp' signal, and it is
        incremented based on the conditions specified in the process.

********************************************************************************/

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- up counter
entity countern is
  generic (N : integer := 4);          -- Generic for configuring bit-width
  port (
    clk : in std_logic;                 -- Clock input
    rst : in std_logic;                 -- Reset input (active high)
    ld  : in std_logic;                 -- Load input for loading a new value
    en  : in std_logic;                 -- Enable input for incrementing
    input  : in std_logic_vector(N-1 downto 0);  -- Input value for load
    output : out std_logic_vector(N-1 downto 0)  -- Output representing the counter value
  );
end countern;

architecture up of countern is
  signal temp : std_logic_vector(N-1 downto 0);  -- Internal signal to store the counter value
begin

  process( clk )
  begin
    if rising_edge( clk ) then
      if (rst = '1') then                   -- Synchronous reset
        temp <= (others => '0');
      elsif (ld = '1') then                  -- Load new value if ld is asserted
        temp <= input;
      elsif ( en = '1' ) then                -- Increment if en is asserted
        temp <= temp + 1;
      end if;
    end if;
  end process;  
  output <= temp;

end up;
