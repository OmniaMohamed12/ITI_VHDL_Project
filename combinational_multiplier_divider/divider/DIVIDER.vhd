LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.NUMERIC_STD.ALL ;
use IEEE.std_logic_signed.all;


ENTITY DIVIDER IS
   GENERIC (N: POSITIVE := 4);
   PORT(
	 A: IN SIGNED (3 DOWNTO 0);
	 B: IN SIGNED   (3 DOWNTO 0);
	 M: OUT SIGNED (3 DOWNTO 0);
         R: OUT SIGNED   (3 DOWNTO 0);
         ERROR : OUT STD_LOGIC ;
         BUSY  : OUT STD_LOGIC;
         VALID : OUT STD_LOGIC
         
        );
END ENTITY DIVIDER;
 
 ARCHITECTURE BEHAVE OF DIVIDER IS  BEGIN
  
   DIV: PROCESS (A, B) IS

-- THE VARIABLES:

   VARIABLE R_D: SIGNED  (2*N-1 DOWNTO 0)    := (others => '0') ;
   VARIABLE REMINDER: SIGNED(N-1 DOWNTO 0)      := (others => '0');
   VARIABLE DIVISOR: SIGNED  (N-1 DOWNTO 0)      := (others => '0');
   VARIABLE DIVIDEND: SIGNED (N-1 DOWNTO 0)      := (others => '0');
   VARIABLE LAST_DIVISOR : SIGNED  (N-1 DOWNTO 0)      := (others => '0');

   VARIABLE S_A: SIGNED (N-1 DOWNTO 0)      := (others => '0');
   VARIABLE S_B: SIGNED  (N-1 DOWNTO 0)      := (others => '0');

   VARIABLE S_M: SIGNED (N-1 DOWNTO 0)      := (others => '0');
   VARIABLE S_R: SIGNED (N-1 DOWNTO 0)      := (others => '0');

   VARIABLE s_RESULT: SIGNED (N-1 DOWNTO 0)      := (others => '0');
   VARIABLE s_REMINDER: SIGNED (N-1 DOWNTO 0)      := (others => '0');
   VARIABLE S_comp : std_logic;
    
   
   BEGIN 

    

-- VARIABLE TO COMPARE BETWEEN MOST SIGINIF

   S_comp := (A(N-1) xor B(N-1));

-- 2'COMPLEMENT OF A AND B IF MOST SIG EQUAL 0NE

    if A(N-1) = '1' THEN
         for j in 0 to N-1 loop
             S_A(j) := (A(j) XOR '1');
          END LOOP;
             S_A := S_A +1;
     ELSE
          S_A:= A;
     END IF;

     if B(N-1) = '1' THEN
          for K in 0 to N-1 loop
              S_B(K) := (B(K) XOR'1');
           END LOOP;
             S_B := S_B +1;
      ELSE
            S_B := B;
      END IF;

 -- INITIAL VALUE OF VARIABLES:
       REMINDER := "0000";
       DIVISOR := (S_B) ;
       DIVIDEND := S_A;
       R_D := REMINDER & DIVIDEND;

        IF S_B = "0000" then
             ERROR <= '1';
             VALID <= '0';
        

   ELSE
--IF S_A >= S_B THEN
     FOR I IN 0 TO N-1 LOOP
        R_D := R_D(2*N-2 DOWNTO 0) &'0';
        LAST_DIVISOR := R_D(2*N-1 DOWNTO N);
        REMINDER (N-1 DOWNTO 0) := LAST_DIVISOR (N-1 DOWNTO 0)- DIVISOR(N-1 DOWNTO 0);
        R_D :=REMINDER & R_D(N-1 DOWNTO 0);
      
         IF REMINDER(N-1) = '1' THEN 
             DIVIDEND := R_D(N-1 DOWNTO 1) & '0';
             R_D := LAST_DIVISOR & DIVIDEND;
          ELSE
             DIVIDEND := R_D(N-1 DOWNTO 1) & '1';
             R_D := REMINDER & DIVIDEND;
           END IF;
          END LOOP;
    
          S_M:=  (R_D (N-1 DOWNTO 0));
          S_R:=  ( R_D( 2*N-1 DOWNTO N));
------------------------------------------
     
          IF  S_comp  = '1' THEN
             FOR y IN 0 TO N-1 LOOP
               S_M(y) := (S_M(y) XOR '1'); 
              END LOOP;
              M <= S_M +1;      
          ELSE
              M <= S_M;
         END IF;

         IF  S_comp = '1' THEN
              FOR J IN 0 TO N-1 loop
                S_R(J) := (S_R(J) XOR '1');
              END LOOP;
              R <= S_R +1;
         ELSE
              R <= S_R;
         END IF;

             ERROR <= '0';
             VALID <= '1';

 
--ELSE
 
    
      -- R <=  A;
       --M <= "0000";


END IF;

    
END PROCESS DIV;
   
END  ARCHITECTURE BEHAVE ;

