library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity clock_gen is
	Port (clk_in 	: in STD_LOGIC;
			rst	: in STD_LOGIC;
			clk_out	: out STD_LOGIC
			);
end clock_gen;

architecture Behavioral of clock_gen is 

-----Signals--------------
	signal blink : std_LOGIC := '0';   			--- blink used for clk on ADC
	signal count : integer range 0 to 25000000 := 0;

begin 
	process(clk_in, rst) -- Clock generation clk=50Mhz -> clk_out=2Hz
		begin
			if(rst = '0') then
				count	<= 0;
				blink <= '0';
			elsif (rising_edge(clk_in)) then
				if (count = 24999999) then
					count <= 0;
					blink <= not blink;
				else
					count <= count + 1;
				end if;
			end if;
	end process;
	
	clk_out <= blink;
end Behavioral;