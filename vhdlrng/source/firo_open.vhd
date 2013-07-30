library ieee;
use ieee.std_logic_1164.all;

entity firo_open is
	port (
		a, b : in std_logic;
		x, y : out std_logic
	);
end firo_open;

architecture behavior of firo_open is
begin
	x <= a;
	y <= not b;
end behavior;
