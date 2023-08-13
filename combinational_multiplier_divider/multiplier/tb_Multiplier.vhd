library IEEE;
LIBRARY std;
USE ieee.numeric_std.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_signed.all;
USE std.textio.ALL;


entity tb_Multiplier_Divider is 
end entity tb_Multiplier_Divider;

architecture test of tb_Multiplier_Divider is

component multiplier_divider_comb is 
generic(N   : integer:=4);
    port(a, b: in signed(N-1 downto 0);
         control: in bit;
         m, r: out signed(N-1 downto 0);
         error, busy, valid: out bit);
end component multiplier_divider_comb;
signal N : integer := 4;
for dut: multiplier_divider_comb  USE ENTITY work.multiplier_divider_comb (comb_multiplier);
signal a_tb,b_tb:signed(N-1 downto 0);
signal control_tb:bit;
signal m_tb,r_tb:signed(N-1 downto 0);
signal error_tb,valid_tb,busy_tb:bit;
begin
  
  DUT:multiplier_divider_comb generic map ( N=>4) port map(a_tb,b_tb,control_tb,m_tb,r_tb,error_tb,busy_tb,valid_tb);
  p1:process 
    FILE test_file: text OPEN READ_MODE IS "multiplier_comb_test_input.txt";
	FILE results_file: text OPEN WRITE_MODE IS "multiplier_comb_test_results.txt";
    VARIABLE input_line: line; 
    VARIABLE results_line: line;	
    VARIABLE a_var,b_var: signed(N-1 downto 0);
    VARIABLE control_var,error_var,valid_var,busy_var:bit;
	VARIABLE r_var,m_var: signed(N-1 downto 0);
    VARIABLE c: character;
    VARIABLE pause: time;  
	VARIABLE message: string (1 TO 24);
 begin
    WHILE NOT endfile(test_file) LOOP
    READLINE (test_file, input_line);
    READ (input_line, a_var);
    READ (input_line,b_var);
	READ (input_line,control_var);
	READ (input_line, pause);
    READ (input_line, m_var);
	READ (input_line, r_var);
	READ (input_line, busy_var);
	READ (input_line, valid_var);
	READ (input_line, error_var);
    READ (input_line, message);
	
  
    a_tb <= a_var;
    b_tb <= b_var;
	control_tb<=control_var;
	wait for pause;
	
	  WRITE (results_line, string'(". a = ")); 			
	  WRITE (results_line, a_tb);
	  
	  WRITE (results_line, string'(", b = ")); 
	  WRITE (results_line, b_tb);

      WRITE (results_line, string'(", control = ")); 
	  WRITE (results_line, control_tb);
	  
	  WRITE (results_line, string'(", Expected m = ")); 
	  WRITE (results_line, m_var);  
	  
	  WRITE (results_line, string'(", Expected r = ")); 
	  WRITE (results_line, r_var);
	  
	  WRITE (results_line, string'(", Actual m = ")); 
	  WRITE (results_line, m_tb);
	  
	  WRITE (results_line, string'(", Actual r = ")); 
	  WRITE (results_line, r_tb);
	  
	  
	  IF m_tb /= m_var or  r_tb /= r_var THEN
          WRITE (results_line, string'(". Test failed! Error message:"));
          WRITE (results_line, message);
	  ELSE
          WRITE (results_line, string'(". Test passed."));
	  END IF;
	
	  WRITELINE (results_file, results_line); 
	
  end loop;
  wait;

  
 end process p1;

end architecture test;