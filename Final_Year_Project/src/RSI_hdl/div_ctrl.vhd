/*************************************************************************
@file 	   div_ctrl.vhdl
@brief 	   Divider Control module for RSI

@author Lead FPGA Engineer Abbas Ali (18jzele0237@uetpeshawar.edu.pk)

@details   The VHDL code represents a Divider Control module, responsible
           for generating control signals for a divider circuit. The module
           uses state machines to control the divider operation based on 
           input status signals and generate various control signals for 
           the divider.

@note      This module assumes an 11-stage divider operation with control
           signals tailored for specific stages of the division process.

@inputs
   clk         : Clock input
   rst         : Reset input
   gt0 to gt11 : Status signals indicating the comparison result of each stage
   zi11        : Unused status signal

@outputs
   Li          : Load input to the divider
   Ei          : Enable input to the divider
   ld_sr0 to ld_sr11 : Load signals for each stage of the divider
   sel_mux0 to sel_mux11 : Multiplexer select signals for each stage
   en_gt0      : Enable signal for the first stage of the divider

******************************************************************************/

library ieee;
use ieee.std_logic_1164.all;

-- Divider Control Entity
entity div_ctrl is
  port(     
    clk : in std_logic;   -- Clock input
    rst : in std_logic;   -- Reset input
    -- status signals
    gt0 : in std_logic;
    gt1 : in std_logic;
    gt2 : in std_logic;
    gt3 : in std_logic;
    gt4 : in std_logic;
    gt5 : in std_logic;
    gt6 : in std_logic;
    gt7 : in std_logic;
    gt8 : in std_logic;
    gt9 : in std_logic;
    gt10 : in std_logic;
    gt11 : in std_logic;
    zi11 : in std_logic;
    -- control signals
    Li : out std_logic;
    Ei : out std_logic;
    ld_sr0 : out std_logic;
    ld_sr1 : out std_logic;
    ld_sr2 : out std_logic;
    ld_sr3 : out std_logic;
    ld_sr4 : out std_logic;
    ld_sr5 : out std_logic;
    ld_sr6 : out std_logic;
    ld_sr7 : out std_logic;
    ld_sr8 : out std_logic;
    ld_sr9 : out std_logic;
    ld_sr10 : out std_logic;
    ld_sr11 : out std_logic;  
    sel_mux0 : out std_logic;
    sel_mux1 : out std_logic;
    sel_mux2 : out std_logic;
    sel_mux3 : out std_logic;
    sel_mux4 : out std_logic;
    sel_mux5 : out std_logic;
    sel_mux6 : out std_logic;
    sel_mux7 : out std_logic;
    sel_mux8 : out std_logic;
    sel_mux9 : out std_logic;
    sel_mux10 : out std_logic;
    sel_mux11 : out std_logic;
    en_gt0 : out std_logic
  );
end div_ctrl;

architecture arch of div_ctrl is

  -- Enumeration type for the state machine
  type state_type is (
    S_load, S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11,
    S12, S13, S14, S15, S16, S17, S18, S19, S20, S21, S22, S_done
  );
  signal state : state_type;  

begin

  -- State machine process
  process(clk)
  begin
    if (rising_edge(clk)) then
      if (rst = '1') then  -- Synchronous reset (active low)
        state <= S_load;
      else
        case (state) is
          when S_load =>
            state <= S0;
          when S0 =>
            state <= S1;
          when S1 =>
            state <= S2;
          when S2 =>
            state <= S3;
          when S3 =>
            state <= S4;
          when S4 =>
            state <= S5;
          when S5 =>
            state <= S6;
          when S6 =>
            state <= S7;
          when S7 =>
            state <= S8;
          when S8 =>
            state <= S9;
          when S9 =>
            state <= S10;
          when S10 =>
            state <= S11;     
          when S11 =>
            state <= S12;
          when S12 =>
            state <= S13;
          when S13 =>
            state <= S14;
          when S14 =>
            state <= S15;
          when S15 =>
            state <= S16;
          when S16 =>
            state <= S17;
          when S17 =>
            state <= S18;
          when S18 =>
            state <= S19;            
          when S19 =>
            state <= S20;
          when S20 =>
            state <= S21;
          when S21 =>
            state <= S22;
          when S22 =>
            state <= S_done;
          when S_done =>
            state <= S_done;
          when others =>
            state <= S_load;
        end case; 
      end if;
    end if; 
  end process;

  -- Control signal assignments
  Li <= '0' when (state = S_load) else '1'; 
  Ei <= '0'; 
  
  sel_mux0 <= '1'  when (gt0 = '1')  else '0'; 
  sel_mux1 <= '1'  when (gt1 = '1')  else '0'; 
  sel_mux2 <= '1'  when (gt2 = '1')  else '0'; 
  sel_mux3 <= '1'  when (gt3 = '1')  else '0'; 
  sel_mux4 <= '1'  when (gt4 = '1')  else '0'; 
  sel_mux5 <= '1'  when (gt5 = '1')  else '0'; 
  sel_mux6 <= '1'  when (gt6 = '1')  else '0'; 
  sel_mux7 <= '1'  when (gt7 = '1')  else '0'; 
  sel_mux8 <= '1'  when (gt8 = '1')  else '0'; 
  sel_mux9 <= '1'  when (gt9 = '1')  else '0'; 
  sel_mux10 <= '1' when (gt10 = '1') else '0';
  sel_mux11 <= '1' when (gt11 = '1') else '0';
  
  ld_sr0 <= '1'  when (state = S_load) else '0';
  ld_sr1 <= '1'  when (state = S_load) else '0';
  ld_sr2 <= '1'  when (state = S_load) else '0';
  ld_sr3 <= '1'  when (state = S_load) else '0';
  ld_sr4 <= '1'  when (state = S_load) else '0';
  ld_sr5 <= '1'  when (state = S_load) else '0';
  ld_sr6 <= '1'  when (state = S_load) else '0';
  ld_sr7 <= '1'  when (state = S_load) else '0';
  ld_sr8 <= '1'  when (state = S_load) else '0';
  ld_sr9 <= '1'  when (state = S_load) else '0';
  ld_sr10 <= '1' when (state = S_load) else '0';
  ld_sr11 <= '1' when (state = S_load) else '0';
  
  en_gt0 <= '0' when (state = S_load or state = S_done) else '1';

end arch;
