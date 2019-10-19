library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

Entity adder_4bit is
port(a,b: in std_logic_vector (3 downto 0);
     y: out std_logic_vector(3 downto 0));
end adder_4bit;

Architecture rtl of adder_4bit is
 signal y_int: unsigned (3 downto 0);
begin
  y_int <= unsigned(a)+ unsigned(b);
  y <= std_logic_vector(y_int);
end rtl; 
