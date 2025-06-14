LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Interface
ENTITY SevenSegmentDisplay IS
	PORT (
		digit : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		segments : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
END;

-- Implementation
ARCHITECTURE SevenSegmentDisplayArch OF SevenSegmentDisplay IS
BEGIN
	PROCESS(digit)
	BEGIN
		CASE digit IS
			WHEN "0000" => segments <= "11000000"; -- 0
			WHEN "0001" => segments <= "11111001"; -- 1
			WHEN "0010" => segments <= "10100100"; -- 2
			WHEN "0011" => segments <= "10110000"; -- 3
			WHEN "0100" => segments <= "10011001"; -- 4
			WHEN "0101" => segments <= "10010010"; -- 5
			WHEN "0110" => segments <= "10000010"; -- 6
			WHEN "0111" => segments <= "11111000"; -- 7
			WHEN "1000" => segments <= "10000000"; -- 8
			WHEN "1001" => segments <= "10010000"; -- 9
			WHEN OTHERS => segments <= "11111111"; -- blank
		END CASE;
	END PROCESS;
END;