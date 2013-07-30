library ieee;
use ieee.std_logic_1164.all;

entity fibonacci_ring_oscillator is
	port (
		clk_port : in std_logic;
		rnd_port : inout std_logic
	);
end fibonacci_ring_oscillator;

architecture behavior of fibonacci_ring_oscillator is
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

	attribute syn_keep : boolean;
	attribute syn_keep of x_out : signal is true;
	attribute syn_keep of y_out : signal is true;
	attribute syn_keep of a_in : signal is true;
	attribute syn_keep of b_in : signal is true;

begin

	-- from Dichtl & Golic 2008: x^15 + x^14 + x^7 + x^6 + x^5 + x^4 + x^2 + 1
	-- 1100000011110101

	b_in(0) <= x_out(0) nand (clk_port or (not clk_port));

	process (x_out)
		variable p : std_logic_vector(15 downto 0);
	begin
		p := "1100000011110101";

		for i in 0 to (p'length - 1) loop
			if (p(i) = '1') then
				x_out(i) <= a_in(i) xor (not b_in(i));
			else
				x_out(i) <= a_in(i);
			end if;

			y_out(i) <= not b_in(i);

			if (i < (p'length - 1)) then
				a_in(i) <= x_out(i+1);
				b_in(i+1) <= y_out(i);
			else
				rnd_port <= not y_out(i);
				a_in(i) <= rnd_port;				
			end if;
		end loop;

	end process;

	--b_in(0) <= x_out(0);

	---- firo0 : firo_closed port map(a_in(0), b_in(0), x_out(0), y_out(0));
	--x_out(0) <= a_in(0) xor (not b_in(0));
	--y_out(0) <= not b_in(0);
	
	--a_in(0) <= x_out(1);
	--b_in(1) <= y_out(0);
	
	---- firo1 : firo_open port map(a_in(1), b_in(1), x_out(1), y_out(1));
	--x_out(1) <= a_in(1); -- xor (not b_in(1));
	--y_out(1) <= not b_in(1);
	
	--a_in(1) <= x_out(2);
	--b_in(2) <= y_out(1);
	
	---- firo2 : firo_closed port map(a_in(2), b_in(2), x_out(2), y_out(2));
	--x_out(2) <= a_in(2) xor (not b_in(2));
	--y_out(2) <= not b_in(2);
	
	--a_in(2) <= x_out(3);
	--b_in(3) <= y_out(2);
	
	----firo3 : firo_open port map(a_in(3), b_in(3), x_out(3), y_out(3));
	--x_out(3) <= a_in(3);
	--y_out(3) <= not b_in(3);
	
	--rnd_port <= not y_out(3);
	--a_in(3) <= rnd_port;

	--xor_in(3) <= xor_out(4);
	--not_in(4) <= not_out(3);
	--firo4 : firo_closed port map(xor_in(4), not_in(4), xor_out(4), not_out(4));
	--xor_in(4) <= xor_out(5);
	--not_in(5) <= not_out(4);
	--firo5 : firo_closed port map(xor_in(5), not_in(5), xor_out(5), not_out(5));
	--xor_in(5) <= xor_out(6);
	--not_in(6) <= not_out(5);
	--firo6 : firo_closed port map(xor_in(6), not_in(6), xor_out(6), not_out(6));
	--xor_in(6) <= xor_out(7);
	--not_in(7) <= not_out(6);
	--firo7 : firo_closed port map(xor_in(7), not_in(7), xor_out(7), not_out(7));
	--xor_in(7) <= xor_out(8);
	--not_in(8) <= not_out(7);
	--firo8 : firo_open port map(xor_in(8), not_in(8), xor_out(8), not_out(8));
	--xor_in(8) <= xor_out(9);
	--not_in(9) <= not_out(8);
	--firo9 : firo_open port map(xor_in(9), not_in(9), xor_out(9), not_out(9));
	--xor_in(9) <= xor_out(10);
	--not_in(10) <= not_out(9);
	--firo10 : firo_open port map(xor_in(10), not_in(10), xor_out(10), not_out(10));
	--xor_in(10) <= xor_out(11);
	--not_in(11) <= not_out(10);
	--firo11 : firo_open port map(xor_in(11), not_in(11), xor_out(11), not_out(11));
	--xor_in(11) <= xor_out(12);
	--not_in(12) <= not_out(11);
	--firo12 : firo_open port map(xor_in(12), not_in(12), xor_out(12), not_out(12));
	--xor_in(12) <= xor_out(13);
	--not_in(13) <= not_out(12);
	--firo13 : firo_open port map(xor_in(13), not_in(13), xor_out(13), not_out(13));
	--xor_in(13) <= xor_out(14);
	--not_in(14) <= not_out(13);
	--firo14 : firo_closed port map(xor_in(14), not_in(14), xor_out(14), not_out(14));
	--xor_in(14) <= xor_out(15);
	--not_in(15) <= not_out(14);
	--firo15 : firo_closed port map(xor_in(15), not_in(15), xor_out(15), not_out(15));
	
	--xor_out_zero_in <= xor_out(0) nand low_enable;

	--firo0 : firo_closed port map (xor_out(1), xor_out(0), not_out(0), xor_out_zero_in);
	--firo1 : firo_open port map (xor_out(2), not_out(0), not_out(1), xor_out(1));
	--firo2 : firo_closed port map (xor_out(3), not_out(1), not_out(2), xor_out(2));
	--firo3 : firo_open port map (xor_out(4), not_out(2), not_out(3), xor_out(3));
	--firo4 : firo_closed port map (xor_out(5), not_out(3), not_out(4), xor_out(4));
	--firo5 : firo_closed port map (xor_out(6), not_out(4), not_out(5), xor_out(5));
	--firo6 : firo_closed port map (xor_out(7), not_out(5), not_out(6), xor_out(6));
	--firo7 : firo_closed port map (xor_out(8), not_out(6), not_out(7), xor_out(7));
	--firo8 : firo_open port map (xor_out(9), not_out(7), not_out(8), xor_out(8));
	--firo9 : firo_open port map (xor_out(10), not_out(8), not_out(9), xor_out(9));
	--firo10 : firo_open port map (xor_out(11), not_out(9), not_out(10), xor_out(10));
	--firo11 : firo_open port map (xor_out(12), not_out(10), not_out(11), xor_out(11));
	--firo12 : firo_open port map (xor_out(13), not_out(11), not_out(12), xor_out(12));
	--firo13 : firo_open port map (xor_out(14), not_out(12), not_out(13), xor_out(13));
	--firo14 : firo_closed port map (xor_out(15), not_out(13), not_out(14), xor_out(14));
	--firo15 : firo_closed port map (rnd, not_out(14), not_rnd, xor_out(15));
end behavior;