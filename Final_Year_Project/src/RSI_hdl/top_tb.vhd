/**
 * @file div_dp_tb.v
 * @brief Testbench for the div_dp module.
 * @author Lead FPGA Engineer Abbas Ali (18jzele0237@uetpeshawar.edu.pk)
 */

`timescale 1ns/100ps

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

/**
 * @brief div_dp_tb testbench entity.
 * @details This testbench sets up a clock, reset, and stimulus for the div_dp module.
 * The ina and inb inputs are initialized with predefined values, and the simulation runs for multiple cycles.
 * 
 * @param N - Generic parameter for div_dp module.
 */
entity div_dp_tb is
  generic (N : integer := 17);
end entity div_dp_tb;

/**
 * @brief Architecture of the div_dp_tb testbench.
 * @details This architecture initializes signals and constants, generates clock and stimulus,
 * and maps the div_top module with appropriate generic parameters.
 */
architecture bench of div_dp_tb is
  signal clk   : std_logic := '1';
  signal rst   : std_logic := '1';
  
  type b_array is array(0 to 11) of std_logic_vector(N-1 downto 0);
  constant inb_temp : b_array := (
    '1' & x"0000", '1' & x"5800", '1' & x"6800", '1' & x"2800",
    '0' & x"C800", '0' & x"E800", '1' & x"1000", '0' & x"8800",
    '0' & x"B800", '1' & x"8000", '0' & x"F800", '1' & x"3800"
  );

  type a_array is array(0 to 11) of std_logic_vector(N-1 downto 0);
  constant ina_temp : a_array := (
    '0' & x"0600",'0' & x"0580",'0' & x"0980",'0' & x"0A00",
    '0' & x"0B80",'0' & x"0A80",'0' & x"0B80",'0' & x"0A80",
    '0' & x"0B80",'0' & x"0A80",'0' & x"0980",'0' & x"0A80"
  );

  signal ina   : std_logic_vector(N-1 downto 0) := '0' & x"0600"; 
  signal inb   : std_logic_vector(N-1 downto 0);
  signal y     : std_logic_vector(N-1 downto 0);

  constant clk_period : time := 10 ns;

begin

  -- Instantiate the div_top module
  uut : entity work.div_top
    generic map (N => N)
    port map (
      clk => clk,
      rst => rst,
      ina => ina,
      inb => inb,
      y   => y
    );

  -- Clock generation process
  clk <= not clk after clk_period/2;

  -- Stimulus process
  stimulus : process
  begin
    -- Hold reset state for 100 ns.
    wait for 10 * clk_period;
    rst <= '0';

    wait for clk_period;

    for i in 0 to 11 loop
      inb <= inb_temp(i);
      ina <= ina_temp(i);
      wait for clk_period;
    end loop;

    wait;
  end process;

end architecture bench;
