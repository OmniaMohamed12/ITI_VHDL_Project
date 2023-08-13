

LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY COMB_DIVIDER_TB IS
END ENTITY COMB_DIVIDER_TB;

ARCHITECTURE COMB_DIVIDER OF COMB_DIVIDER_TB IS
   COMPONENT DIVIDER  IS
        PORT(
	  A: IN SIGNED (3 DOWNTO 0);
	  B: IN SIGNED   (3 DOWNTO 0);
	  M: OUT SIGNED (3 DOWNTO 0);
          R: OUT SIGNED   (3 DOWNTO 0);
          ERROR : OUT STD_LOGIC;
          BUSY  : OUT STD_LOGIC;
          VALID : OUT STD_LOGIC
        );
   END COMPONENT DIVIDER;

   SIGNAL A_TB:  SIGNED (3 DOWNTO 0);
   SIGNAL B_TB:  SIGNED (3 DOWNTO 0);
   SIGNAL M_TB: SIGNED (3 DOWNTO 0);
   SIGNAL R_TB:  SIGNED   (3 DOWNTO 0);   SIGNAL ERROR_TB: STD_LOGIC;
   SIGNAL BUSY_TB: STD_LOGIC;
   SIGNAL VALID_TB: STD_LOGIC;

   BEGIN 
     DUT: DIVIDER PORT MAP 
         (A =>A_TB, B=> B_TB, M => M_TB, R => R_TB,ERROR => ERROR_TB,BUSY => BUSY_TB,VALID => VALID_TB  );
     DV: PROCESS IS BEGIN
         -- A and B  are POSITIVE
          A_TB <= "0110";
          B_TB <= "0010";
          WAIT FOR 20 ns;
         --  A IS NEGATIVE AND B IS POSITIV
          A_TB <= "1000";
          B_TB <= "0010";
          WAIT FOR 20 ns;

          --  A LESS THAN B
          A_TB <= "0010";
          B_TB <= "1010";
          WAIT FOR 20 ns;

          -- B EQUAL ZERO
          A_TB <= "0010";
          B_TB <= "0000";
          WAIT FOR 20 ns;
      
      
 END PROCESS DV;
END ARCHITECTURE COMB_DIVIDER; 