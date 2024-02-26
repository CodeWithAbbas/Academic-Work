/*************************************************************************
@file 	top.vhdl
@brief 	Top-level module combining Data Path and Controller

@author Lead FPGA Engineer Abbas Ali (18jzele0237@uetpeshawar.edu.pk)

@note 	The VHDL code represents the top-level module that integrates the 
		Data Path and Controller modules. It has generic parameters for 
		specifying the number of bits (N). The module has ports for 
		clock input (clk), reset (rst), start signal (go), write enable 
		for RAMA (we_ramA), write enable for RAMB (we_ramB), high price data 
		(high_price), low price data (low_price), address for reading from 
		RAM (addr_read), done signal (done), and order signal (order_signal).

		The top-level module instantiates the Data Path (datapath) and 
		Controller (controller) modules. It connects their respective 
		ports and controls the overall functionality.

********************************************************************************/

library ieee;
use ieee.std_logic_1164.all;

-- top
entity top is
	generic (N : integer := 18);
	port 
	( 	-- Inputs 
		clk : in std_logic;                  -- Clock input
		rst : in std_logic;                  -- Reset input
		go : in std_logic;                   -- Start signal
		we_ramA : in std_logic;              -- Write enable for RAMA
		we_ramB : in std_logic;              -- Write enable for RAMB
		high_price : in std_logic_vector(N-1 downto 0);  -- High price data
		low_price : in std_logic_vector(N-1 downto 0);   -- Low price data
		addr_read : in std_logic_vector(N-1 downto 0);   -- Address for reading RAM
		-- Outputs
		done : out std_logic;                 -- Done signal
		order_signal : out std_logic_vector(1 downto 0)  -- Order signal
    );
end top;

architecture arch of top is

   signal S1 : std_logic;
   signal li : std_logic;
   signal lj : std_logic;
   signal lh : std_logic;
   signal LL : std_logic;
   signal Ei : std_logic;
   signal Ej : std_logic;
   signal en_buy : std_logic;
   signal en_sell : std_logic;
   signal enH : std_logic;
   signal enL : std_logic;
   signal gtH : std_logic;
   signal lwL : std_logic;
   signal clrH: std_logic;
   signal clrL: std_logic;
   signal Csel : std_logic;
   signal Zi_max : std_logic;
   signal Zj_max : std_logic;
   signal en_reg1 : std_logic;
   signal en_reg2 : std_logic;

begin 
	-- datapath Instant	
	datapath_inst: entity work.datapath 
    generic map ( N => N)
    port map
    ( 	 
	clk => clk,   
	rst => rst,  
	S1 => S1,
	Li => Li,
	Lj => Lj,
	lh => lh,
	LL => LL,
	en_buy => en_buy,
	en_sell => en_sell,
	enH => enH,
	enL => enL,
	Ei => Ei,
	Ej => Ej,
	en_reg1 => en_reg1,
	en_reg2 => en_reg2,
	gtH => gtH,
	lwL => lwL,
	clrH => clrH,
	clrL => clrL,
	we_ramA   => we_ramA,
	we_ramB   => we_ramB,
	Csel   => Csel,
	addr_read => addr_read,
	high_price => high_price,
	low_price => low_price,
	Zi_max => Zi_max,
	Zj_max => Zj_max,
	order_signal => order_signal 
	);

	-- Controller Instant
	controller_inst: entity work.controller 
	port map
	( 	  
	clk	=> clk,	
	rst => rst,  
	Go 	=> Go,	 
	S1 => S1,
	Li => Li,
	Lj => Lj,
	lh => lh,
	LL => LL,
	en_buy => en_buy,
	en_sell => en_sell,
	enH => enH,
	enL => enL,
	Ei => Ei,
	Ej => Ej,
	en_reg1 => en_reg1,
	en_reg2 => en_reg2,
	gtH => gtH,
	lwL => lwL,
	clrH => clrH,
	clrL => clrL,
	Csel   => Csel,
	Zi_max => Zi_max,
	Zj_max => Zj_max,
	Done => Done  
	);
	
end arch;
