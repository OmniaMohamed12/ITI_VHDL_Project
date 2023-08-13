library IEEE;
LIBRARY std;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_signed.all;






ENTITY SHR IS
		Generic(N  : INTEGER);
		PORT(Frame           : IN signed(2*N DOWNTO 0);
		 Frame_OUT       : OUT signed(2*N DOWNTO 0));
END ENTITY SHR;






ARCHITECTURE SHR OF SHR IS BEGIN
P1:PROCESS (Frame) IS 
	   VARIABLE temp1: signed(2*N DOWNTO 0);
	BEGIN
		
		temp1 := (Frame(2*N) & Frame((2*N) DOWNTO 1));
	    Frame_OUT <= temp1;
	END PROCESS;

END ARCHITECTURE SHR;