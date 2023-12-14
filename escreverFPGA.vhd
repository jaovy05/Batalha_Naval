library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ler is
    port (
        key: in std_logic_vector(4 downto 0);
        sw: in std_logic_vector(9 downto 0);
        hex0, hex1, hex2, hex3: out std_logic_vector(6 downto 0)
    );
end ler;

architecture arch of ler is
    type palavra is array(9 downto 0) of std_logic_vector(4 downto 0);
    type frase is array(5 downto 0) of palavra;
    
    signal frase_ler: frase;

    function codificarAlfa(codificado : std_logic_vector(4 downto 0)) return std_logic_vector is
        variable a, b, c, d, e: std_logic;
        variable resultado : std_logic_vector(6 downto 0);
    begin
        a := codificado(4);
        b := codificado(3);
        c := codificado(2);
        d := codificado(1);
        e := codificado(0);
        
        
        
        resultado(6) := (c and ((d and e) or (b and (not d))))                  or
                        ((a and c) and (e or d))                                or
                        (((not a) and e) and (b xor d))                         or
                        (((not a) and (not c) and (not e)) and (b xor d));

        resultado(5) := (b and d and (not e))                                   or
                        ((not a) and (not b) and (not d) and (not e))           or
                        (a and (not c) and d and (not e))                       or
                        (a and c and (not d) and e)                             or
                        ((not a) and b and (not c) and (not d) and e) ;

        resultado(4) := ((a and e) and ((not c) or d))                          or
                        (a and b and d)                                         or
                        (b and (not c) and (not d) and e)                       or
                        ((not a) and (not b) and (not c) and (not d) and (not e));

        resultado(3) := ((a and e) and (d or (not c)))                          or
                        (a and b and d)                                         or
                        (b and (not c) and (not d) and e)                       or
                        ((not a) and (not b) and (not c) and (not d) and (not e));
        
        resultado(2) := (((not d) and (not c)) and ((not e) or (not b)))        or
                        ((not a) and c and d and (not e))                       or
                        ((not a) and b and (not d) and e)                       or
                        (a and (not b) and (not c) and (not e));
        
        resultado(1) := (((not b) and d) and (a or (not c)))                    or
                        (b and c and (not e))                                   or
                        (a and c and (not d))                                   or
                        ((not a) and (not c) and (not d) and (not e))           or
                        ((not a) and (not b) and c and e); 

        resultado(0) := (a and c)                                               or
                        ((not a) and (not d) and (not e))                       or
                        (b and (not c) and (not d))                             or
                        (((not a) and b) and (c or (not e)))                    or
                        ((not b) and (not c) and (d) and (not e));

        return resultado;
    end codificarAlfa;

