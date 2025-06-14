LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- Interface
ENTITY EchoLite_tb IS
	-- This is a testing interface, we don't have any real input/output
END;

-- Implementation
ARCHITECTURE EchoLiteArch_tb OF EchoLite_tb IS
	-- Define the testing entity as component (uut, Unit Under Test)
	COMPONENT EchoLite IS
		PORT (
			enabled  : IN STD_LOGIC;
			clock    : IN STD_LOGIC;
			echo		: IN STD_LOGIC;
			trigger  : OUT STD_LOGIC;
			segments_array : OUT STD_LOGIC_VECTOR(2 * 8 - 1 DOWNTO 0);
			
			enabled_led : OUT STD_LOGIC
		);
	END COMPONENT;

	-- Define the testing signals
	SIGNAL enabled : STD_LOGIC;
	SIGNAL clock : STD_LOGIC;
	SIGNAL echo : STD_LOGIC;
	SIGNAL trigger  : STD_LOGIC;
	SIGNAL segments_array : STD_LOGIC_VECTOR(2 * 8 - 1 DOWNTO 0);
	SIGNAL enabled_led : STD_LOGIC;

BEGIN
   -- Mock Clock 10ns
	clock_process: PROCESS BEGIN
   	clock <= '1';
		WAIT FOR 10 ns;
		clock <= '0';
		WAIT FOR 10 ns;
	END PROCESS;
	
	-- Init the uut (connect testing signals with the component's ports)
	uut : EchoLite PORT MAP(
	   enabled => enabled,
		clock => clock, 
		echo => echo,
		trigger => trigger,
		segments_array => segments_array,
		enabled_led => enabled_led
	);
	
	-- Simulation Duration = 20 + 100 + 3000 = 3120
	simulation: PROCESS BEGIN
		echo <= '0';
		enabled <= '1';
		WAIT UNTIL trigger = '0';
		WAIT UNTIL trigger = '1';
		WAIT UNTIL trigger = '0';
		echo <= '1';
		WAIT FOR 3000 ns;
		echo <= '0';
		WAIT;
	END PROCESS;
END;