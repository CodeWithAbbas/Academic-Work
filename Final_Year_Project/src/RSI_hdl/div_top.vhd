/**
 * @file div_top.v
 * @brief Top-level module for a configurable divider.
 * @author Lead FPGA Engineer Abbas Ali (18jzele0237@uetpeshawar.edu.pk)
 */

`timescale 1ns/100ps

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
use ieee.std_logic_unsigned.all;

/**
 * @brief div_top module is a top-level wrapper for the divider module.
 * @details This module instantiates the divider datapath (div_dp) and control (div_ctrl) modules
 * and connects them to create a complete divider functionality.
 * 
 * @param N - Bit width of the divisor and dividend.
 * @param clk - Clock input.
 * @param rst - Reset input (active high).
 * @param ina - Input signal representing the dividend.
 * @param inb - Input signal representing the divisor.
 * @param y - Output signal representing the quotient.
 */
entity div_top is
  generic ( N : integer := 17 ) ;
  Port ( 
    clk : in std_logic;
    rst : in std_logic;
    ina : in std_logic_vector (N-1 downto 0);
    inb:  in std_logic_vector (N-1 downto 0);
    y:  out std_logic_vector (N-1 downto 0)
  );
end div_top;

/**
 * @brief Architecture of the div_top module.
 * @details This architecture instantiates the datapath (div_dp) and control (div_ctrl) modules
 * and interconnects them to create a complete divider implementation.
 */
architecture rtl of div_top is

  signal sel_mux0 : std_logic;
  signal sel_mux1 : std_logic;
  signal sel_mux2 : std_logic;
  signal sel_mux3 : std_logic;
  signal sel_mux4 : std_logic;
  signal sel_mux5 : std_logic;
  signal sel_mux6 : std_logic;
  signal sel_mux7 : std_logic;
  signal sel_mux8 : std_logic;
  signal sel_mux9 : std_logic;
  signal sel_mux10 : std_logic;
  signal sel_mux11 : std_logic;   
  signal ld_sr0 :  std_logic;
  signal ld_sr1 :  std_logic;
  signal ld_sr2 :  std_logic;
  signal ld_sr3 :  std_logic;
  signal ld_sr4 :  std_logic;
  signal ld_sr5 :  std_logic;
  signal ld_sr6 :  std_logic;
  signal ld_sr7 :  std_logic;
  signal ld_sr8 :  std_logic;
  signal ld_sr9 :  std_logic;
  signal ld_sr10 : std_logic;
  signal ld_sr11 : std_logic; 
  signal en_gt0 : std_logic;
  signal gt0 : std_logic;
  signal gt1 : std_logic;
  signal gt2 : std_logic;
  signal gt3 : std_logic;
  signal gt4 : std_logic;
  signal gt5 : std_logic;
  signal gt6 : std_logic;
  signal gt7 : std_logic;
  signal gt8 : std_logic;
  signal gt9 : std_logic;
  signal gt10 : std_logic;
  signal gt11 : std_logic;

  signal Li : std_logic;
  signal Ei : std_logic;
  signal zi11 : std_logic;

begin

  /**
   * @brief Instantiate the datapath module.
   * @details The datapath module performs the actual division operation.
   * It calculates the quotient (y) based on the inputs ina and inb.
   */
  datapath : entity work.div_dp 
    port map (
      clk      => clk      ,
      rst      => rst      ,
      ina      => ina      ,
      inb      => inb      ,
      y        => y        ,
      sel_mux0 => sel_mux0 ,
      sel_mux1 => sel_mux1 ,
      sel_mux2 => sel_mux2 ,
      sel_mux3 => sel_mux3 ,
      sel_mux4 => sel_mux4 ,
      sel_mux5 => sel_mux5 ,
      sel_mux6 => sel_mux6 ,
      sel_mux7 => sel_mux7 ,
      sel_mux8 => sel_mux8 ,
      sel_mux9 => sel_mux9 ,
      sel_mux10 => sel_mux10,
      sel_mux11 => sel_mux11,
      Li       => Li       ,
      Ei       => Ei       ,
      zi11     => zi11     ,
      en_gt0   => en_gt0   ,
      ld_sr0   => ld_sr0   ,
      ld_sr1   => ld_sr1   ,
      ld_sr2   => ld_sr2   ,
      ld_sr3   => ld_sr3   ,
      ld_sr4   => ld_sr4   ,
      ld_sr5   => ld_sr5   ,
      ld_sr6   => ld_sr6   ,
      ld_sr7   => ld_sr7   ,
      ld_sr8   => ld_sr8   ,
      ld_sr9   => ld_sr9   ,
      ld_sr10  => ld_sr10  ,
      ld_sr11  => ld_sr11  
    );

  /**
   * @brief Instantiate the control module.
   * @details The control module manages the control signals needed for the datapath.
   * It controls the multiplexers, registers, and other components of the datapath.
   */
  Contrl_inst : entity work.div_ctrl 
    port map ( 
      clk      => clk      ,
      rst      => rst      ,
      sel_mux0 => sel_mux0 ,
      sel_mux1 => sel_mux1 ,
      sel_mux2 => sel_mux2 ,
      sel_mux3 => sel_mux3 ,
      sel_mux4 => sel_mux4 ,
      sel_mux5 => sel_mux5 ,
      sel_mux6 => sel_mux6 ,
      sel_mux7 => sel_mux7 ,
      sel_mux8 => sel_mux8 ,
      sel_mux9 => sel_mux9 ,
      sel_mux10 => sel_mux10,
      sel_mux11 => sel_mux11,
      Li       => Li       ,
      Ei       => Ei       ,
      zi11     => zi11     ,
      en_gt0   => en_gt0   ,
      ld_sr0   => ld_sr0   ,
      ld_sr1   => ld_sr1   ,
      ld_sr2   => ld_sr2   ,
      ld_sr3   => ld_sr3   ,
      ld_sr4   => ld_sr4   ,
      ld_sr5   => ld_sr5   ,
      ld_sr6   => ld_sr6   ,
      ld_sr7   => ld_sr7   ,
      ld_sr8   => ld_sr8   ,
      ld_sr9   => ld_sr9   ,
      ld_sr10  => ld_sr10  ,
      ld_sr11  => ld_sr11  ,  
      gt0      => gt0      ,
      gt1      => gt1      ,
      gt2      => gt2      ,
      gt3      => gt3      ,
      gt4      => gt4      ,
      gt5      => gt5      ,
      gt6      => gt6      ,
      gt7      => gt7      ,
      gt8      => gt8      ,
      gt9      => gt9      ,
      gt10     => gt10     ,
      gt11     => gt11     
    );

end rtl;
