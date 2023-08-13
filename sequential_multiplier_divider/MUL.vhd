library IEEE;
LIBRARY std;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_signed.all;



ENTITY MUL IS
	GENERIC( N: integer);
	PORT( A: IN signed(N-1 DOWNTO 0);
		  B: IN signed(N-1 DOWNTO 0);
		  mode,CLK,RST: IN std_logic;
		  m : OUT signed(N-1 DOWNTO 0);
		  r : OUT signed(N-1 DOWNTO 0);
		  VALID:  OUT std_logic;
		  BUSY:   OUT  std_logic);
		  
END ENTITY MUL;


ARCHITECTURE MUL OF MUL IS
	
	COMPONENT counter is
		GENERIC( N: integer);
		PORT( CLK :     IN  std_logic;
		  RST :     IN  std_logic;
		  mode :      IN  std_logic;
		  DN :      OUT std_logic;
		  CN_1 :    OUT std_logic);
	END COMPONENT counter;
	FOR ALL: counter USE ENTITY WORK.counter (counter);
	
	
	COMPONENT MUX_3x1 IS
		Generic(N  : INTEGER);
		PORT(A   : IN signed(2*N DOWNTO 0);
	     B   : IN signed(2*N DOWNTO 0);
		 D   : IN signed(2*N DOWNTO 0);
	     sel : IN std_logic_vector(1 DOWNTO 0);
		 C   : OUT signed(2*N DOWNTO 0));
	END COMPONENT MUX_3x1;
	FOR ALL: MUX_3x1 USE ENTITY WORK.MUX_3x1 (MUX_3x1);

	COMPONENT SHR IS
		Generic(N  : INTEGER);
		PORT(Frame           : IN signed(2*N DOWNTO 0);
		 Frame_OUT       : OUT signed(2*N DOWNTO 0));
	END COMPONENT SHR;
	FOR ALL: SHR USE ENTITY WORK.SHR (SHR);
	
	COMPONENT SUB_SHR IS
		Generic(N  : INTEGER);
		PORT(Frame           : IN signed(2*N DOWNTO 0);
	     M               : IN signed(N-1 DOWNTO 0);
		 Frame_OUT       : OUT signed(2*N DOWNTO 0));
	END COMPONENT SUB_SHR;
	FOR ALL: SUB_SHR USE ENTITY WORK.SUB_SHR (SUB_SHR);
	
	COMPONENT ADD_SHR IS
		Generic(N  : INTEGER);
		PORT(Frame           : IN signed(2*N DOWNTO 0);
	     M               : IN signed(N-1 DOWNTO 0);
		 Frame_OUT       : OUT signed(2*N DOWNTO 0));
	END COMPONENT ADD_SHR;
	FOR ALL: ADD_SHR USE ENTITY WORK.ADD_SHR (ADD_SHR);
	
	COMPONENT MUX_2x1 IS
		Generic(N  : INTEGER);
		PORT(A   : IN signed(2*N DOWNTO 0);
	     B   : IN signed(2*N DOWNTO 0);
	     sel : IN std_logic;
		 C   : OUT signed(2*N DOWNTO 0));
	END COMPONENT MUX_2x1;
	FOR ALL: MUX_2x1 USE ENTITY WORK.MUX_2x1 (MUX_2x1);
	
	
	COMPONENT DFF IS
		Generic(N : INTEGER);
		PORT(D  : IN signed(2*N DOWNTO 0);
	     CLK: IN std_logic;
	     RST: IN std_logic;
	   	 q  : OUT signed(2*N DOWNTO 0));
	END COMPONENT DFF;
	
	COMPONENT MUX_2x1_R IS
		Generic(N  : INTEGER);
		PORT(A   : IN signed(N-1 DOWNTO 0);
	     B   : IN signed(N-1 DOWNTO 0);
	     sel : IN std_logic;
		 C   : OUT signed(N-1 DOWNTO 0));
END COMPONENT MUX_2x1_R;
	
	--Internal Signals
	SIGNAL INTIAL : signed(2*N DOWNTO 0); 
	SIGNAL ACC : signed(N-1 DOWNTO 0);
	SIGNAL q0 :  signed(2*N DOWNTO 0);
	SIGNAL CN_1 :  std_logic;
	SIGNAL F_A_SHR :  signed(2*N DOWNTO 0);
	SIGNAL F_S_SHR :  signed(2*N DOWNTO 0);
	SIGNAL F_SHR :  signed(2*N DOWNTO 0);
	SIGNAL R_F :  signed(2*N DOWNTO 0);
	SIGNAL R_M :  signed(2*N DOWNTO 0);
	SIGNAL DN :   std_logic;
	SIGNAL SEL :  std_logic_vector(1 DOWNTO 0);
	SIGNAL ZEROS: signed(N-1 DOWNTO 0);
	
BEGIN	
	P1:PROCESS(A,B,mode) IS BEGIN
		FOR z in 0 to N-1 loop
			ACC(z) <= '0';
		END LOOP;
	END PROCESS;
	
	P2:PROCESS(SEL,q0) IS BEGIN
	FOR i in 0 to N-1 LOOP
		ZEROS(i) <= '0';
		END LOOP;
	END PROCESS;
	
	
	INTIAL <= ACC & B & '0';
	SEL <= std_logic_vector(q0(1 DOWNTO 0));
	VALID <= DN; 
	BUSY  <= (NOT DN) AND (NOT CN_1) ;
	  
	MUX_2x1_u: MUX_2x1
	GENERIC MAP(N)
	PORT MAP (INTIAL,R_F,CN_1,R_M);
	
	DFF_u0: DFF
	GENERIC MAP(N)
	PORT MAP (R_M,CLK,RST,q0);
	
	ADD_SHR_u: ADD_SHR
	GENERIC MAP(N)
	PORT MAP (q0,A,F_A_SHR);
	
	SUB_SHR_u: SUB_SHR
	GENERIC MAP(N)
	PORT MAP (q0,A,F_S_SHR);
	
	SHR_u: SHR
	GENERIC MAP(N)
	PORT MAP (q0,F_SHR);
	
	MUX_3x1_u: MUX_3x1
	GENERIC MAP(N)
	PORT MAP (F_S_SHR,F_A_SHR,F_SHR,SEL,R_F);
	  
	counter_u: counter
	GENERIC MAP(N)
	PORT MAP (CLK,RST,mode,DN,CN_1);
	
	MUX_2x1_R0: MUX_2x1_R
	GENERIC MAP(N)
	PORT MAP (q0(2*N DOWNTO (2*N-(N-1))),ZEROS,DN,m);
	
	MUX_2x1_R1: MUX_2x1_R
	GENERIC MAP(N)
	PORT MAP (q0(N DOWNTO 1),ZEROS,DN,r);
	
	
	
	
	
END ARCHITECTURE MUL;