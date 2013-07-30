library ieee;
use ieee.std_logic_1164.all;

entity firo_closed is
	port (
		a, b : in std_logic;
		x, y : out std_logic
	);
end firo_closed;

architecture behavior of firo_closed is
begin
	x <= a xor (not b);
	y <= not b;
end behavior;
