library IEEE;
LIBRARY std;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_signed.all;


ENTITY LOGIC_OR IS  
	PORT( A : IN std_logic;
	      B : IN std_logic;
		  C : OUT std_logic);

END ENTITY LOGIC_OR;


ARCHITECTURE LOGIC_OR OF LOGIC_OR IS BEGIN

	C <= A OR B;

END ARCHITECTURE LOGIC_OR;