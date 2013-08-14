library ieee;
use ieee.std_logic_1164.all;

entity fibonacci_ring_oscillator is
	generic (
		---- Dichtl & Golic 2008: x^15 + x^14 + x^7 + x^6 + x^5 + x^4 + x^2 + 1
		poly : std_logic_vector := "1100000011110101"
	);
	
	port (
		rnd_port : inout std_logic
	);
end fibonacci_ring_oscillator;

architecture GEN of fibonacci_ring_oscillator is
	component firo_open is
		port (
			a, b : in std_logic;
			x, y : out std_logic
		);
	end component;

	component firo_closed is
		port (
			a, b : in std_logic;
			x, y : out std_logic
		);
	end component;

	signal a_in, b_in, x_out, y_out : std_logic_vector(15 downto 0);

begin

	b_in(0) <= x_out(0);

	firo_generate_loop : for i in 0 to (poly'length - 1) generate
		firo_open_generate : if (poly(i) = '0') generate
			firo: firo_open port map (a_in(i), b_in(i), x_out(i), y_out(i));
		end generate firo_open_generate;
		
		firo_closed_generate : if (poly(i) = '1') generate
			firo: firo_closed port map (a_in(i), b_in(i), x_out(i), y_out(i));
		end generate firo_closed_generate;
	end generate firo_generate_loop;

	rnd_port <= not y_out(poly'length - 1);
	a_in(poly'length - 1) <= rnd_port;

end GEN;
