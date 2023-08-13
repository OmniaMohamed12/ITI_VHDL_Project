library IEEE;
LIBRARY std;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_signed.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.math_real.all;
-- USE ieee.std_logic_arith.ALL;
use work.log2_ceil_func.all ;
-- use ieee.numeric_bit.all;


ENTITY MUL_DIV_SEQ is
	generic (N: integer :=4) ;
	port (	a: in signed (N-1 downto 0);
				b: in signed (N-1 downto 0);
				clk, RST, mode: in std_logic ;				
				m: out signed (N-1 downto 0) ;
				start: in std_logic ;
				r: out signed (N-1 downto 0);
				error, busy, valid: out std_logic) ;	
END ENTITY MUL_DIV_SEQ ;



ARCHITECTURE MUL_DIV_SEQ OF MUL_DIV_SEQ IS
	
	COMPONENT MUL IS
		GENERIC( N: integer);
		PORT( A: IN signed(N-1 DOWNTO 0);
		  B: IN signed(N-1 DOWNTO 0);
		  mode,CLK,RST: IN std_logic;
		  m : OUT signed(N-1 DOWNTO 0);
		  r : OUT signed(N-1 DOWNTO 0);
		  VALID:  OUT std_logic;
		  BUSY:   OUT  std_logic);
	END COMPONENT MUL;
	
	COMPONENT divider is
		generic (N: integer) ;
		port (	a: in signed (N-1 downto 0);
				b: in signed (N-1 downto 0);
				clk, RST, start: in std_logic ;				
				m: out signed (N-1 downto 0) ;
				r: out std_logic_vector (N-1 downto 0);
				error, busy, valid: out std_logic) ;	
	END COMPONENT divider ;
	
	COMPONENT MUX_2x1 IS
		Generic(N  : INTEGER);
		PORT(A   : IN signed(2*N DOWNTO 0);
	     B   : IN signed(2*N DOWNTO 0);
	     sel : IN std_logic;
		 C   : OUT signed(2*N DOWNTO 0));
	END COMPONENT MUX_2x1;
	
	COMPONENT LOGIC_OR IS 
	PORT( A : IN std_logic;
	      B : IN std_logic;
		  C : OUT std_logic);
	END COMPONENT LOGIC_OR;
	
	COMPONENT MUX_2x1_R IS
		Generic(N  : INTEGER);
		PORT(A   : IN signed(N-1 DOWNTO 0);
	     B   : IN signed(N-1 DOWNTO 0);
	     sel : IN std_logic;
		 C   : OUT signed(N-1 DOWNTO 0));
  END COMPONENT MUX_2x1_R;
  
	COMPONENT LOGIC_AND IS  
		PORT( A : IN std_logic;
	      B : IN std_logic;
		  C : OUT std_logic);

	END COMPONENT LOGIC_AND;
	
	
	SIGNAL m_d :   signed (N-1 downto 0) ;
	SIGNAL m_m :   signed (N-1 downto 0) ;
	
	SIGNAL r_d :   signed (N-1 downto 0) ;
	SIGNAL r_m :   signed (N-1 downto 0) ;
	
	SIGNAL r_d_s : std_logic_vector (N-1 downto 0);
	
	SIGNAL VALID_D : std_logic;
	SIGNAL VALID_M : std_logic;
	
	SIGNAL BUSY_D : std_logic;
	SIGNAL BUSY_M : std_logic;
	
	SIGNAL START_S : std_logic;
	
	
	BEGIN

	divider_u: divider
		GENERIC MAP(N)
		PORT MAP(a,b,CLK,RST,START_S,m_d,r_d_s,error,BUSY_D,VALID_D);
		
		r_d <= signed(r_d_s);
		
	MUL_u: MUL
		GENERIC MAP(N)
		PORT MAP(a,b,mode,CLK,RST,m_m,r_m,VALID_M,BUSY_M);	

	MUX_2x1_R_u5 : MUX_2x1_R
		GENERIC MAP(N)
		PORT MAP (m_d,m_m,mode,m);

	MUX_2x1_R_u6: MUX_2x1_R
		GENERIC MAP(N)
		PORT MAP (r_d,r_m,mode,r);
		
	LOGIC_OR_V: LOGIC_OR
		PORT MAP(VALID_D,VALID_M,valid);
		
	LOGIC_OR_B: LOGIC_OR
		PORT MAP(BUSY_M,BUSY_D,busy);	
	
	LOGIC_AND_U : LOGIC_AND
		PORT MAP(start,mode,START_S); 
		
		
END ARCHITECTURE MUL_DIV_SEQ;