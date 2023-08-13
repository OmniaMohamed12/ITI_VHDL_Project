LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.numeric_std.all;
USE ieee.std_logic_signed.ALL;

ENTITY multiplier_divider_comb IS

	GENERIC (N : INTEGER := 4);
	PORT(a : IN signed(N - 1 DOWNTO 0);
	     b : IN signed(N - 1 DOWNTO 0);
		   control : IN bit;
	     m : OUT signed(N- 1 DOWNTO 0);
		   r : OUT signed(N- 1 DOWNTO 0);
		   busy,valid,error:out bit );
END multiplier_divider_comb;

ARCHITECTURE comb_multiplier OF multiplier_divider_comb IS

BEGIN
	
	PROCESS(a, b) IS 
		VARIABLE a_var:signed(2*N  DOWNTO 0):= (OTHERS => '0');
		-- sub_a represents the two's complement of the multiplicand.
		VARIABLE sub_a: signed(2*N  DOWNTO 0):= (OTHERS => '0');
		VARIABLE res : signed(2*N  DOWNTO 0):= (OTHERS => '0');
	
	begin
		if control='1' then
		   --Initialize all variables to zero.
		    a_var:=(OTHERS => '0');
		    sub_a:=(OTHERS => '0');
		    res:=(OTHERS => '0');
			--a_var holds the value of the multiplicand (a) in the upper N bits.
			a_var(2*N DOWNTO N+1 ) := a;  
             --sub_a holds the value of the two's complement of the multiplicand (a) in the upper N bits.			
			sub_a(2*N DOWNTO N+1 ) := ((NOT a) + 1);
			--res holds the value of the multiplier in the lower N bits. 
			res(N DOWNTO 1) := b;
			busy <= '1';
			for i in 1 to N loop	
				IF (res(1 DOWNTO 0) = "01") THEN
					res := res + a_var;
					res(2*N-1 DOWNTO 0) := res(2*N DOWNTO 1);
				ELSIF (res(1 DOWNTO 0) = "10") THEN
					res := res + sub_a;
					res(2*N-1 DOWNTO 0) := res(2*N DOWNTO 1);
				ELSE 
				res:=res;
				res(2*N-1 DOWNTO 0) := res(2*N DOWNTO 1);
				END IF;
			END LOOP;	
		--m is the most significant N-bits of the result of multiplication.
		m <= res(2*N DOWNTO N+1);
		--r is the least significant N-bits of the result of multiplication.
		r <= res(N DOWNTO 1);
		busy <= '0';
               valid <= '1';
               error <= '0';
		
		end if;
	END PROCESS;
	
END comb_multiplier;
