library IEEE;
LIBRARY std;
USE ieee.numeric_std.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_signed.all;
USE std.textio.ALL;


entity tb_Multiplier is 
end entity tb_Multiplier;

architecture test of tb_Multiplier is

component multiplier_comb is 
generic(N   : integer:=4);
    port(mode: in bit;
       a, b: in signed(N-1 downto 0);
         m, r: out signed(N-1 downto 0);
          busy, valid,error: out bit);
end component multiplier_comb;
signal N : integer := 4;
for dut: multiplier_comb  USE ENTITY work.multiplier_comb (comb);
signal a_tb,b_tb:signed(N-1 downto 0);
signal control_tb:bit;
signal m_tb,r_tb:signed(N-1 downto 0);
signal error_tb,valid_tb,busy_tb:bit;

begin
  
  DUT:multiplier_comb generic map ( N=>4) port map(control_tb,a_tb,b_tb,m_tb,r_tb,busy_tb,valid_tb,error_tb);
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
	VARIABLE message: string (1 TO 30);
    variable total_testcases:integer:=0;
    variable passed_testcases:integer:=0;

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
		  passed_testcases:=passed_testcases+1;
	  END IF;
	   total_testcases:=total_testcases+1;
	  WRITELINE (results_file, results_line); 
	
  end loop;
report "Combinational Multiplier :Total passed testcases:   " & integer'image(passed_testcases)&'/'&integer'image(total_testcases);
  wait;

  
 end process p1;

end architecture test;
