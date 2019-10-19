library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Top_level_tp is
end Top_level_tp;

architecture t_b of Top_level_tp is

    component top_level is
        Port (  clk, rst, go : in std_logic);
    end component;

    signal go,rst : std_logic;
    signal clk : std_logic := '0';
begin

dut: top_level port map(clk,rst,go);
rst <= '1','0' after 70 ns;

go <= '0','1' after 220 ns , '0' after 720 ns;
clk <= not(clk) after 100 ns;

end t_b;