LIBRARY ieee;
USE ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

ENTITY pipeline_tb IS
END pipeline_tb;

ARCHITECTURE behaviour OF pipeline_tb IS

COMPONENT pipeline IS
port (clk : in std_logic;
      a, b, c, d, e : in integer;
      op1, op2, op3, op4, op5, final_output : out integer
  );
END COMPONENT;

--The input signals with their initial values
SIGNAL clk: STD_LOGIC := '0';
SIGNAL s_a, s_b, s_c, s_d, s_e : INTEGER := 0;
SIGNAL s_op1, s_op2, s_op3, s_op4, s_op5, s_final_output : INTEGER := 0;

CONSTANT clk_period : time := 1 ns;

BEGIN
dut: pipeline
PORT MAP(clk, s_a, s_b, s_c, s_d, s_e, s_op1, s_op2, s_op3, s_op4, s_op5, s_final_output);

 --clock process
clk_process : PROCESS
BEGIN
	clk <= '0';
	WAIT FOR clk_period/2;
	clk <= '1';
	WAIT FOR clk_period/2;
END PROCESS;
 

stim_process: PROCESS
BEGIN   
	--TODO: Stimulate the inputs for the pipelined equation ((a + b) * 42) - (c * d * (a - e)) and assert the results
	REPORT "Fill the pipeline and wait for 3 clock cycle";
	s_a <= 1;
	s_b <= 2;
	s_c <= 3;
	s_d <= 4;
	s_e <= 5;
	
	WAIT FOR 3 * clk_period;
	
	ASSERT (s_op1 = 3) 
	REPORT "op1 should = 0 but was :" & integer'image(s_op1) SEVERITY ERROR;
  ASSERT (s_op3 = 12) 
  REPORT "op3 should = 0 but was :" & integer'image(s_op1) SEVERITY ERROR;
  ASSERT (s_op4 = -4) 
  REPORT "op4 should = 0 but was :" & integer'image(s_op1) SEVERITY ERROR;
  ASSERT (s_op2 = 126) 
  REPORT "op2 should = 0 but was :" & integer'image(s_op1) SEVERITY ERROR;
  ASSERT (s_op5 = -48) 
  REPORT "op1 should = but was :0" & integer'image(s_op1) SEVERITY ERROR; 
  ASSERT (s_final_output = 174) 
  REPORT "final output should = 174 after 2 CC, but was " & integer'image(s_final_output) SEVERITY ERROR;
	
	REPORT "-------------------------------------------------------------------------------";
	
	REPORT "Fill the pipeline and wait for 1 clock cycle should get 11, 13, 14";
	s_a <= 1;
	s_b <= 2;
	s_c <= 3;
	s_d <= 4;
	s_e <= 5;
	
	ASSERT (s_op1 = 3) 
	REPORT "op1 should = 0 but was :" & integer'image(s_op1) SEVERITY ERROR;
  ASSERT (s_op3 = 12) 
  REPORT "op3 should = 0 but was :" & integer'image(s_op1) SEVERITY ERROR;
  ASSERT (s_op4 = -4) 
  REPORT "op1 should = -4 after 1 CC, but was " & integer'image(s_op1) SEVERITY ERROR; 

 	WAIT FOR 1* clk_period;
 	
 	REPORT "Fill the another pipeline and wait for 1 clock cycle should get 12, 15, 21, 23, 24";
 	s_a <= 2;
	s_b <= 3;
	s_c <= 4;
	s_d <= 5;
	s_e <= 6;
	
	ASSERT (s_op2 = 126) 
  REPORT "op2 should = 0 but was :" & integer'image(s_op1) SEVERITY ERROR;
  ASSERT (s_op5 = -48) 
  REPORT "op1 should = but was :0" & integer'image(s_op1) SEVERITY ERROR; 
  ASSERT (s_op1 = 3) 
  REPORT "op1 should = 5 after 2 CC, but was " & integer'image(s_op1) SEVERITY ERROR;
  ASSERT (s_op3 = 12) 
  REPORT "op3 should = 20 after 2 CC, but was " & integer'image(s_op3) SEVERITY ERROR;
  ASSERT (s_op4 = -4) 
  REPORT "op4 should = -4 after 2 CC, but was " & integer'image(s_op4) SEVERITY ERROR;
  ASSERT (s_final_output = 174) 
	REPORT "final output should = 174 after 2 CC, but was " & integer'image(s_final_output) SEVERITY ERROR;
  
 	WAIT FOR 1* clk_period;
	ASSERT (s_op1 = 5) 
  REPORT "op1 should = 5 after 2 CC, but was " & integer'image(s_op1) SEVERITY ERROR;
  ASSERT (s_op3 = 20) 
  REPORT "op3 should = 20 after 2 CC, but was " & integer'image(s_op3) SEVERITY ERROR;
  ASSERT (s_op4 = -4) 
  REPORT "op4 should = -4 after 2 CC, but was " & integer'image(s_op4) SEVERITY ERROR;
	ASSERT (s_op2 = 126) 
  REPORT "op2 should = 0 but was :" & integer'image(s_op1) SEVERITY ERROR;
  ASSERT (s_op5 = -48) 
  REPORT "op1 should = but was :0" & integer'image(s_op1) SEVERITY ERROR; 
  ASSERT (s_final_output = 174) 
	REPORT "final output should = 174 after 2 CC, but was " & integer'image(s_final_output) SEVERITY ERROR;
	WAIT;
END PROCESS stim_process;
END;
