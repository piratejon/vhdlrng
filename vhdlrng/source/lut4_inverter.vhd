library ieee;
use ieee.std_logic_1164.all;

library machxo2;
use machxo2.all;

entity lut4_inverter is
	port (
		a : in std_logic;
		y : out std_logic
	);
end lut4_inverter;

architecture structural of lut4_inverter is
	component LUT4
		generic ( init : std_logic_vector );
		port (
			A, B, C, D : in std_ulogic;
			Z : out std_ulogic
		);
	end component;
	
begin

	l4i : LUT4
		generic map ( init=>b"1111_1111_0000_0000" )
		port map ( A => 'X', B => 'X', C => 'X', D => a, Z => y );

end structural;
