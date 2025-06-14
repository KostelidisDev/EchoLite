LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- Interface
ENTITY HCSR04_tb IS
END;

-- Implementation
ARCHITECTURE HCSR04Arch_tb OF HCSR04_tb IS
	COMPONENT HCSR04 IS
		PORT (
			clock    : IN STD_LOGIC;
			echo		: IN STD_LOGIC;
			trigger  : OUT STD_LOGIC;
		   distance : OUT INTEGER
		);
	END COMPONENT;

	SIGNAL clock_sig : STD_LOGIC;
	SIGNAL echo_sig : STD_LOGIC;
	SIGNAL trigger_sig  : STD_LOGIC;
	SIGNAL distance_sig : INTEGER;

BEGIN
	clk: PROCESS
	BEGIN
   	clock_sig <= '1';
		WAIT FOR 5 ns;
		clock_sig <= '0';
		WAIT FOR 5 ns;
	END PROCESS;
	
	hc_sr04 : HCSR04 PORT MAP
	(
		clock => clock_sig, 
		echo => echo_sig,
		trigger => trigger_sig,
		distance => distance_sig
	);
	
	PROCESS BEGIN
		echo_sig <= '0';
		WAIT UNTIL trigger_sig = '0';
		echo_sig <= '1';
		WAIT FOR 2000 ns;
		echo_sig <= '0';
		WAIT;
	END PROCESS;
END;