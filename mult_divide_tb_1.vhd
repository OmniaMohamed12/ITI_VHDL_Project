LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;
use IEEE.math_real.all;
use std.textio.all ;
use ieee.std_logic_textio.all ;
-- USE ieee.std_logic_arith.ALL;
-- use ieee.numeric_bit.all;

entity mult_divide_tb_1 is
	generic (N: integer := 4) ;
end entity mult_divide_tb_1 ;

architecture tb_1 of mult_divide_tb_1 is
	component mult_divide is
		generic (N: integer :=4) ;	
		port ( a: in signed (N-1 downto 0); b: in signed (N-1 downto 0); clk, RST, start,op: in std_logic ; m: out signed (N-1 downto 0) ; r: out std_logic_vector (N-1 downto 0); error, busy, valid: out std_logic);
	end component mult_divide ;

	signal 	a_tb: signed (N-1 downto 0);
	signal	b_tb: signed (N-1 downto 0);
	signal	clk_tb, RST_tb, start_tb, op_tb: std_logic ;				
	signal	m_tb: signed (N-1 downto 0) ;
	signal	r_tb: std_logic_vector (N-1 downto 0);
	signal	error_tb, busy_tb, valid_tb: std_logic ;
	
	signal	imp: std_logic ;
	
	for seq: mult_divide use entity work.mult_divide (seq) ;
	for comb: mult_divide use entity work.mult_divide (comb) ;	
	
	begin
		implementation: if imp='1' generate
			begin
				seq: mult_divide port map(a=>a_tb, b=>b_tb, clk=>clk_tb, RST=>RST_tb, start=>start_tb, op=>op_tb, m=>m_tb, r=>r_tb, error=>error_tb, busy=>busy_tb, valid=>valid_tb) ;				
		else generate
			begin
				comb: mult_divide port map(a=>a_tb, b=>b_tb, clk=>clk_tb, RST=>RST_tb, start=>start_tb, op=>op_tb, m=>m_tb, r=>r_tb, error=>error_tb, busy=>busy_tb, valid=>valid_tb) ;					
			end generate implementation ;
		
		clock:process is
			begin
				clk_tb<='0', '1' after 10 ns ;   -- clock period=20 ns
				wait for 20 ns ;
			end process clock ;		
		
		prc: process is
			begin
				if imp='1' then
					if op_tb='1' then
						seq_divider_procedure(a_tb, b_tb, clk_tb, RST_tb, start_tb, m_tb, r_tb, error_tb, busy_tb, valid_tb) ;									
					else 
						seq_multiplier_procedure(a_tb, b_tb, clk_tb, RST_tb, op_tb, m_tb, r_tb, error_tb, busy_tb, valid_tb) ;								
					end if ;
				else
					if op_tb='1' then
						comb_divider_procedure(a_tb, b_tb, clk_tb, RST_tb, op_tb, m_tb, r_tb, error_tb, busy_tb, valid_tb) ;									
					else 
						comb_multiplier_procedure(a_tb, b_tb, clk_tb, RST_tb, op_tb, m_tb, r_tb, error_tb, busy_tb, valid_tb) ;								
					end if ;					
				end if ;

				wait ;
				
			end process prc ;
	end architecture tb_1 ;