library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity d_ff_4bit is
    Port ( clk,load,rst: in  STD_LOGIC;
           d : in  STD_LOGIC_vector (3 downto 0);
           q : out  STD_LOGIC_vector (3 downto 0));
end d_ff_4bit;

architecture rtl of d_ff_4bit is

begin
    process (rst,clk)
    begin
   if (rst = '1') then
    q   <= "0000";  
elsif rising_edge(clk) then
            if load = '1' then
                q <= d;
            end if ;
        end if;

    end process;
end rtl;

