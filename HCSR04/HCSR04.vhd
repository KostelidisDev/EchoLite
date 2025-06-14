LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Interface
ENTITY HCSR04 IS
	PORT (
		clock    : IN STD_LOGIC;
		echo		: IN STD_LOGIC;
		trigger  : OUT STD_LOGIC;
		distance : OUT INTEGER
	);
END ENTITY;

-- Implementation
ARCHITECTURE HCSR04Arch OF HCSR04 IS
	SIGNAL trigger_sig : STD_LOGIC := '0';
	SIGNAL distance_sig : INTEGER := 0;
	SIGNAL echo_time : INTEGER := 0;
BEGIN
	PROCESS(clock)
		VARIABLE trigger_count, echo_count : INTEGER := 0;
		VARIABLE can_calculate : STD_LOGIC := '1';
	BEGIN
		IF RISING_EDGE(clock) THEN
			IF trigger_count = 0 THEN
				trigger_sig <= '1';
			ELSIF trigger_count = 10 THEN
				trigger_sig <= '0';
				can_calculate := '1';
			ELSIF trigger_count = 200000 THEN
				trigger_count := 0;
				trigger_sig <= '1';
			END IF;
			trigger_count := trigger_count + 1;

			IF echo = '1' THEN
				IF echo_count < 3706 THEN
					echo_count := echo_count + 1;
				END IF;
			ELSIF echo = '0' AND can_calculate = '1' THEN
				echo_time <= echo_count;
				echo_count := 0;
				can_calculate := '0';
			END IF;

			distance_sig <= (echo_time * 17) / 1000;
		END IF; 
	END PROCESS;

	trigger <= trigger_sig;
	distance <= distance_sig;
END ARCHITECTURE;