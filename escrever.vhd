library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ler is
    port (
        clock, reset : in std_logic;
        p0, p1, p2, p3, p4, p5, p6, p7, p8, p9: in  std_logic_vector(4 downto 0);
        hex00, hex01, hex02, hex03, hex04, hex05, hex06,
        hex10, hex11, hex12, hex13, hex14, hex15, hex16,
        hex20, hex21, hex22, hex23, hex24, hex25, hex26,
        hex30, hex31, hex32, hex33, hex34, hex35, hex36: out std_logic
    );
end ler;

architecture arch of ler is
    type palavra is array(9 downto 0) of std_logic_vector(4 downto 0);
    type frase is array(5 downto 0) of palavra;
    
    signal frase_ler: frase;

begin
    process(clock, reset)
        variable a, b, c, d, e,
                a1, b1, c1, d1, e1: std_logic;
        variable i : natural := 0;
    begin
        if reset = '1' then
            i := 0;
            hex00 <= '1'; hex01 <= '1'; hex02 <= '1'; hex03 <= '1'; hex04 <= '1'; hex05 <= '1'; hex06 <= '1';
            hex10 <= '1'; hex11 <= '1'; hex12 <= '1'; hex13 <= '1'; hex14 <= '1'; hex15 <= '1'; hex16 <= '1';
            hex20 <= '1'; hex21 <= '1'; hex22 <= '1'; hex23 <= '1'; hex24 <= '1'; hex25 <= '1'; hex26 <= '1';
            hex30 <= '1'; hex31 <= '1'; hex32 <= '1'; hex33 <= '1'; hex34 <= '1'; hex35 <= '1'; hex36 <= '1';
            frase_ler(0)(0) <= p0;
            frase_ler(0)(1) <= p1; 
            frase_ler(0)(2) <= p2; 
            frase_ler(0)(3) <= p3; 
            frase_ler(0)(4) <= p4; 
            frase_ler(0)(5) <= p5; 
            frase_ler(0)(6) <= p6; 
            frase_ler(0)(7) <= p7; 
            frase_ler(0)(8) <= p8; 
            frase_ler(0)(9) <= p9; 
        elsif clock'event and clock = '0' then
            a := frase_ler(0)(i)(0); b := frase_ler(0)(i)(1); c := frase_ler(0)(i)(2); d := frase_ler(0)(i)(3); e := frase_ler(0)(i)(4);       

            hex00 <= (a and c)                          or 
                    ((not a) and (not c) and e)         or
                    (a and (not b) and e)               or
                    ((not b) and d and e)               or
                    ((not a) and b and (not d) and e)   or
                    (b and (not c) and (not d) and (not e));

            hex01 <= (((not c) and d) and ((not e) or b))   or
                    (a and d and e)                         or
                    (((not a) and (not d)) and (c xor e))   or
                    ((not a) and (not b) and d and (not e)) or
                    ((not a) and c and (not d) and e);
                    
            hex02 <= (b and d and e)                        or
                    (a and (not c) and e)                   or
                    (a and c and d)                         or
                    ((not a) and (not b) and c and (not d)) or
                    ((not a) and (not b) and (not c) and d and (not a));

            hex03 <= ((c and e) and ((not a) or d))                         or
                    (b and c and (not d))                                   or
                    (((not a) and (not c) and (not e)) and ((not d) or b))  or
                    (a and (not b) and (not c) and (not d));

            hex04 <= (a and b)                           or
                    ((a and (not e)) and (d or (not e))) or
                    (b and (not c) and (not d) and (not e));

            hex05 <= (a and b)                           or
                    ((a and (not e)) and (d or (not e))) or
                    (b and (not c) and (not d) and (not e));

            hex06 <= (a and c and (not d))                  or
                    (c and d and (not e))                   or
                    (((not a) and (not c)) and (b xor e))   or
                    ((not a) and b and (not d) and (not e));  

            if i > 0 then 
                a := frase_ler(0)(i - 1)(0); b := frase_ler(0)(i - 1)(1); c := frase_ler(0)(i - 1)(2); d := frase_ler(0)(i - 1)(3); e := frase_ler(0)(i - 1)(4);

                hex10 <= (a and c)                          or 
                        ((not a) and (not c) and e)         or
                        (a and (not b) and e)               or
                        ((not b) and d and e)               or
                        ((not a) and b and (not d) and e)   or
                        (b and (not c) and (not d) and (not e));

                hex11 <= (((not c) and d) and ((not e) or b))   or
                        (a and d and e)                         or
                        (((not a) and (not d)) and (c xor e))   or
                        ((not a) and (not b) and d and (not e)) or
                        ((not a) and c and (not d) and e);
                        
                hex12 <= (b and d and e)                        or
                        (a and (not c) and e)                   or
                        (a and c and d)                         or
                        ((not a) and (not b) and c and (not d)) or
                        ((not a) and (not b) and (not c) and d and (not a));

                hex13 <= ((c and e) and ((not a) or d))                         or
                        (b and c and (not d))                                   or
                        (((not a) and (not c) and (not e)) and ((not d) or b))  or
                        (a and (not b) and (not c) and (not d));

                hex14 <= (a and b)                           or
                        ((a and (not e)) and (d or (not e))) or
                        (b and (not c) and (not d) and (not e));

                hex15 <= (a and b)                           or
                        ((a and (not e)) and (d or (not e))) or
                        (b and (not c) and (not d) and (not e));

                hex16 <= (a and c and (not d))                  or
                        (c and d and (not e))                   or
                        (((not a) and (not c)) and (b xor e))   or
                        ((not a) and b and (not d) and (not e));
            end if;
            if i > 1 then 
                a := frase_ler(0)(i - 2)(0); b := frase_ler(0)(i - 2)(1); c := frase_ler(0)(i - 2)(2); d := frase_ler(0)(i - 2)(3); e := frase_ler(0)(i - 2)(4);

                hex20 <= (a and c)                          or 
                        ((not a) and (not c) and e)         or
                        (a and (not b) and e)               or
                        ((not b) and d and e)               or
                        ((not a) and b and (not d) and e)   or
                        (b and (not c) and (not d) and (not e));

                hex21 <= (((not c) and d) and ((not e) or b))   or
                        (a and d and e)                         or
                        (((not a) and (not d)) and (c xor e))   or
                        ((not a) and (not b) and d and (not e)) or
                        ((not a) and c and (not d) and e);
                        
                hex22 <= (b and d and e)                        or
                        (a and (not c) and e)                   or
                        (a and c and d)                         or
                        ((not a) and (not b) and c and (not d)) or
                        ((not a) and (not b) and (not c) and d and (not a));

                hex23 <= ((c and e) and ((not a) or d))                         or
                        (b and c and (not d))                                   or
                        (((not a) and (not c) and (not e)) and ((not d) or b))  or
                        (a and (not b) and (not c) and (not d));

                hex24 <= (a and b)                           or
                        ((a and (not e)) and (d or (not e))) or
                        (b and (not c) and (not d) and (not e));

                hex25 <= (a and b)                           or
                        ((a and (not e)) and (d or (not e))) or
                        (b and (not c) and (not d) and (not e));

                hex26 <= (a and c and (not d))                  or
                        (c and d and (not e))                   or
                        (((not a) and (not c)) and (b xor e))   or
                        ((not a) and b and (not d) and (not e));
            end if;
            if i > 2 then 
                a := frase_ler(0)(i - 3)(0); b := frase_ler(0)(i - 3)(1); c := frase_ler(0)(i - 3)(2); d := frase_ler(0)(i - 3)(3); e := frase_ler(0)(i - 3)(4);

                hex30 <= (a and c)                          or 
                        ((not a) and (not c) and e)         or
                        (a and (not b) and e)               or
                        ((not b) and d and e)               or
                        ((not a) and b and (not d) and e)   or
                        (b and (not c) and (not d) and (not e));

                hex31 <= (((not c) and d) and ((not e) or b))   or
                        (a and d and e)                         or
                        (((not a) and (not d)) and (c xor e))   or
                        ((not a) and (not b) and d and (not e)) or
                        ((not a) and c and (not d) and e);
                        
                hex32 <= (b and d and e)                        or
                        (a and (not c) and e)                   or
                        (a and c and d)                         or
                        ((not a) and (not b) and c and (not d)) or
                        ((not a) and (not b) and (not c) and d and (not a));

                hex33 <= ((c and e) and ((not a) or d))                         or
                        (b and c and (not d))                                   or
                        (((not a) and (not c) and (not e)) and ((not d) or b))  or
                        (a and (not b) and (not c) and (not d));

                hex34 <= (a and b)                           or
                        ((a and (not e)) and (d or (not e))) or
                        (b and (not c) and (not d) and (not e));

                hex35 <= (a and b)                           or
                        ((a and (not e)) and (d or (not e))) or
                        (b and (not c) and (not d) and (not e));

                hex36 <= (a and c and (not d))                  or
                        (c and d and (not e))                   or
                        (((not a) and (not c)) and (b xor e))   or
                        ((not a) and b and (not d) and (not e));
            end if;
            i := i + 1;
            if(i = 10) then 
                i := 0;
            end if;
        end if;
    end process;
end architecture;
