library ieee;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity pipeline is
port (clk : in std_logic;
      a, b, c, d, e : in integer;
      op1, op2, op3, op4, op5, final_output : out integer
  );
end pipeline;

architecture behavioral of pipeline is

signal op1_final, op2_final, op3_final, op4_final, op5_final : integer;
-- opx_final is the output of each round feed by opx_processing
signal op1_processing, op2_processing, op3_processing, op4_processing, op5_processing : integer;
-- opx_processing is the output of each rising edge feed by the input a,b,c,d,e and opx_final

begin

process (clk)
begin
  if rising_edge(clk) then
    -- each rising edge the opx_processing will feed into the opx_final
    op1_final <= op1_processing;
    op2_final <= op2_processing;
    op3_final <= op3_processing;    
    op4_final <= op4_processing;    
    op5_final <= op5_processing;  
  end if;  
end process;

-- the opx_processing will use the input a,b,c,d,e and the opx_final
-- and that's why this can build as a pipeline
-- some part is asynchronous
-- They need the callback
op1_processing <= a+b;
op2_processing <= op1_final * 42;
op3_processing <= c*d;
op4_processing <= a-e;
op5_processing <= op3_final * op4_final;
final_output <= op2_final - op5_final;

-- The opx_final will feed the value to opx
op1 <= op1_final;
op2 <= op2_final;
op3 <= op3_final;
op4 <= op4_final;
op5 <= op5_final;

end behavioral;