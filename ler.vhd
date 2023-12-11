library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity impressora is
  port (
    clock : in std_logic; 
    sw4, sw3, sw2, sw1, sw0 : in std_logic;
    mudarLetra, mudarPos, reset,gravar: in std_logic;
    hex00, hex01, hex02, hex03, hex04, hex05, hex06,
    hex10, hex11, hex12, hex13, hex14, hex15, hex16,
    hex20, hex21, hex22, hex23, hex24, hex25, hex26,
    hex30, hex31, hex32, hex33, hex34, hex35, hex36: out std_logic
  ) ;
end impressora;

architecture arch of impressora is
    type palavra is array(0 to 7) of std_logic_vector(4 downto 0);

    function somar(x : std_logic_vector(4 downto 0); y_dasoma: std_logic_vector(4 downto 0)) return std_logic_vector is
        variable carry: std_logic := '0';
        variable resultado : std_logic_vector(4 downto 0);
    begin
        for i in 0 to 4 loop
            resultado(i) := (x(i) xor y_dasoma(i)) xor carry;
            carry := (x(i) and y_dasoma(i)) or ((x(i) or y_dasoma(i)) and carry);
        end loop;

        return resultado;
    end somar;
begin

    process(clock, reset, mudarLetra, mudarPos, gravar)
        variable nome: palavra;
        variable i, qtdLetras: natural := 0;
    
        variable a, b, c, d, e : std_logic;
        variable escrever : std_logic := '1';
    begin
        if escrever = '1' then
            if(reset = '1') then
                nome := ("00000", "00000", "00000", "00000", "00000", "00000", "00000", "00000");
                i := 0;
                hex00 <= '1'; hex01 <= '1'; hex02 <= '1'; hex03 <= '1'; hex04 <= '1'; hex05 <= '1'; hex06 <= '1';
                hex10 <= '1'; hex11 <= '1'; hex12 <= '1'; hex13 <= '1'; hex14 <= '1'; hex15 <= '1'; hex16 <= '1';
                hex20 <= '1'; hex21 <= '1'; hex22 <= '1'; hex23 <= '1'; hex24 <= '1'; hex25 <= '1'; hex26 <= '1';
                hex30 <= '1'; hex31 <= '1'; hex32 <= '1'; hex33 <= '1'; hex34 <= '1'; hex35 <= '1'; hex36 <= '1';
                qtdLetras := 0;
                
            elsif(mudarLetra = '1') then
                nome(i) := somar(nome(i), "00001");
            
            elsif mudarPos = '1' then
                if(i = 3) then 
                    hex00 <= '1'; hex01 <= '1'; hex02 <= '1'; hex03 <= '1'; hex04 <= '1'; hex05 <= '1'; hex06 <= '1';
                    hex10 <= '1'; hex11 <= '1'; hex12 <= '1'; hex13 <= '1'; hex14 <= '1'; hex15 <= '1'; hex16 <= '1';
                    hex20 <= '1'; hex21 <= '1'; hex22 <= '1'; hex23 <= '1'; hex24 <= '1'; hex25 <= '1'; hex26 <= '1';
                    hex30 <= '1'; hex31 <= '1'; hex32 <= '1'; hex33 <= '1'; hex34 <= '1'; hex35 <= '1'; hex36 <= '1';
                elsif i = 7 then
                    for j in 7 downto 0 loop
                        if nome(j) /= "00000" then
                            qtdletras := qtdletras + 1;
                        end if;
                    end loop;
                escrever := '0';
                end if;                
                i := i + 1;

            elsif gravar = '1' then
                for j in 7 downto 0 loop
                    if nome(j) /= "00000" then
                        qtdletras := qtdletras + 1;
                    end if;
                end loop;
                escrever := '0';

            elsif(clock'event and clock = '1') then

                a := nome(i)(4);
                b := nome(i)(3);
                c := nome(i)(2);
                d := nome(i)(1);
                e := nome(i)(0);

                if i = 0 then 
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

                elsif i = 1 then
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

                elsif i = 2 then
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

                elsif i = 3 then
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
                            ((a and (not e)) and (d or (not c))) or
                            (b and (not c) and (not d) and (not e));

                    hex35 <= (a and b)                           or
                            ((a and (not e)) and (d or (not e))) or
                            (b and (not c) and (not d) and (not e));

                    hex36 <= (a and c and (not d))                  or
                            (c and d and (not e))                   or
                            (((not a) and (not c)) and (b xor e))   or
                            ((not a) and b and (not d) and (not e));

                elsif i = 4 then 
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

                elsif i = 5 then
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

                elsif i = 6 then
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

                elsif i = 7 then
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
                            ((a and (not e)) and (d or (not c))) or
                            (b and (not c) and (not d) and (not e));

                    hex35 <= (a and b)                           or
                            ((a and (not e)) and (d or (not e))) or
                            (b and (not c) and (not d) and (not e));

                    hex36 <= (a and c and (not d))                  or
                            (c and d and (not e))                   or
                            (((not a) and (not c)) and (b xor e))   or
                            ((not a) and b and (not d) and (not e));
                end if;  
            end if;
        end if;

    end process;
end architecture;
