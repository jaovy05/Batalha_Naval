library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity escrever is
    port (
        clock, reset : in std_logic;
        p0, p1, p2, p3, p4, p5, p6, p7, p8, p9: in  std_logic_vector(4 downto 0);
        hex00, hex01, hex02, hex03, hex04, hex05, hex06,
        hex10, hex11, hex12, hex13, hex14, hex15, hex16,
        hex20, hex21, hex22, hex23, hex24, hex25, hex26,
        hex30, hex31, hex32, hex33, hex34, hex35, hex36: out std_logic
    );
end escrever;

architecture arch of escrever is
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
                        (((not a) and (not c) and (not e)) and (b xnor d));

        resultado(5) := (b and d and (not e))                                   or
                        ((not a) and (not b) and (not d) and (not e))           or
                        (a and (not c) and d and (not e))                       or
                        (a and c and (not d) and e)                             or
                        ((not a) and b and (not c) and (not d) and e) ;

        resultado(4) := ((a and e) and ((not c) or d))                          or
                        (a and b and d)                                         or
                        (b and (not c) and (not d) and e)                       or
                        ((not a) and (not b) and (not c) and (not d) and (not e));

        resultado(3) := (((not c) and (not d)) and ((not b) or (not e)))        or
                        ((not a) and c and d and (not e))                       or
                        ((not a) and b and (not d) and e)                       or
                        (a and (not b) and (not c) and (not e));
        
        resultado(2) := ((a and c) and (d xnor e))                              or
                        (((not c) and d) and (a xor e))                         or
                        (((not d) and (not e)) and (b xnor c))                  or
                        (((not a) and (not b) and c) and (d xor e));

        resultado(1) := (((not b) and d) and ((not a) or (not c)))              or
                        (b and c and (not e))                                   or
                        (a and c and (not d))                                   or
                        ((not a) and (not c) and (not d) and (not e))           or
                        ((not a) and (not b) and c and e); 

        resultado(0) := (a and c)                                               or
                        ((not a) and (not d) and (not e))                       or
                        (b and (not c) and (not d))                             or
                        (((not a) and b) and ((not c) or (not e)))              or
                        ((not b) and (not c) and (d) and (not e));

        return resultado;
    end codificarAlfa;

begin
    process(clock, reset)
        variable a, b, c, d, e,
                a1, b1, c1, d1, e1: std_logic;
        variable i, j : natural := 0;
        variable temp: std_logic_vector(6 downto 0);
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
            frase_ler(1)(0) <= "11111";
            frase_ler(1)(1) <= "01100"; 
            frase_ler(1)(2) <= "01101"; 
            frase_ler(1)(3) <= "01110"; 
            frase_ler(1)(4) <= "01111"; 
            frase_ler(1)(5) <= "10000"; 
            frase_ler(1)(6) <= "10001"; 
            frase_ler(1)(7) <= "10010"; 
            frase_ler(1)(8) <= "10011"; 
            frase_ler(1)(9) <= "10100";
            frase_ler(2)(0) <= "10101";
            frase_ler(2)(1) <= "10110"; 
            frase_ler(2)(2) <= "10111"; 
            frase_ler(2)(3) <= "11000"; 
            frase_ler(2)(4) <= "11001"; 
            frase_ler(2)(5) <= "11010"; 
            frase_ler(2)(6) <= "00001"; 
            frase_ler(2)(7) <= "00010"; 
            frase_ler(2)(8) <= "00011"; 
            frase_ler(2)(9) <= "00100";

        elsif clock'event and clock = '0' then
                --a := frase_ler(0)(i)(0); b := frase_ler(0)(i)(1); c := frase_ler(0)(i)(2); d := frase_ler(0)(i)(3); e := frase_ler(0)(i)(4);       
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
            if frase_ler(j)(i) /= "11111" then
                temp := codificarAlfa(frase_ler(j)(i));

                hex00 <= temp(0);
                hex01 <= temp(1);                   
                hex02 <= temp(2);
                hex03 <= temp(3);
                hex04 <= temp(4);
                hex05 <= temp(5);
                hex06 <= temp(6);  

                if i > 0 then 
                        temp := codificarAlfa(frase_ler(j)(i - 1));

                        hex10 <= temp(0);
                        hex11 <= temp(1);          
                        hex12 <= temp(2);
                        hex13 <= temp(3);
                        hex14 <= temp(4);
                        hex15 <= temp(5);
                        hex16 <= temp(6);  

                end if;
                if i > 1 then 
                        --a := frase_ler(0)(i - 2)(0); b := frase_ler(0)(i - 2)(1); c := frase_ler(0)(i - 2)(2); d := frase_ler(0)(i - 2)(3); e := frase_ler(0)(i - 2)(4);

                        temp := codificarAlfa(frase_ler(j)(i - 2));

                        hex20 <= temp(0);
                        hex21 <= temp(1);          
                        hex22 <= temp(2);
                        hex23 <= temp(3);
                        hex24 <= temp(4);
                        hex25 <= temp(5);
                        hex26 <= temp(6);  

                end if;
                if i > 2 then 
                        --a := frase_ler(0)(i - 3)(0); b := frase_ler(0)(i - 3)(1); c := frase_ler(0)(i - 3)(2); d := frase_ler(0)(i - 3)(3); e := frase_ler(0)(i - 3)(4);

                        temp := codificarAlfa(frase_ler(j)(i - 3));

                        hex30 <= temp(0);
                        hex31 <= temp(1);          
                        hex32 <= temp(2);
                        hex33 <= temp(3);
                        hex34 <= temp(4);
                        hex35 <= temp(5);
                        hex36 <= temp(6);

                end if;

                i := i + 1;
                if(i = 10) then 
                        i := 0;
                        j := j + 1;
                        if j = 3 then
                                j := 0;
                        end if;
                end if;
            end if;
        end if;
    end process;
end architecture;
