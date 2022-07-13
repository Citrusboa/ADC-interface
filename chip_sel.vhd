library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity chip_sel is
	Port 	(clk_cs	: in std_logic;
			 rst		: in std_logic;
			 chip_s	: out std_logic
			 );
end chip_sel;

architecture behavioral of chip_sel is
	signal selector : std_LOGIC := '0';   			--- selector waits for 16 clock cycles
	signal cycle: integer range 0 to 15	:= 0;
	
begin
	process(clk_cs, rst)
	begin 
		if (rst = '0') then
			cycle	<= 0;
			selector <= '1';
		elsif (rising_edge(clk_cs)) then
				
			if (cycle = 15) then
				cycle <= 0;
				selector <= not selector;
			else
				cycle <= cycle + 1;
			end if;
			
		end if;
	end process;
	
	chip_s <= selector;
	
end behavioral;
