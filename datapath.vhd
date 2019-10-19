library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity data_path is
port(
    clk, rst : in std_logic;
    main_add_sel,main_add_reg, c_reg:in std_logic;
    data_c: out std_logic_vector (7 downto 0);
    data_a,data_b : in std_logic_vector (7 downto 0)
);
end data_path;

architecture rtl of data_path is
    
-----------------------------------------------------
------------- registers for addresses----------------
-----------------------------------------------------

    component d_ff_4bit is
        Port ( clk,load,rst: in  STD_LOGIC;
               d : in  STD_LOGIC_vector (3 downto 0);
               q : out  STD_LOGIC_vector (3 downto 0));
    end component;

-----------------------------------------------------
------------- registers for main signals-------------
-----------------------------------------------------

    component d_ff_8bit is
        Port ( clk,load,rst: in  STD_LOGIC;
               d : in  STD_LOGIC_vector (7 downto 0);
               q : out  STD_LOGIC_vector (7 downto 0));
    end component;

-----------------------------------------------------
-----------------adder used for address--------------
-----------------------------------------------------

    component adder_4bit is
        port(a,b: in std_logic_vector (3 downto 0);
             y: out std_logic_vector(3 downto 0));
    end component;

    
-----------------------------------------------------
----------------the main adder-----------------------
-----------------------------------------------------

    component adder_8bit is
        port(a,b: in std_logic_vector (7 downto 0);
             y: out std_logic_vector(7 downto 0));
    end component;


-----------------------------------------------------
----------------multiplier---------------------------
-----------------------------------------------------

    component dadda_multi is
        port(
          a: in std_logic_vector(7 downto 0);
          b: in std_logic_vector(7 downto 0);
          p: out std_logic_vector(15 downto 0)
        );
    end component;


    component subtractor is
        Port ( 
               A : in  STD_LOGIC_VECTOR (7 downto 0);
               B : in  STD_LOGIC_VECTOR (7 downto 0);
               S : out  STD_LOGIC_VECTOR (7 downto 0));
    end component;
-----------------------------------------------------
----------signal declarations------------------------
-----------------------------------------------------
signal mul_to_adder , mul_reg, adder_out,main_adder_mux, cc :std_logic_vector (7 downto 0);
signal mul :std_logic_vector (15 downto 0);

begin

u1: dadda_multi port map(
      a=> data_a,
      b=> data_b,
      p=>mul
    );

--take the last 8 MSB from multiplication result to the input of the main adder
mul_to_adder <= mul (7 downto 0);

u2: adder_8bit port map(
    a=> mul_to_adder,
    b=> mul_reg,
    y=> adder_out
);

--mux between to choose if sum = 0 or sum = sum + a * b
process(main_add_sel,adder_out)
begin
    if main_add_sel = '1' then
        main_adder_mux <= adder_out;
    else
        main_adder_mux <= "00000000";
    end if ;
end process;

--adder second input flip flop
u3: d_ff_8bit port map(
    clk=>clk,
    load=>main_add_reg,
    rst=>rst,
    d=>main_adder_mux,
    q=>mul_reg
);

--main output flip flop
u4: d_ff_8bit port map(
    clk=>clk,
    load=>c_reg,
    rst=>rst,
    d=>cc,
    q=>data_c
);


u5: subtractor port map ( 
           A => adder_out,
           B =>mul_to_adder,
           S =>cc);

end rtl;