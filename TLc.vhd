library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity Tlc is
  port (
    main_add_sel,main_add_reg, c_reg : out std_logic;
    clk,go,rst : in  STD_LOGIC;
    addA,addB,addC : out std_logic_vector (3 downto 0)
    
    ) ;

end Tlc ;

architecture rtl of tlc is
    type state_type is (s0, s1, s2,s3,s4,s5,s6,s6_1,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17);
    signal c_s , n_s : state_type;
    signal  addA_i,addB_i,addC_i : unsigned (3 downto 0);
    signal  a,b : unsigned (3 downto 0);

    signal i : unsigned (3 downto 0);
    begin

        process(rst,clk)
        begin
            if rst ='1' then
                c_s <= s0;
            elsif rising_edge(clk) then
                c_s <= n_s;
            end if;
        end process;


        process (c_s,go)
        begin
        
            case(c_s) is
            
                when s0 =>  main_add_sel <= '0';
                            main_add_reg <= '0';
                            c_reg <= '0';
                
                if (go ='0')then
                    n_s <= s1;
                elsif (go = '1')then
                    n_s <= s2;
                end if;
------------------------------------------------------------------
                when s1 =>  main_add_sel <= '0';
                            main_add_reg <= '0';
                            c_reg <= '0';
                --LOOP
                n_s <= s0;
------------------------------------------------------------------        
                when s2 =>  main_add_sel <= '0';
                            main_add_reg <= '0';
                            c_reg <= '0';
                            addA_i <= "0000";
                            addB_i <= "0000";
                            addC_i <= "0000";
                            n_s <= s3;
-------------------------------------------------------------------             
                when s3 =>  main_add_sel <= '0';
                            main_add_reg <= '1';
                            c_reg <= '0';
                            i <= "0000";
                            n_s <= s4;
------------------------------------------------------------------
                when s4 =>  main_add_sel <= '1';
                            main_add_reg <= '0';
                            c_reg <= '0';
                            
                            if(i<4) then
                                n_s <= s5;
                            else
                                n_s <= s7;
                            end if;
------------------------------------------------------------------
                when s5 =>  main_add_sel <= '1';
                            main_add_reg <= '0';
                            c_reg <= '0';
                            a<= addA_i +i;
                            b<= addB_i +i;
                            n_s <= s6; 
-------------------------------------------------------------------
                when s6 =>  main_add_sel <= '1';
                            main_add_reg <= '1';
                            c_reg <= '0';
                            n_s <= s6_1;
                
                when s6_1 =>main_add_sel <= '1';
                            main_add_reg <= '0';
                            c_reg <= '0';
                            i <= i + 1;
                            n_s <= s4;
-------------------------------------------------------------------                                        
                when s7 =>  main_add_sel <= '1';
                            main_add_reg <= '0';
                            c_reg <= '0';
                            
                            if addB_i = 0 then
                                n_s <= s8;
                            elsif addB_i = 4 then
                                n_s <= s9;
                            elsif addB_i = 8 then
                                n_s <= s10;
                            end if ;
--------------------------------------------------------------------
                when s8 =>  main_add_sel <= '1';
                            main_add_reg <= '0';
                            c_reg <= '0';
                            addB_i <= "0100";
                            n_s <= s14;
---------------------------------------------------------------------                           
                when s9 =>  main_add_sel <= '1';
                            main_add_reg <= '0';
                            c_reg <= '0';
                            addB_i <= "1000";
                            n_s <= s14;
----------------------------------------------------------------------                            
                when s10 => main_add_sel <= '1';
                            main_add_reg <= '0';
                            c_reg <= '0';
                            addB_i <= "0000";

                            if addA_i = 0 then
                                n_s <= s11;
                            elsif addA_i = 4 then
                                n_s <= s12;
                            elsif addA_i = 8 then
                                n_s <= s13;
                            end if ;
---------------------------------------------------------------------
                when s11 => main_add_sel <= '1';
                            main_add_reg <= '0';
                            c_reg <= '0';
                            addA_i <= "0100";
                            n_s <= s14;
---------------------------------------------------------------------
                when s12 => main_add_sel <= '1';
                            main_add_reg <= '0';
                            c_reg <= '0';
                            addA_i <= "1000";
                            n_s <= s14;
---------------------------------------------------------------------
                when s13 => main_add_sel <= '1';
                            main_add_reg <= '0';
                            c_reg <= '1';
                            n_s <= s16;
---------------------------------------------------------------------
                when s14 => main_add_sel <= '1';
                            main_add_reg <= '0';
                            c_reg <= '1';
                            n_s <= s15;
---------------------------------------------------------------------
                 when s15 => main_add_sel <= '1';
                            main_add_reg <= '0';
                            c_reg <= '1';
                            addC_i <= addC_i+1;
                            n_s <= s3;
---------------------------------------------------------------------
                when s16 =>main_add_sel <= '1';
                            main_add_reg <= '0';
                            c_reg <= '1';
                            addC_i <= addC_i+1;
                            n_s <= s17;
---------------------------------------------------------------------
                when s17 =>main_add_sel <= '1';
                            main_add_reg <= '0';
                            c_reg <= '0';
                             n_s <= s0;
---------------------------------------------------------------------
                when others =>n_s <= s0;
            
            end case ;

            addA <= std_logic_vector(a);
            addB <= std_logic_vector(b);
            addC <= std_logic_vector(addC_i);
            
        end process;
       
end rtl;
