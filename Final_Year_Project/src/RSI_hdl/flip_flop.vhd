/**
 * @file flip_flop.v
 * @brief D Flip-Flop implementation with asynchronous reset and enable.
 * @author Lead FPGA Engineer Abbas Ali (18jzele0237@uetpeshawar.edu.pk)
 */

`timescale 1ns/100ps

library ieee;
use ieee.std_logic_1164.all;

/**
 * @brief flip_flop module implements a D Flip-Flop with asynchronous reset and enable.
 * @details The module has input signals clk (clock), rst (asynchronous reset), en (enable),
 * and D (data input), and an output signal Q representing the flip-flop output.
 * 
 * @param clk - Clock input.
 * @param rst - Asynchronous reset input (active high).
 * @param en  - Enable input.
 * @param D   - Data input.
 * @param Q   - Output representing the flip-flop output.
 */
entity flip_flop is
  Port
  (
    -- Input 
    clk : in std_logic;
    rst : in std_logic;
    en  : in std_logic;
    D   : in std_logic;
    -- Output
    Q   : out std_logic
  );
end flip_flop;

/**
 * @brief Architecture of the flip_flop module.
 * @details The architecture implements a D Flip-Flop with asynchronous reset and enable.
 */
architecture arch of flip_flop is

  signal output : std_logic;
 
begin
  process (clk) 
  begin
    if rising_edge(clk) then
      if (rst = '1') then
        output <= '0';  
      elsif (en = '1') then
        output <= D;
      end if;
    end if;
  end process;
  
  /**
   * @brief Assign the output of the flip-flop to the Q signal.
   * @details This statement assigns the internal signal 'output' to the output Q.
   */
  Q <= output; 

end arch;
