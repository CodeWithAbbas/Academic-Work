/**
 * @file reg.v
 * @brief Register (Reg) module implementation with asynchronous reset and enable.
 * @author Lead FPGA Engineer Abbas Ali (18jzele0237@uetpeshawar.edu.pk)
 */

`timescale 1ns/100ps

library ieee;
use ieee.std_logic_1164.all;

/**
 * @brief reg module implements a register with asynchronous reset and enable.
 * @details The module has a generic parameter N specifying the number of bits in the register.
 * Input signals include clk (clock), rst (asynchronous reset), en (enable), and D (data input).
 * The output signal Q represents the registered output.
 * 
 * @param N   - Number of bits in the register.
 * @param clk - Clock input.
 * @param rst - Asynchronous reset input (active high).
 * @param en  - Enable input.
 * @param D   - Data input.
 * @param Q   - Output representing the registered output.
 */
entity reg is
  Generic (N : INTEGER := 16);  -- N will specify the reg bits  
  Port
  (
    -- Input 
    clk : in std_logic;
    rst : in std_logic;
    en  : in std_logic;
    D   : in std_logic_vector (N-1 downto 0);
    -- Output
    Q   : out std_logic_vector (N-1 downto 0)
  );
end reg;

/**
 * @brief Architecture of the reg module.
 * @details The architecture implements a register with asynchronous reset and enable.
 */
architecture arch of reg is

  signal output : std_logic_vector(N-1 downto 0);
 
begin
  process (clk) 
  begin
    if rising_edge(clk) then
      if (rst = '1') then
        output <= (others => '0');  
      elsif (en = '1') then
        output <= D;
      end if;
    end if;
  end process;
  
  /**
   * @brief Assign the output of the register to the Q signal.
   * @details This statement assigns the internal signal 'output' to the output Q.
   */
  Q <= output; 

end arch;
