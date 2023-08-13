library IEEE;
LIBRARY std;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_signed.all;



ENTITY DFF IS
		Generic(N : INTEGER);
		PORT(D  : IN signed(2*N DOWNTO 0);
	     CLK: IN std_logic;
	     RST: IN std_logic;
	   	 q  : OUT signed(2*N DOWNTO 0));
END ENTITY DFF;




ARCHITECTURE DFF OF DFF IS
BEGIN  
	P1:PROCESS (CLK,RST) IS 
	   VARIABLE temp: signed((2*N) DOWNTO 0);
	BEGIN
		IF   RST = '0'       THEN 
		   FOR k in 0 to 2*N LOOP
			   temp(k) := '0';
		   END LOOP;
		ELSIF (rising_edge(CLK)) THEN
			temp:= D;
		END IF;
		
		q <= temp;
	END PROCESS;
		
		
END ARCHITECTURE;