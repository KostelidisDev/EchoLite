LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- Interface
ENTITY MultiSevenSegmentDisplay_tb IS
END ENTITY;

-- Implementation
ARCHITECTURE MultiSevenSegmentDisplayArch_tb OF MultiSevenSegmentDisplay_tb IS

	 CONSTANT INPUT_WIDTH_CONSTANT : INTEGER := 6;
    CONSTANT NUM_DIGITS_CONSTANT : INTEGER := 2;

    COMPONENT MultiSevenSegmentDisplay
        GENERIC (
            INPUT_WIDTH : INTEGER := INPUT_WIDTH_CONSTANT;
            NUM_DIGITS : INTEGER := NUM_DIGITS_CONSTANT
        );
        PORT (
            digits : IN STD_LOGIC_VECTOR(INPUT_WIDTH_CONSTANT - 1 DOWNTO 0);
            segments_array : OUT STD_LOGIC_VECTOR(NUM_DIGITS_CONSTANT * 8 - 1 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL digits_sig : STD_LOGIC_VECTOR(INPUT_WIDTH_CONSTANT - 1 DOWNTO 0);
    SIGNAL segments_array_sig : STD_LOGIC_VECTOR(NUM_DIGITS_CONSTANT * 8 - 1 DOWNTO 0);

BEGIN
    mssd: MultiSevenSegmentDisplay
        GENERIC MAP (
            INPUT_WIDTH => INPUT_WIDTH_CONSTANT,
            NUM_DIGITS => NUM_DIGITS_CONSTANT
        )
        PORT MAP (
            digits => digits_sig,
            segments_array => segments_array_sig
        );
		  
    PROCESS
	 BEGIN
		FOR i IN 0 TO 63 LOOP
			digits_sig <= STD_LOGIC_VECTOR(TO_UNSIGNED(i, INPUT_WIDTH_CONSTANT));
			WAIT FOR 10 ns;
		END LOOP;
		WAIT;
	 END PROCESS;
END;