begin
    process(sw(0), sw(1))
        variable a, b, c, d, e,
                a1, b1, c1, d1, e1: std_logic;
        variable i : natural := 0;
    begin
        if sw(1) = '0' then
            i := 0;
            hex0 <= "1111111";

            frase_ler(0)(0) <= "00001";
            frase_ler(0)(1) <= "00010"; 
            frase_ler(0)(2) <= "00011"; 
            frase_ler(0)(3) <= "00100"; 
            frase_ler(0)(4) <= "01000"; 
            frase_ler(0)(5) <= "01001"; 
            frase_ler(0)(6) <= "01010"; 
            frase_ler(0)(7) <= "01011"; 
            frase_ler(0)(8) <= "01100"; 
            frase_ler(0)(9) <= "01101"; 

        elsif sw(0)'event and sw(0) = '0' then
            a := frase_ler(0)(i)(0); b := frase_ler(0)(i)(1); c := frase_ler(0)(i)(2); d := frase_ler(0)(i)(3); e := frase_ler(0)(i)(4);       

            hex0(0) <= (a and c)                          or 
                    ((not a) and (not c) and e)         or
                    (a and (not b) and e)               or
                    ((not b) and d and e)               or
                    ((not a) and b and (not d) and e)   or
                    (b and (not c) and (not d) and (not e));

            hex0(1) <= (((not c) and d) and ((not e) or b))   or
                    (a and d and e)                         or
                    (((not a) and (not d)) and (c xor e))   or
                    ((not a) and (not b) and d and (not e)) or
                    ((not a) and c and (not d) and e);
                    
            hex0(2) <= (b and d and e)                        or
                    (a and (not c) and e)                   or
                    (a and c and d)                         or
                    ((not a) and (not b) and c and (not d)) or
                    ((not a) and (not b) and (not c) and d and (not a));

            hex0(3) <= ((c and e) and ((not a) or d))                         or
                    (b and c and (not d))                                   or
                    (((not a) and (not c) and (not e)) and ((not d) or b))  or
                    (a and (not b) and (not c) and (not d));

            hex0(4) <= (a and b)                           or
                    ((a and (not e)) and (d or (not e))) or
                    (b and (not c) and (not d) and (not e));

            hex0(5) <= (a and b)                           or
                    ((a and (not e)) and (d or (not e))) or
                    (b and (not c) and (not d) and (not e));

            hex0(6) <= (a and c and (not d))                  or
                    (c and d and (not e))                   or
                    (((not a) and (not c)) and (b xor e))   or
                    ((not a) and b and (not d) and (not e));  

            if i > 0 then 
                a := frase_ler(0)(i - 1)(0); b := frase_ler(0)(i - 1)(1); c := frase_ler(0)(i - 1)(2); d := frase_ler(0)(i - 1)(3); e := frase_ler(0)(i - 1)(4);

                hex1(0) <= (a and c)                          or 
                        ((not a) and (not c) and e)         or
                        (a and (not b) and e)               or
                        ((not b) and d and e)               or
                        ((not a) and b and (not d) and e)   or
                        (b and (not c) and (not d) and (not e));

                hex1(1) <= (((not c) and d) and ((not e) or b))   or
                        (a and d and e)                         or
                        (((not a) and (not d)) and (c xor e))   or
                        ((not a) and (not b) and d and (not e)) or
                        ((not a) and c and (not d) and e);
                        
                hex1(2) <= (b and d and e)                        or
                        (a and (not c) and e)                   or
                        (a and c and d)                         or
                        ((not a) and (not b) and c and (not d)) or
                        ((not a) and (not b) and (not c) and d and (not a));

                hex1(3) <= ((c and e) and ((not a) or d))                         or
                        (b and c and (not d))                                   or
                        (((not a) and (not c) and (not e)) and ((not d) or b))  or
                        (a and (not b) and (not c) and (not d));

                hex1(4) <= (a and b)                           or
                        ((a and (not e)) and (d or (not e))) or
                        (b and (not c) and (not d) and (not e));

                hex1(5) <= (a and b)                           or
                        ((a and (not e)) and (d or (not e))) or
                        (b and (not c) and (not d) and (not e));

                hex1(6) <= (a and c and (not d))                  or
                        (c and d and (not e))                   or
                        (((not a) and (not c)) and (b xor e))   or
                        ((not a) and b and (not d) and (not e));
            end if;
            if i > 1 then 
                a := frase_ler(0)(i - 2)(0); b := frase_ler(0)(i - 2)(1); c := frase_ler(0)(i - 2)(2); d := frase_ler(0)(i - 2)(3); e := frase_ler(0)(i - 2)(4);

                hex2(0) <= (a and c)                          or 
                        ((not a) and (not c) and e)         or
                        (a and (not b) and e)               or
                        ((not b) and d and e)               or
                        ((not a) and b and (not d) and e)   or
                        (b and (not c) and (not d) and (not e));

                hex2(1) <= (((not c) and d) and ((not e) or b))   or
                        (a and d and e)                         or
                        (((not a) and (not d)) and (c xor e))   or
                        ((not a) and (not b) and d and (not e)) or
                        ((not a) and c and (not d) and e);
                        
                hex2(2) <= (b and d and e)                        or
                        (a and (not c) and e)                   or
                        (a and c and d)                         or
                        ((not a) and (not b) and c and (not d)) or
                        ((not a) and (not b) and (not c) and d and (not a));

                hex2(3) <= ((c and e) and ((not a) or d))                         or
                        (b and c and (not d))                                   or
                        (((not a) and (not c) and (not e)) and ((not d) or b))  or
                        (a and (not b) and (not c) and (not d));

                hex2(4) <= (a and b)                           or
                        ((a and (not e)) and (d or (not e))) or
                        (b and (not c) and (not d) and (not e));

                hex2(5) <= (a and b)                           or
                        ((a and (not e)) and (d or (not e))) or
                        (b and (not c) and (not d) and (not e));

                hex2(6) <= (a and c and (not d))                  or
                        (c and d and (not e))                   or
                        (((not a) and (not c)) and (b xor e))   or
                        ((not a) and b and (not d) and (not e));
            end if;
            if i > 2 then 
                a := frase_ler(0)(i - 3)(0); b := frase_ler(0)(i - 3)(1); c := frase_ler(0)(i - 3)(2); d := frase_ler(0)(i - 3)(3); e := frase_ler(0)(i - 3)(4);

                hex3(0) <= (a and c)                          or 
                        ((not a) and (not c) and e)         or
                        (a and (not b) and e)               or
                        ((not b) and d and e)               or
                        ((not a) and b and (not d) and e)   or
                        (b and (not c) and (not d) and (not e));

                hex3(1) <= (((not c) and d) and ((not e) or b))   or
                        (a and d and e)                         or
                        (((not a) and (not d)) and (c xor e))   or
                        ((not a) and (not b) and d and (not e)) or
                        ((not a) and c and (not d) and e);
                        
                hex3(2) <= (b and d and e)                        or
                        (a and (not c) and e)                   or
                        (a and c and d)                         or
                        ((not a) and (not b) and c and (not d)) or
                        ((not a) and (not b) and (not c) and d and (not a));

                hex3(3) <= ((c and e) and ((not a) or d))                         or
                        (b and c and (not d))                                   or
                        (((not a) and (not c) and (not e)) and ((not d) or b))  or
                        (a and (not b) and (not c) and (not d));

                hex3(4) <= (a and b)                           or
                        ((a and (not e)) and (d or (not e))) or
                        (b and (not c) and (not d) and (not e));

                hex3(5) <= (a and b)                           or
                        ((a and (not e)) and (d or (not e))) or
                        (b and (not c) and (not d) and (not e));

                hex3(6) <= (a and c and (not d))                  or
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