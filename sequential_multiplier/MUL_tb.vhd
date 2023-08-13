library IEEE;
LIBRARY std;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_signed.all;


ENTITY MUL_tb IS
END ENTITY MUL_tb;





ARCHITECTURE with_files OF MUL_tb IS

 COMPONENT MUL IS
	GENERIC( N: integer := 4);
PORT( A: IN signed(N-1 DOWNTO 0);
		  B: IN signed(N-1 DOWNTO 0);
		  mode,CLK,RST: IN std_logic;
		  m : OUT signed(N-1 DOWNTO 0);
		  r : OUT signed(N-1 DOWNTO 0);
		  VALID:  OUT std_logic;
		  BUSY:   OUT  std_logic);
END COMPONENT MUL;
  FOR dut: MUL USE ENTITY WORK.MUL (MUL);  
	
	SIGNAL	  A_tb:  signed(3 DOWNTO 0);
	SIGNAL	  B_tb:  signed(3 DOWNTO 0);
	SIGNAL	  mode_tb,CLK_tb,RST_tb: std_logic;
	SIGNAL   VALID_tb,BUSY_tb : std_logic;
	SIGNAL   m_tb,r_tb: signed(3 DOWNTO 0);
	
	
  BEGIN
	dut: MUL PORT MAP (A_tb,B_tb,mode_tb,CLK_tb,RST_tb,m_tb,r_tb,VALID_tb,BUSY_tb);
	  
	
	clock_p: PROCESS IS
		BEGIN
			CLK_tb <= '0', '1' AFTER 5 ns;
			WAIT FOR 10 ns;
	END PROCESS clock_p;
	
	
	
	
	pd: PROCESS IS
		BEGIN
		RST_tb <= '0';    
		A_tb <= "0000";
		B_tb <= "0000";
		mode_tb <= '0';
		WAIT FOR 3 ns;
		
		RST_tb <= '1';    
		A_tb <= "1111";
		B_tb <= "0001";
		mode_tb <= '0';
		WAIT FOR 57 ns;
		
		A_tb <= "1110";
		B_tb <= "0001";
		WAIT FOR 60 ns;
		
		A_tb <= "1101";
		B_tb <= "0001";
		WAIT FOR 60 ns;
		
		A_tb <= "1100";
		B_tb <= "0001";
		WAIT FOR 60 ns;
		
		
		A_tb <= "1011";
		B_tb <= "0001";
		WAIT FOR 60 ns;
		
		A_tb <= "1010";
		B_tb <= "0001";
		WAIT FOR 60 ns;
		
		
		A_tb <= "1001";
		B_tb <= "0001";
		WAIT FOR 60 ns;
		
		
		A_tb <= "1011";
		B_tb <= "1001";
		WAIT FOR 60 ns;
		
		A_tb <= "1001";
		B_tb <= "0101";
		WAIT;	
		END PROCESS pd;
END ARCHITECTURE with_files;


