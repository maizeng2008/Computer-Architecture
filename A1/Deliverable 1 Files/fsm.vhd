library ieee;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

-- Do not modify the port map of this structure
entity comments_fsm is
port (clk : in std_logic;
      reset : in std_logic;
      input : in std_logic_vector(7 downto 0);
      output : out std_logic
  );
end comments_fsm;

architecture behavioral of comments_fsm is

-- The ASCII value for the '/', '*' and end-of-line characters
CONSTANT SLASH_CHARACTER : std_logic_vector(7 downto 0) := "00101111";
CONSTANT STAR_CHARACTER : std_logic_vector(7 downto 0) := "00101010";
CONSTANT NEW_LINE_CHARACTER : std_logic_vector(7 downto 0) := "00001010";

TYPE State_type IS(s0, s1, s2, s3, s4, s5, s6, s7); --Define the states
SIGNAL State: State_Type; --Create a signal that uses the different states

begin

-- Insert your processes here
process (clk, reset)
begin
    If(reset = '1')THEN --Upon reset, set the state to s0
	State <= s0;

    elsif (rising_edge(clk))THEN
	CASE State is
	    when s0 => 
		If input = SLASH_CHARACTER then --if in this clock cycle, the input is '/' then go to state s1
		    State <= s1;
		else -- in other cases, it will keep looping in state0 to wait for '/' happen
		    State <= s0;
    		END IF;
    	    when s1 =>
		If input = SLASH_CHARACTER then --if in this clock cycle, the input is '/' then go to state s2
		    State <= s2;
		elsif input = STAR_CHARACTER then --if in this clock cycle, the input is '*' then go to state s3
		    State <= s3;
		else -- in other cases, it will consider the previous input '/' a code and go back to s0
		    State <= s0;
    		END IF;
	    when s2 => -- the previous input is '//'. After '//' everything is comment, the value will be 1
		If input = NEW_LINE_CHARACTER then --if the input is '\n', it will be the end of the comment, this clock cycle output a '1' and it will go back to s0
		    State <= s4; -- this will lead to s0
		else 
		    State <= s5; -- will lead to output 1 and only if the input of the next clock cycle is '\n' it will go to s4 and be terminated
    		END IF;
	    when s3 => -- the previous input is '/*'. Only '*' will lead the program to check the next output and go to state s6, others will lead the output keep being 1 and stay at s7
		If input = STAR_CHARACTER then
		    State <= s6;
		else
		    State <= s7;
    		END IF;
	    when s4 => -- This is the state when the comment is terminated, it will lead to s0
		    State <= s0;
	    when s5 =>
		If input = NEW_LINE_CHARACTER then
		    State <= s4;
		else
		    State <= s5;
    		END IF;
	    when s6 =>
		If input = SLASH_CHARACTER then -- this comment is terminated
		    State <= s4;
		else
		    State <= s7;
		END IF;
	    when s7 =>
		If input = STAR_CHARACTER then 
		    State <= s6;
		else
		    State <= s7;
		END IF;
	END CASE;
    END IF;
    
end process;

process(State) is 
begin
    case State is
	when s4 =>
	    output <= '1';
	when s5 =>
	    output <= '1';
	when s6 =>
	    output <= '1';
	when s7 =>
	    output <= '1';
	when s0 =>
	  output <= '0';
	when s1 =>
	    output <= '0';
	when s2 =>
	    output <= '0';
	when s3 =>
	    output <= '0';
    END CASE;
END PROCESS;

	  

end behavioral;