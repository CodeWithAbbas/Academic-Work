/**
 * @file shift_reg.v
 * @brief Shift Register module implementation with right and left shift options.
 * @author Lead FPGA Engineer Abbas Ali (18jzele0237@uetpeshawar.edu.pk)
 */

`timescale 1ns/100ps

library ieee;
use ieee.std_logic_1164.all;

/**
 * @brief shift_reg module implements a shift register with right and left shift options.
 * @details The module has a generic parameter N specifying the size of the shift register.
 * Input signals include clk (clock), enable (shift enable), load (load data), sin (serial input),
 * and d (parallel input data). The output signal q represents the shift register output.
 * 
 * @param N       - Size of the shift register.
 * @param clk     - Clock input.
 * @param enable  - Shift enable input.
 * @param load    - Load data input (active high).
 * @param sin     - Serial input.
 * @param d       - Parallel input data.
 * @param q       - Output representing the shift register output.
 */
entity shift_reg is
  generic (N : integer := 17);
  port (
    clk    : in std_logic;
    enable : in std_logic;
    load   : in std_logic;
    sin    : in std_logic;
    d      : in std_logic_vector(N-1 downto 0);
    q      : out std_logic_vector(N-1 downto 0)
  );
end shift_reg;

/**
 * @brief right_shift architecture of the shift_reg module.
 * @details This architecture implements a shift register with right shift option.
 */
architecture right_shift of shift_reg is
  signal qt: std_logic_vector(N-1 downto 0);

begin
  process (clk)
  begin
    if rising_edge(clk) then
      if load = '1' then
        qt <= d;
      else
        if enable = '1' then
          qt <= sin & qt(N-1 downto 1);
        end if;
      end if;
    end if;
  end process;
  
  /**
   * @brief Assign the output of the shift register to the q signal.
   * @details This statement assigns the internal signal 'qt' to the output q.
   */
  q <= qt;

end right_shift;

/**
 * @brief left_shift architecture of the shift_reg module.
 * @details This architecture implements a shift register with left shift option.
 */
architecture left_shift of shift_reg is
  signal qt: std_logic_vector(N-1 downto 0);

begin
  process (clk)
  begin
    if rising_edge(clk) then
      if load = '1' then
        qt <= d;
      else
        if enable = '1' then
          qt <= qt(N-2 downto 0) & sin;
        end if;
      end if;
    end if;
  end process;
  
  /**
   * @brief Assign the output of the shift register to the q signal.
   * @details This statement assigns the internal signal 'qt' to the output q.
   */
  q <= qt;

end left_shift;
