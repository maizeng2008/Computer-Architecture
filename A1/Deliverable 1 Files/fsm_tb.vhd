LIBRARY ieee;
USE ieee.STD_LOGIC_1164.all;

ENTITY fsm_tb IS
END fsm_tb;

ARCHITECTURE behaviour OF fsm_tb IS

COMPONENT comments_fsm IS
PORT (clk : in std_logic;
      reset : in std_logic;
      input : in std_logic_vector(7 downto 0);
      output : out std_logic
  );
END COMPONENT;

--The input signals with their initial values
SIGNAL clk, s_reset, s_output: STD_LOGIC := '0';
SIGNAL s_input: std_logic_vector(7 downto 0) := (others => '0');

CONSTANT clk_period : time := 1 ns;
CONSTANT SLASH_CHARACTER : std_logic_vector(7 downto 0) := "00101111";
CONSTANT STAR_CHARACTER : std_logic_vector(7 downto 0) := "00101010";
CONSTANT NEW_LINE_CHARACTER : std_logic_vector(7 downto 0) := "00001010";

BEGIN
dut: comments_fsm
PORT MAP(clk, s_reset, s_input, s_output);

 --clock process
clk_process : PROCESS
BEGIN
	clk <= '0';
	WAIT FOR clk_period/2;
	clk <= '1';
	WAIT FOR clk_period/2;
END PROCESS;
 
--TODO: Thoroughly test your FSM
stim_process: PROCESS
BEGIN    
	REPORT "Example case, reading a meaningless character";
	s_input <= "01011000";
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading a meaningless character, the output should be '0'" SEVERITY ERROR;
	REPORT "_______________________";
    	
	-- Test 1 using case '//c'
	s_reset <= '1';
	WAIT FOR 1 * clk_period;
	s_reset <= '0';
	
	REPORT "Case: //c";
	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "Output should be '0'" SEVERITY ERROR;

	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "Output should be '0'" SEVERITY ERROR;

	s_input <= "01100011";
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "Output should be '1'" SEVERITY ERROR;

  	REPORT "________________________________________________________________________";

	-- Test 2 using case '/*c*/'
	s_reset <= '1';
	WAIT FOR 1 * clk_period;
	s_reset <= '0';

	REPORT "Case: /*c*/";

	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "Output should be '0'" SEVERITY ERROR;

	s_input <= STAR_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "Output should be '0'" SEVERITY ERROR;

	s_input <= "01100011";
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "Output should be '0'" SEVERITY ERROR;

	s_input <= STAR_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "Output should be '0'" SEVERITY ERROR;

	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "Output should be '0'" SEVERITY ERROR;

  	REPORT "________________________________________________________________________";

	-- Test 3 using case '/*c\n*/'
	s_reset <= '1';
	s_reset <= '0';
	WAIT FOR 1 * clk_period;

	REPORT "Case: /*c\n*/";

	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "First / Output should be '0'" SEVERITY ERROR;

	s_input <= STAR_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "After / the * Output should be '0'" SEVERITY ERROR;

	s_input <= "01100011";
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "C Output should be '1'" SEVERITY ERROR;

	s_input <= NEW_LINE_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "\n Output should be '1'" SEVERITY ERROR;

	s_input <= STAR_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "* Output should be '1'" SEVERITY ERROR;

	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "/ Output should be '1'" SEVERITY ERROR;

  	REPORT "________________________________________________________________________";

	-- Test 4 using case '/*c\n*\n'

	s_reset <= '1';
	WAIT FOR 1 * clk_period;
	s_reset <= '0';

	REPORT "Case: /*c\n*\n";

	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "First / Output should be '0'" SEVERITY ERROR;

	s_input <= STAR_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "After / the * Output should be '0'" SEVERITY ERROR;

	s_input <= "01100011";
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "C Output should be '1'" SEVERITY ERROR;

	s_input <= NEW_LINE_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "\n Output should be '1'" SEVERITY ERROR;

	s_input <= STAR_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "* Output should be '1'" SEVERITY ERROR;

	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "/ Output should be '1'" SEVERITY ERROR;

	s_input <= NEW_LINE_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "\n not in comment Output should be '0'" SEVERITY ERROR;

  	REPORT "________________________________________________________________________";

	-- Test 5 using case '//c\n\n'

	s_reset <= '1';
	WAIT FOR 1 * clk_period;
	s_reset <= '0';

	REPORT "Case: //c\n\n";

	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "First / Output should be '0'" SEVERITY ERROR;

	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "Output should be '0'" SEVERITY ERROR;

	s_input <= "01100011";
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "Output should be '1'" SEVERITY ERROR;

	s_input <= NEW_LINE_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "The first \n in the // comment Output should be '1'" SEVERITY ERROR;

	s_input <= NEW_LINE_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "The second \n out the // comment Output should be '0'" SEVERITY ERROR;

  	REPORT "________________________________________________________________________";

	-- Test 6 using case '////c\n'

	s_reset <= '1';
	WAIT FOR 1 * clk_period;
	s_reset <= '0';

	REPORT "Case: ////c\n";

	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "First / Output should be '0'" SEVERITY ERROR;

	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "Output should be '0'" SEVERITY ERROR;

	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "First / Output should be '1'" SEVERITY ERROR;

	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "Output should be '1'" SEVERITY ERROR;

	s_input <= "01100011";
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "Output should be '1'" SEVERITY ERROR;

	s_input <= NEW_LINE_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "The first \n in the // comment Output should be '1'" SEVERITY ERROR;

	-- Test 7 using case '\n/*c*//*c\n*/'
	s_reset <= '1';
	WAIT FOR 1 * clk_period;
	s_reset <= '0';

	REPORT "Case: \n/*c*//*c\n\n*/";

	s_input <= NEW_LINE_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "The first \n out the // comment Output should be '0'" SEVERITY ERROR;

	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "First / Output should be '0'" SEVERITY ERROR;

	s_input <= STAR_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "After / the * Output should be '0'" SEVERITY ERROR;

	s_input <= "01100011";
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "Output should be '1'" SEVERITY ERROR;

	s_input <= STAR_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "Output should be '1'" SEVERITY ERROR;

	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "Output should be '1'" SEVERITY ERROR;

	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "First / Output should be '0'" SEVERITY ERROR;

	s_input <= STAR_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "After / the * Output should be '0'" SEVERITY ERROR;

	s_input <= "01100011";
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "Second sentence, c Output should be '1'" SEVERITY ERROR;

	s_input <= NEW_LINE_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "The first \n in the /* ... */ comment Output should be '1'" SEVERITY ERROR;

	s_input <= NEW_LINE_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "The second \n in the /* ... */ comment Output should be '1'" SEVERITY ERROR;

	s_input <= STAR_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "Output should be '1'" SEVERITY ERROR;

	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "Output should be '1'" SEVERITY ERROR;

	WAIT;
END PROCESS stim_process;
END;
