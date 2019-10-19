

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;



entity subtractor is
    Port ( 
           A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
           S : out  STD_LOGIC_VECTOR (7 downto 0));

end subtractor;

architecture Behavioral of subtractor is
 signal x,y,z : unsigned (7 downto 0); 
	
begin
    s <= STD_LOGIC_VECTOR(z);
    x <= unsigned(A);
    y <= unsigned (B); 
    z <= x - y;

end Behavioral;

