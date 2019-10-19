
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;


entity ramA is
port (
    clk : in std_logic;
    addr : in std_logic_vector(3 downto 0);
    dout : out std_logic_vector (7 downto 0)
);
end ramA;

architecture rtl of ramA is
type ram_type is array (0 to 15) of std_logic_vector(7 downto 0);
constant program : ram_type := (
    "00000000",
    "00000001",
    "00000011",
    "00000111",
    "00001000",
    "00001001",
    "00001010",
    "00000100",
    "00000010",
    "00000001",
    "00000000",
    "00000010",
    "00000000",
    "00000000",
    "00000000",
    "00000000"
);
begin
           
            dout <= program(conv_integer(unsigned(addr)));
 
end rtl;