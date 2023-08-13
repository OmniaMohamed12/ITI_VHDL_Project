library IEEE;
LIBRARY std;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_signed.all;


ENTITY counter is
	GENERIC( N: integer);
	PORT( CLK  :     IN  std_logic;
		  RST  :     IN  std_logic;
		  mode :      IN  std_logic;
		  DN   :      OUT std_logic;
		  CN_1 :    OUT std_logic);
END ENTITY counter;

ARCHITECTURE counter OF counter IS
BEGIN  
	P1:PROCESS (CLK,RST) IS 
	   VARIABLE C: std_logic_vector(N-1 DOWNTO 0);
	   VARIABLE DN_11 : std_logic;
	BEGIN
		IF   RST='0'       THEN 
		   FOR k in 0 to N-1 LOOP
			   C(k) := '0';
		   END LOOP;
		ELSIF (rising_edge(CLK)) THEN
			 IF(DN_11 = '1') THEN
				FOR k in 0 to (N-1) LOOP
				    C(k) := '0';
				END LOOP;
			ELSIF mode = '0' THEN
				C := C + 1;
			END IF;
		END IF;
		
		
		-- check if counter in 0
		IF C = 0  THEN
			CN_1 <= '1';
		ELSE
			CN_1 <= '0';
		END IF;
		
		
		-- check if counter reach N-1
		IF C = N+1  THEN
			DN_11 := '1';
		ELSE
			DN_11 := '0';
		END IF;
  
   DN <= DN_11;
  
	END PROCESS P1;
	
END ARCHITECTURE counter;




