
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;


entity ramC is
port (
    clk,wr : in std_logic;
    addr : in std_logic_vector(3 downto 0);
    din : in std_logic_vector (7 downto 0)
    );
end ramC;

architecture rtl of ramC is
type ram_type is array (0 to 15) of std_logic_vector(7 downto 0);
signal program : ram_type;
begin

    process(clk)
    begin
        if rising_edge(clk) then
            if (wr = '1') then
                program(conv_integer(unsigned(addr))) <= din;
            end if ;
            
        end if ;
    end process;
end rtl;