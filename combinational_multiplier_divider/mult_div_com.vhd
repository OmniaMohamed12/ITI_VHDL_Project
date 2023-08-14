library IEEE;
LIBRARY std;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_signed.all;

entity mult_div_com is
	generic (N: integer :=4) ;
	port (	ai: in signed (N-1 downto 0);
				bi: in signed (N-1 downto 0);
			   modei: in bit ;				
				mi: out signed (N-1 downto 0) ;
				ri: out signed (N-1 downto 0);
                    errori, busyi, validi: out bit) ;	
END ENTITY mult_div_com;

ARCHITECTURE MUL_DIV_COMB  OF mult_div_com IS
	
	COMPONENT DIVIDER IS
		GENERIC( N: integer:=4);
		
		PORT(
		  MODE: IN bit;
		  A: IN signed(N-1 DOWNTO 0);
		  B: IN signed(N-1 DOWNTO 0);
		  M: OUT signed(N-1 DOWNTO 0);
		  R: OUT signed(N-1 DOWNTO 0);
		  ERROR : OUT bit ;
		  VALID:  OUT bit;
		  BUSY  : OUT bit
		  );
	END COMPONENT DIVIDER;
	
	COMPONENT multiplier_comb is
		generic (N: integer:=4) ;
	  PORT(
	     MODE: IN bit;
	     a : IN signed(N - 1 DOWNTO 0);
	     b : IN signed(N - 1 DOWNTO 0);
	     m : OUT signed(N- 1 DOWNTO 0);
		  r : OUT signed(N- 1 DOWNTO 0);
		  busy,valid,error:out bit );	
	END COMPONENT multiplier_comb ;
	

	signal m_D :   signed (N-1 downto 0) ;
	signal m_M :   signed (N-1 downto 0) ;
	
	signal r_D :   signed (N-1 downto 0) ;
	signal r_M :   signed (N-1 downto 0) ;
	
	signal VALID_M : bit;
	signal VALID_D: bit;
	
	signal BUSY_M : bit;
	signal BUSY_D :bit;
	
	signal ERROR_M :bit;
	signal ERROR_D : bit;
	
	
	BEGIN

divider_u: DIVIDER
		GENERIC MAP(N)
		PORT MAP
		     ( 
			    modei,
			    ai,
			   bi,
				 M => m_D,
				 R => r_D ,
				 ERROR => ERROR_D ,
				 VALID => VALID_D,
				 BUSY => BUSY_D
				 
			  );
		
	MUL_u: multiplier_comb
		GENERIC MAP(N)
		PORT MAP
		     ( 
			   modei,
			    ai,
			    bi,
				 m => m_M,
				 r => r_M ,
				 BUSY => BUSY_M,
				 valid => VALID_M,
				 error => ERROR_M
				 
			  );	
mi <= m_M when modei = '1' else m_D;
ri <= r_M when modei = '1' else r_D;
busyi <=BUSY_M  when modei = '1' else BUSY_D;
validi <=VALID_M when modei = '1' else VALID_D;
errori <= ERROR_M when modei = '1' else ERROR_D;

 END ARCHITECTURE MUL_DIV_COMB;


