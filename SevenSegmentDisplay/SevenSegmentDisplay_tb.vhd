LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- Interface
ENTITY SevenSegmentDisplay_tb IS
END SevenSegmentDisplay_tb;

-- Implementation
ARCHITECTURE SevenSegmentDisplayArch_tb OF SevenSegmentDisplay_tb IS
	COMPONENT SevenSegmentDisplay
		PORT (
			digit : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			segments : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL digit_sig : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL segments_sig : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN
	ssd : SevenSegmentDisplay PORT MAP
	(
		digit => digit_sig, 
		segments => segments_sig
	);

	PROCESS
	BEGIN
		FOR i IN 0 TO 15 LOOP
			digit_sig <= STD_LOGIC_VECTOR(TO_UNSIGNED(i, 4));
			WAIT FOR 10 ns;
		END LOOP;
		WAIT;
	END PROCESS;
END;