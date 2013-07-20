

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
LIBRARY lattice;
USE lattice.components.all;



entity Fibonacci_Ring_Oscillator is
port (
        DAT_O : out unsigned(3 downto 0);
        
        
        );
end Fibonacci_Ring_Oscillator;
architecture Behavioral of Fibonacci_Ring_Oscillator is
signal X,Y,Z,A,B : unsigned(3 downto 0):="0000";
--signal A : std_logic_vector(3 downto 0):="0101";
signal Z_last : std_logic:='0';
signal
begin
Z_last <= not A(0);
A <= B;
F : for i in 0 to 3 generate
    begin
        F0 : if ( i = 0 ) generate  --The IF condition to for the "first" FF only.
			begin U1 : entity work.example_FDRSE port map --usual port mapping         
			(B(0) <= not Z(0),
			IF (Y(0)) THEN 
				A(0) <= X(0) xor Z(0); 
			ELSE
				A(0) <= X(0);
			END IF;
			);
		  
          
             end generate F0;
        F1 : if ( i /= 0 ) generate --generating the rest of the three FF's.
            begin U2 : entity work.example_FDRSE port map   --usual port mapping
			(B <= not Z(i-1),
			IF (Y(i)) THEN
				A(i) <= X(i) xor Z(i); 
			ELSE
				A(i) <= X(0);
			END IF;
			);
             end generate F1;
    end generate F;     
    
end Behavioral;

entity Galois_Ring_Oscillator is
port (
        DAT_O : out unsigned(3 downto 0);
        
        
        );
end Galois_Ring_Oscillator;

architecture Behavioral of Galois_Ring_Oscillator is
signal X,Y,Z,A,B : unsigned(3 downto 0):="0000";
--signal A : std_logic_vector(3 downto 0):="0101";
signal Z_last : std_logic:='0';
signal
begin
Z_last <= not A(0);
A <= B;
F : for i in 0 to 3 generate
    begin
        F0 : if ( i = 0 ) generate  --The IF condition to for the "first" FF only.
			begin U1 : entity work.example_FDRSE port map --usual port mapping         
			(A(0) <= X(0),
			IF (Y(0)) THEN 
				A(0) <= X(0) xor Z(0); 
			ELSE
				B(0) <= not Z(0);
			END IF;
			);
		  
          
             end generate F0;
        F1 : if ( i /= 0 ) generate --generating the rest of the three FF's.
            begin U2 : entity work.example_FDRSE port map   --usual port mapping
			(A(i) <= X(i-1),
			IF (Y(i)) THEN
				B(i) <= not (X(i) xor Z(i)); 
			ELSE
				A(i) <= not Z(0);
			END IF;
			);
             end generate F1;
    end generate F;     
    
end Behavioral;


ENTITY blinking_led IS
   PORT(
      led  : BUFFER  STD_LOGIC);
END blinking_led;

ARCHITECTURE behavior OF blinking_led IS
   SIGNAL  clk  : STD_LOGIC;
   --internal oscillator
   COMPONENT OSCH
      GENERIC(
            NOM_FREQ: string := "53.20");
      PORT( 
            STDBY    : IN  STD_LOGIC;
            OSC      : OUT STD_LOGIC;
            SEDSTDBY : OUT STD_LOGIC);
   END COMPONENT;
BEGIN
   --internal oscillator
   OSCInst0: OSCH
      GENERIC MAP (NOM_FREQ  => "53.20")
      PORT MAP (STDBY => '0', OSC => clk, SEDSTDBY => OPEN);
   PROCESS(clk)
      VARIABLE count :   INTEGER RANGE 0 TO 25_000_000;
   BEGIN
      IF(clk'EVENT AND clk = '1') THEN
         IF(count < 25_000_000) THEN
            count := count + 1;
         ELSE
            count := 0;
            led <= NOT led;
         END IF;
      END IF;
   END PROCESS;
END behavior;