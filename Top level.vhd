library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity top_level is 
port(
    clk, rst, go : in std_logic
);
end top_level;


architecture rtl of top_level is

        component data_path is
            port(
                clk, rst : in std_logic;
                main_add_sel,main_add_reg, c_reg:in std_logic;
                data_c: out std_logic_vector (7 downto 0);
                data_a,data_b : in std_logic_vector (7 downto 0)
             );
        end component;


        component Tlc is
            port (
              main_add_sel,main_add_reg, c_reg : out std_logic;
              clk,go,rst : in  STD_LOGIC;
              addA,addB,addC : out std_logic_vector (3 downto 0)
              
            ) ;
          
        end component ;

        component ramC is
            port (
                clk,wr : in std_logic;
                addr : in std_logic_vector(3 downto 0);
                din : in std_logic_vector (7 downto 0)
            );
        end component;

        component ramA is
            port (
                clk : in std_logic;
                addr : in std_logic_vector(3 downto 0);
                dout : out std_logic_vector (7 downto 0)
            );
        end component;

        component ramB is
            port (
                clk : in std_logic;
                addr : in std_logic_vector(3 downto 0);
                dout : out std_logic_vector (7 downto 0)
            );
        end component;

            signal m_a_s, m_a_r, c_r : std_logic;
            signal a,b,c : std_logic_vector (3 downto 0);
            signal a_d,b_d,c_d : std_logic_vector (7 downto 0);
begin

    u1: Tlc port map(
        main_add_sel=>m_a_s,
        main_add_reg=>m_a_r,
        c_reg=>c_r,
        clk=>clk,
        go=>go,
        rst=>rst,
        addA=>a,
        addB=>b,
        addC=>c
            );

    u2: data_path port map(
        clk=>clk,
        rst=>rst,
        main_add_sel=>m_a_s,
        main_add_reg=>m_a_r,
        c_reg=>c_r,
        data_c=>c_d,
        data_a=>a_d,
        data_b=>b_d
     );
    
    u3:  ramC port map (
            clk=>clk,
            wr=>c_r,
            addr=>c,
            din =>c_d
        );
    
    u4: ramA port map(
        clk =>clk,
        addr=> a,
        dout=> a_d
    );
    u5: ramB port map(
        clk =>clk,
        addr=> b,
        dout =>b_d
    );
end rtl;