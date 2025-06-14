LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- Interface
ENTITY EchoLite IS
	PORT (
		clock    : IN STD_LOGIC;
		echo		: IN STD_LOGIC;
		trigger  : OUT STD_LOGIC;
		segments_array : OUT STD_LOGIC_VECTOR(2 * 8 - 1 DOWNTO 0);
		
		echo_led : OUT STD_LOGIC;
		trigger_led : OUT STD_LOGIC
	);
END ENTITY;

-- Implementation
ARCHITECTURE EchoLiteArch OF EchoLite IS

-- Custom Clock
COMPONENT MHzClock
	PORT
	(
		inclk0		: IN STD_LOGIC  := '0';
		c0				: OUT STD_LOGIC 
	);
END COMPONENT;

-- Multiple Seven-Sgement Display Support
COMPONENT MultiSevenSegmentDisplay
	PORT (
	  digits : IN STD_LOGIC_VECTOR(6 - 1 DOWNTO 0);
	  segments_array : OUT STD_LOGIC_VECTOR(2 * 8 - 1 DOWNTO 0)
	);
END COMPONENT;

-- HC SR-04 Support
COMPONENT HCSR04
	PORT (
		clock    : IN STD_LOGIC;
		echo		: IN STD_LOGIC;
		trigger  : OUT STD_LOGIC;
		distance : OUT INTEGER
	);
END COMPONENT;

SIGNAL clock_sig : STD_LOGIC;
SIGNAL digits_sig : STD_LOGIC_VECTOR(6 - 1 DOWNTO 0);
SIGNAL distance_sig : INTEGER;
SIGNAL trigger_sig : STD_LOGIC;

BEGIN

platform_inst :  MHzClock
	PORT MAP (
		inclk0		=> clock,
		c0				=> clock_sig
	);

multi_seg_inst : MultiSevenSegmentDisplay
	PORT MAP (
		digits			=> digits_sig,
		segments_array	=> segments_array
	);
	
hcsr04_inst : HCSR04
	PORT MAP (
		clock		=> clock_sig,
		echo		=> echo,
		trigger	=> trigger_sig,
		distance	=> distance_sig
	);

digits_sig <= STD_LOGIC_VECTOR(TO_UNSIGNED(distance_sig, 6));
echo_led <= echo;
trigger <= trigger_sig;
trigger_led <= trigger_sig;
	
END ARCHITECTURE;