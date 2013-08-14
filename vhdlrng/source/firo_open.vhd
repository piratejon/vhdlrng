library ieee;
use ieee.std_logic_1164.all;

entity firo_open is
	port (
		a, b : in std_logic;
		x, y : out std_logic
	);
end firo_open;

architecture behavior of firo_open is
	component lut4_inverter is
		port (
			a : in std_logic;
			y : out std_logic
		);
	end component;

begin
--	x <= a;
--	y <= not b;

	l4i : lut4_inverter port map(a=>b, y=>y);
	x <= a;
end behavior;
