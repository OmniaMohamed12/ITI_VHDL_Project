library IEEE;
LIBRARY std;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_signed.all;


ENTITY MUX_3x1 IS
		Generic(N  : INTEGER);
		PORT(A   : IN signed (2*N DOWNTO 0);
	     B   : IN signed (2*N DOWNTO 0);
		 D   : IN signed (2*N DOWNTO 0);
	     sel : IN std_logic_vector (1 DOWNTO 0);
		 C   : OUT signed (2*N DOWNTO 0));
END ENTITY MUX_3x1;



ARCHITECTURE MUX_3x1 OF MUX_3x1 IS
BEGIN

P1:PROCESS (A,B,D,sel) IS BEGIN
	CASE sel IS
		WHEN "10"    =>    C <= A;
		
		WHEN "01"    =>    C <= B;
		
		WHEN "11"    =>    C <= D;
		
		WHEN "00"    =>    C <= D;
		
		WHEN OTHERS  =>    
			FOR i in 0 to 2*N loop
				C(i) <= '0';
				END LOOP;
	END CASE;
END PROCESS;
END ARCHITECTURE MUX_3x1;