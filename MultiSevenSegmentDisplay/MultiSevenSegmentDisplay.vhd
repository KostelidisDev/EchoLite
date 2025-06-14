LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- Interface
ENTITY MultiSevenSegmentDisplay IS
    GENERIC (
        INPUT_WIDTH : INTEGER := 6;
        NUM_DIGITS : INTEGER := 2
    );
    PORT (
        digits : IN STD_LOGIC_VECTOR(INPUT_WIDTH - 1 DOWNTO 0);
        segments_array : OUT STD_LOGIC_VECTOR(NUM_DIGITS * 8 - 1 DOWNTO 0)
    );
END ENTITY;

-- Implementation
ARCHITECTURE MultiSevenSegmentDisplayArch OF MultiSevenSegmentDisplay IS

    COMPONENT SevenSegmentDisplay
        PORT (
            digit : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            segments : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
        );
    END COMPONENT;
	 
	 TYPE LOGIC_VECTOR_ARRAY IS ARRAY (0 TO NUM_DIGITS - 1) OF STD_LOGIC_VECTOR(3 DOWNTO 0);
	 
    SIGNAL binary_value_sig : UNSIGNED(INPUT_WIDTH - 1 DOWNTO 0);
    SIGNAL binary_digits_sig : LOGIC_VECTOR_ARRAY;
    SIGNAL segments_sig : STD_LOGIC_VECTOR(NUM_DIGITS * 8 - 1 DOWNTO 0);

BEGIN

    binary_value_sig <= UNSIGNED(digits);

    -- Split digits
    PROCESS(binary_value_sig)
        VARIABLE value : INTEGER;
    BEGIN
        value := TO_INTEGER(binary_value_sig);
        FOR i IN 0 TO NUM_DIGITS - 1 LOOP
            binary_digits_sig(i) <= STD_LOGIC_VECTOR(TO_UNSIGNED(value MOD 10, 4));
            value := value / 10;
        END LOOP;
    END PROCESS;

    -- Generate segment displays
    gen_segments : FOR i IN 0 TO NUM_DIGITS - 1
		 GENERATE SIGNAL seg : STD_LOGIC_VECTOR(7 DOWNTO 0);
		 BEGIN
			  seg_inst : SevenSegmentDisplay
					PORT MAP (
						 digit => binary_digits_sig(i),
						 segments => seg
					);
			  segments_sig((i + 1) * 8 - 1 DOWNTO i * 8) <= seg;
		 END GENERATE;

    segments_array <= segments_sig;

END ARCHITECTURE;