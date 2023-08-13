library IEEE;
LIBRARY std;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_signed.all;


ENTITY LOGIC_AND IS  
	PORT( A : IN std_logic;
	      B : IN std_logic;
		  C : OUT std_logic);

END ENTITY LOGIC_AND;


ARCHITECTURE LOGIC_AND OF LOGIC_AND IS BEGIN

	C <= A AND B;

END ARCHITECTURE LOGIC_AND;