LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;
use IEEE.math_real.all;
use std.textio.all ;
use ieee.std_logic_textio.all ;
-- USE ieee.std_logic_arith.ALL;
-- use ieee.numeric_bit.all;

entity mult_divide_tb_2 is
	generic (N: integer := 4) ;
end entity mult_divide_tb_2 ;

architecture tb_2 of mult_divide_tb_2 is
	component mult_divide is
		generic (N: integer :=4) ;	
		port ( a: in signed (N-1 downto 0); b: in signed (N-1 downto 0); clk, RST, start,op: in std_logic ; m: out signed (N-1 downto 0) ; r: out std_logic_vector (N-1 downto 0); error, busy, valid: out std_logic);
	end component mult_divide ;

	signal 	a_tb: signed (N-1 downto 0);
	signal	b_tb: signed (N-1 downto 0);
	signal	clk_tb, RST_tb, start_tb, op_tb: std_logic ;				
	signal	m_seq_tb: signed (N-1 downto 0) ;
	signal	r_seq_tb: std_logic_vector (N-1 downto 0);
	signal	error_seq_tb, busy_seq_tb, valid_seq_tb: std_logic ;
	
	signal	m_comb_tb: signed (N-1 downto 0) ;
	signal	r_comb_tb: std_logic_vector (N-1 downto 0);
	signal	error_comb_tb, busy_comb_tb, valid_comb_tb: std_logic ;	
	
	for seq: mult_divide use entity work.mult_divide (seq) ;
	for comb: mult_divide use entity work.mult_divide (comb) ;	
	
	begin
		seq: mult_divide port map(a=>a_tb, b=>b_tb, clk=>clk_tb, RST=>RST_tb, start=>start_tb, op=>op_tb, m=>m_seq_tb, r=>r_seq_tb, error=>error_seq_tb, busy=>busy_seq_tb, valid=>valid_seq_tb) ;				
		comb: mult_divide port map(a=>a_tb, b=>b_tb, clk=>clk_tb, RST=>RST_tb, start=>start_tb, op=>op_tb, m=>m_comb_tb, r=>r_comb_tb, error=>error_comb_tb, busy=>busy_comb_tb, valid=>valid_comb_tb) ;					
		
		clock:process is
			begin
				clk_tb<='0', '1' after 10 ns ;   -- clock period=20 ns
				wait for 20 ns ;
			end process clock ;		
		
		sequential: process is
			begin
				if op_tb='1' then
					seq_divider_procedure(a_tb, b_tb, clk_tb, RST_tb, start_tb, m_tb, r_tb, error_tb, busy_tb, valid_tb) ;									
				else 
					seq_multiplier_procedure(a_tb, b_tb, clk_tb, RST_tb, op_tb, m_tb, r_tb, error_tb, busy_tb, valid_tb) ;								
				end if ;				

				wait ;
				
			end process sequential ;

		combinational: process is
			begin			
				if op_tb='1' then
					comb_divider_procedure(a_tb, b_tb, clk_tb, RST_tb, op_tb, m_tb, r_tb, error_tb, busy_tb, valid_tb) ;									
				else 
					comb_multiplier_procedure(a_tb, b_tb, clk_tb, RST_tb, op_tb, m_tb, r_tb, error_tb, busy_tb, valid_tb) ;								
				end if ;

				wait ;
				
			end process combinational ;				
	end architecture tb_2 ;