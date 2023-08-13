library IEEE;
LIBRARY std;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_signed.all;






ENTITY SUB_SHR IS
		Generic(N  : INTEGER);
		PORT(Frame           : IN signed(2*N DOWNTO 0);
	     M               : IN signed(N-1 DOWNTO 0);
		 Frame_OUT       : OUT signed(2*N DOWNTO 0));
END ENTITY SUB_SHR;






ARCHITECTURE SUB_SHR OF SUB_SHR IS BEGIN
P1:PROCESS (Frame,M) IS 
	   VARIABLE temp1: signed(2*N DOWNTO 0);
	   VARIABLE temp2: signed((2*N) DOWNTO 0);
	BEGIN
		
		temp1 := (Frame(2*N DOWNTO (2*N)-(N-1)) - M) & Frame((2*N)-N DOWNTO 0) ;
		temp2 := (temp1(2*N) & temp1((2*N) DOWNTO 1));
		
	    Frame_OUT <= temp2;
	END PROCESS;

END ARCHITECTURE SUB_SHR;