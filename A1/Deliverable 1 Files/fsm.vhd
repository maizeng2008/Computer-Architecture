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
constant SLASH_CHARACTER : std_logic_vector(7 downto 0) := "00101111";
constant STAR_CHARACTER : std_logic_vector(7 downto 0) := "00101010";
constant NEW_LINE_CHARACTER : std_logic_vector(7 downto 0) := "00001010";

TYPE State_type IS(s0, s1, s2, s3, s4, s5, s6, s7); --Define the states
SIGNAL State: State_Type; --Create a signal that uses the different states

begin

-- Insert your processes here
process (clk, reset)
begin
    If(reset = '1')THEN --Upon reset, set the state to s0
	State <= s0;

    elsif(rising_edge(clock)THEN

    output <= clk;
end process;

end behavioral;