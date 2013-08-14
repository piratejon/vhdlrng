library ieee;
use ieee.std_logic_1164.all;

entity firo_closed is
	port (
		a, b : in std_logic;
		x, y : out std_logic
	);
end firo_closed;

architecture behavior of firo_closed is
	component lut4_inverter is
		port (
			a : in std_logic;
			y : out std_logic
		);
	end component;
	
	signal not_b : std_logic;
	
begin
--	x <= a xor (not b);
--	y <= not b;

	l4i : lut4_inverter port map ( a => b, y => not_b );
	
	x <= a xor not_b;
	y <= not_b;
end behavior;
