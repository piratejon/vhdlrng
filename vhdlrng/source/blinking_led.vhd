--------------------------------------------------------------------------------
--
--   FileName:         blinking_led.vhd
--   Dependencies:     none
--   Design Software:  Lattice Diamond Version 1.4.87
--
--   HDL CODE IS PROVIDED "AS IS."  DIGI-KEY EXPRESSLY DISCLAIMS ANY
--   WARRANTY OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING BUT NOT
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
--   PARTICULAR PURPOSE, OR NON-INFRINGEMENT. IN NO EVENT SHALL DIGI-KEY
--   BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR CONSEQUENTIAL
--   DAMAGES, LOST PROFITS OR LOST DATA, HARM TO YOUR EQUIPMENT, COST OF
--   PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS
--   BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF),
--   ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER SIMILAR COSTS.
--
--   Version History
--   Version 1.0 4/11/2012 Scott Larson
--     Initial Public Release
--
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;

library machxo2;
use machxo2.all;

ENTITY blinking_led IS
   PORT(
      hi, lo, led  : BUFFER  STD_LOGIC);
END blinking_led;

ARCHITECTURE behavior OF blinking_led IS
   SIGNAL  clk, rnd : STD_LOGIC;
   --internal oscillator
   COMPONENT OSCH
      GENERIC(
            NOM_FREQ: string := "53.20");
      PORT( 
            STDBY    : IN  STD_LOGIC;
            OSC      : OUT STD_LOGIC;
            SEDSTDBY : OUT STD_LOGIC);
   END COMPONENT;
   
   component fibonacci_ring_oscillator
		generic (
			poly : std_logic_vector := "110000001111010"
		);
		port (
			rnd_port : inout std_logic
		);
   end component;

BEGIN
   --internal oscillator
   OSCInst0: OSCH
      GENERIC MAP (NOM_FREQ  => "53.20")
      PORT MAP (STDBY => '0', OSC => clk, SEDSTDBY => OPEN);
	firo0: fibonacci_ring_oscillator
		generic map ( poly => "110000001111010" )
		port map ( rnd_port => rnd );
   PROCESS(clk)
      VARIABLE count :   INTEGER RANGE 0 TO 12_500_000;
   BEGIN
      IF(clk'EVENT AND clk = '1') THEN
         IF(count < 12_500_000) THEN
            count := count + 1;
         ELSE
            count := 0;
			hi <= rnd;
			lo <= not rnd;
			led <= not led;
         END IF;
      END IF;
   END PROCESS;
END behavior;