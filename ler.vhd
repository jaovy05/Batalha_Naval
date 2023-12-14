library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ler is
  port (
    clock : in std_logic; 
    sw4, sw3, sw2, sw1, sw0 : in std_logic;
    mudarLetra, mudarPos, reset,gravar: in std_logic;
    hex00, hex01, hex02, hex03, hex04, hex05, hex06,
    hex10, hex11, hex12, hex13, hex14, hex15, hex16,
    hex20, hex21, hex22, hex23, hex24, hex25, hex26,
    hex30, hex31, hex32, hex33, hex34, hex35, hex36: out std_logic
  ) ;
end ler;

architecture arch of ler is
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

    process(clock, reset, mudarLetra, mudarPos, gravar)
        variable nome: palavra;
        variable i: natural := 0;
    
        variable temp : std_logic_vector(6 downto 0);
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
                if nome(i) = "11011" then
                        nome(i) := "00000";
                end if;

            elsif mudarPos = '1' then
                if(i = 3) then 
                    hex00 <= '1'; hex01 <= '1'; hex02 <= '1'; hex03 <= '1'; hex04 <= '1'; hex05 <= '1'; hex06 <= '1';
                    hex10 <= '1'; hex11 <= '1'; hex12 <= '1'; hex13 <= '1'; hex14 <= '1'; hex15 <= '1'; hex16 <= '1';
                    hex20 <= '1'; hex21 <= '1'; hex22 <= '1'; hex23 <= '1'; hex24 <= '1'; hex25 <= '1'; hex26 <= '1';
                    hex30 <= '1'; hex31 <= '1'; hex32 <= '1'; hex33 <= '1'; hex34 <= '1'; hex35 <= '1'; hex36 <= '1';
                elsif i = 7 then
                    for j in 7 downto 0 loop
                        if nome(j) = "00000" then
                                nome(j) = "11111";
                        end if;
                    end loop;
                escrever := '0';
                end if;                
                i := i + 1;

            elsif gravar = '1' then
                for j in 7 downto 0 loop
                    if nome(j) = "00000" then
                        nome(j) = "11111";
                    end if;
                end loop;
                escrever := '0';

            elsif(clock'event and clock = '1') then

                temp := codificarAlfa(nome(i));

                if i = 0 then 
                    hex00 <= temp(0);
                    hex01 <= temp(1);        
                    hex02 <= temp(2);
                    hex03 <= temp(3);
                    hex04 <= temp(4);
                    hex05 <= temp(5);
                    hex06 <= temp(6);

                elsif i = 1 then
                        hex10 <= temp(0);
                        hex11 <= temp(1);        
                        hex12 <= temp(2);
                        hex13 <= temp(3);
                        hex14 <= temp(4);
                        hex15 <= temp(5);
                        hex16 <= temp(6);

                elsif i = 2 then
                        hex20 <= temp(0);
                        hex21 <= temp(1);        
                        hex22 <= temp(2);
                        hex23 <= temp(3);
                        hex24 <= temp(4);
                        hex25 <= temp(5);
                        hex26 <= temp(6);

                elsif i = 3 then
                        hex30 <= temp(0);
                        hex31 <= temp(1);        
                        hex32 <= temp(2);
                        hex33 <= temp(3);
                        hex34 <= temp(4);
                        hex35 <= temp(5);
                        hex36 <= temp(6);

                elsif i = 4 then 
                        hex00 <= temp(0);
                        hex01 <= temp(1);        
                        hex02 <= temp(2);
                        hex03 <= temp(3);
                        hex04 <= temp(4);
                        hex05 <= temp(5);
                        hex06 <= temp(6);

                elsif i = 5 then
                        hex10 <= temp(0);
                        hex11 <= temp(1);        
                        hex12 <= temp(2);
                        hex13 <= temp(3);
                        hex14 <= temp(4);
                        hex15 <= temp(5);
                        hex16 <= temp(6);

                elsif i = 6 then
                        hex20 <= temp(0);
                        hex21 <= temp(1);        
                        hex22 <= temp(2);
                        hex23 <= temp(3);
                        hex24 <= temp(4);
                        hex25 <= temp(5);
                        hex26 <= temp(6);


                elsif i = 7 then
                        hex30 <= temp(0);
                        hex31 <= temp(1);        
                        hex32 <= temp(2);
                        hex33 <= temp(3);
                        hex34 <= temp(4);
                        hex35 <= temp(5);
                        hex36 <= temp(6);
                end if;  
            end if;
        end if;

    end process;
end architecture;
