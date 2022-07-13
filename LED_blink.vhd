library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity LED_blink is
	Port (clk 	: in STD_LOGIC;
			rst	: in STD_LOGIC;
			miso	: in STD_LOGIC;
			c_sel	: out STD_LOGIC;
			c_sel2: out STD_LOGIC;
			led 	: out STD_LOGIC;
			clk_out: out STD_LOGIC;
			display: out STD_LOGIC_VECTOR( 13 downto 0);
			led2	: out STD_LOGIC;
			led3	: out STD_LOGIC
			);
end LED_blink;

architecture Behavioral of LED_blink is

------ components-----------------------

---Clock Generation 50MHz -> 2Hz
component clock_gen
	Port (clk_in 	: in STD_LOGIC;
			rst	: in STD_LOGIC;
			clk_out	: out STD_LOGIC
			);
end component;

---Chip Selector
component chip_sel
	Port 	(clk_cs	: in STD_LOGIC;
			 rst		: in STD_LOGIC;
			 chip_s	: out STD_LOGIC
			 );
end component;

--- Seven Segment display
component seven_segment 
	port (hex	: in std_logic_vector(3 downto 0); ---- 4 bit stream data
			sevenseg: out std_logic_vector(6 downto 0) ---- 7-bit outputs to a 7-segment display
			);
end component;

component register_16bit  
	generic ( reg_width: positive:= 16);
	port (
		clk			: in std_logic	:= '0';
		rst			: in std_logic := '0';
		enable		: in std_logic	:= '0';
		din			: in std_logic;
		dout		: out std_logic_vector(reg_width - 1 downto 0)
	);
end component;

component segment_mux
	port (
		clk		: in std_logic := '0';
		din1		: in std_logic_vector(6 downto 0);
		din2		: in std_logic_vector(6 downto 0);
		dout		: out std_logic_vector(6 downto 0);
		dig1		: out std_logic;
		dig2		: out std_logic
		);
end component;

------- Signals-------------------------
	signal sclk : STD_LOGIC := '0';   			--- 2HZ clock used for ADC
	signal chip_led: STD_LOGIC;
	signal segone, segtwo: std_logic_vector(3 downto 0);
	signal hex: std_logic_vector(15 downto 0);
	signal enable: std_logic;
	
	begin	

------ component instances -----------------
clock_inst: clock_gen port map(clk, rst, sclk);
shreg: register_16bit port map(sclk, rst, enable, miso, hex);

selector_inst: chip_sel port map(sclk, rst, chip_led);
dig1_inst: seven_segment port map(hex(7 downto 4), display(13 downto 7));
dig2_inst: seven_segment port map(hex(3 downto 0), display(6 downto 0));


	enable <= chip_led;
	led3 <= chip_led;
	c_sel <= chip_led;
	c_sel2<= not chip_led;
	led <= sclk;
	led2 <= not sclk;
	clk_out <= sclk;
	
end Behavioral; 