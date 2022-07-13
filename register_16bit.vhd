library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

Entity register_16bit is 

	generic ( reg_width: positive:= 16);
	port (
		clk			: in std_logic	:= '0';
		rst			: in std_logic := '0';
		enable		: in std_logic;
		din			: in std_logic;
		dout			: out std_logic_vector(reg_width - 1 downto 0)
	);
end register_16bit;

architecture Behavioral OF register_16bit IS
	signal reg		: std_logic_vector(reg_width - 1 downto 0);

begin
	process (clk, rst, enable) is
		begin
			if (rst = '0') then
			reg <= "0000000000000000";
			
			elsif (falling_edge(clk) AND (enable = '0')) then
			
				--reg <= "1111111111111111";
				reg <= reg((reg_width - 2) downto 0) & din;
				
			end if;
	end process;
	dout <= reg;
end Behavioral;