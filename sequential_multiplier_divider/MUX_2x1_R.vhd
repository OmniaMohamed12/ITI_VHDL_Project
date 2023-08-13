library IEEE;
LIBRARY std;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_signed.all;




ENTITY MUX_2x1_R IS
		Generic(N  : INTEGER := 4);
		PORT(A   : IN signed(N-1 DOWNTO 0);
	     B   : IN signed(N-1 DOWNTO 0);
	     sel : IN std_logic;
		 C   : OUT signed(N-1 DOWNTO 0));
END ENTITY MUX_2x1_R;


ARCHITECTURE MUX_2x1_R OF MUX_2x1_R IS
BEGIN

P1:PROCESS (A,B,sel) IS BEGIN
	CASE sel IS
		WHEN '1'    =>    C <= A;
		
		WHEN '0'    =>    C <= B;
		
		WHEN OTHERS  =>    
			FOR i in 0 to N-1 loop
				C(i) <= '0';
				END LOOP;
	END CASE;
END PROCESS;
END ARCHITECTURE MUX_2x1_R;

