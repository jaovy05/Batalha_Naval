library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity batalhaNaval is
  port (
    sw: in std_logic_vector(9 downto 0);
    key: in std_logic_vector(3 downto 0);
    hex0, hex1, hex2, hex3: out std_logic_vector(6 downto 0);
    ledr: out std_logic_vector(9 downto 0);
    ledg: out std_logic_vector(7 downto 0)
  );
end batalhaNaval ; 

architecture batalha of batalhaNaval is
    type tipo_estado is (setBarco1, setBarco2, posbarco2, disparo, ganhou, perdeu);
    signal y : tipo_estado;
    signal rodadas: std_logic_vector(3 downto 0) := "0110";
    
    function codificar(codificado : std_logic_vector(3 downto 0)) return std_logic_vector is
        variable a, b, c, d : std_logic;
        variable resultado : std_logic_vector(3 downto 0);
    begin
        a := codificado(3);
        b := codificado(2);
        c := codificado(1);
        d := codificado(0);

        resultado(3) := ((not a ) and (not b)) or (c and (a xor d)) or (a and b and (not c) and d);
        resultado(2) := ((c xor d) and (not a)) or ((b xor d) and c) or ((not a) and b and (not c));
        resultado(1) := ((not b) and c and (not d)) or ((not a) and c) or (a and (not b) and (not c)) or ((not a) and b and d);
        resultado(0) := (a and (b xor c)) or ((d xor b) and c) or (a and (not b) and d);
        return resultado;
    end codificar;

    function decodificar(decodificado : std_logic_vector(3 downto 0)) return std_logic_vector is
        variable a, b, c, d : std_logic;
        variable resultado : std_logic_vector(3 downto 0);
    begin
        a := decodificado(3);
        b := decodificado(2);
        c := decodificado(1);
        d := decodificado(0);

        resultado(3) := ((not b and (not a or d)) or (not c and d));
        resultado(2) := (((not a) and (not (b xor c))) or ((not c) and (not (a xor d))) or ((a) and (not b) and (c) and (not d)));
        resultado(1) := ((a and c) or (b and d) or ((not a) and (not b) and (not c) and (not d)));
        resultado(0) := (a xor (not(b xor (c xor d))));
        return resultado;
    end decodificar;

    function somar(x : std_logic_vector(3 downto 0); y_dasoma: std_logic_vector(3 downto 0)) return std_logic_vector is
        variable carry: std_logic := '0';
        variable resultado : std_logic_vector(3 downto 0);
    begin
        for i in 0 to 3 loop
            resultado(i) := (x(i) xor y_dasoma(i)) xor carry;
            carry := (x(i) and y_dasoma(i)) or ((x(i) or y_dasoma(i)) and carry);
        end loop;

        return resultado;
    end somar;

begin
    process(key(1), key(0))
        variable barco1, barco2_casa1, barco2_casa2, disp: std_logic_vector(3 downto 0);
        variable acertos: std_logic_vector(2 downto 0) := "000";
    begin
        if key(1) = '0' then
            y <= setBarco1;
            ledr(9) <= '1';
            ledr(8) <= '1';
            ledr(7) <= '1';
            ledr(6) <= '1';
            for i in ledg'range loop
                ledg(i) <= '0';
            end loop;
            for i in 5 downto 0 loop
                ledr(i) <= '0';
            end loop;
            hex3 <= "1111111";
            hex2 <= "1111111";
            hex1 <= "1111111";
        elsif key(0)'event and key(0) = '0' then
            case y is
                when setBarco1 => 
                    barco1(0) := sw(0);
                    barco1(1) := sw(1);
                    barco1(2) := sw(2);
                    barco1(3) := sw(3);
                    y <= setBarco2;
                    ledr(9) <= '0';
                when setBarco2 =>
                    ledr(9) <= '1'; 
                    barco2_casa1(0) := sw(0);
                    barco2_casa1(1) := sw(1);
                    barco2_casa1(2) := sw(2);
                    barco2_casa1(3) := sw(3);
                    if barco1 /= barco2_casa1 then
                        y <= posbarco2;
                        ledr(8) <= '0'; 
                    end if;
                    when posbarco2 => 
                    ledr(9) <= '0';
                    if sw(4) = '1' then
                        barco2_casa2 := codificar(somar(decodificar(barco2_casa1), "0001"));
                        if barco2_casa1 /= barco2_casa2 then
                            barco2_casa2 := codificar(somar(decodificar(barco2_casa1), "0100"));
                        end if;
                    else 
                        barco2_casa2 := codificar(somar(decodificar(barco2_casa1), "0100"));
                        if barco2_casa1 /= barco2_casa2 then
                            barco2_casa2 := codificar(somar(decodificar(barco2_casa1), "0001"));
                        end if;
                    end if;
                    y <= disparo;
                    ledr(7) <= '0';
                when disparo =>
                    for i in ledg'range loop
                        ledg(i) <= '0';
                    end loop;
                    disp(0) := sw(6);
                    disp(1) := sw(7);
                    disp(2) := sw(8);
                    disp(3) := sw(9);
                    ledr(6) <= '0';
                    disp := codificar(disp);
                    if disp = barco1 then
                        ledg(0) <= '1';
                        ledg(1) <= '1';
                        ledg(2) <= '1';
                        ledg(3) <= '1';
                        acertos(0) := '1';
                    elsif disp = barco2_casa1 then
                        ledg(4) <= '1';
                        ledg(5) <= '1';
                        ledg(6) <= '1';
                        ledg(7) <= '1';
                        acertos(1) := '1';
                    elsif disp = barco2_casa2 then
                        ledg(4) <= '1';
                        ledg(5) <= '1';
                        ledg(6) <= '1';
                        ledg(7) <= '1';
                        acertos(2) := '1';
                    end if;    
                    rodadas <= somar(rodadas, "1111");
                    y <= disparo;
                when ganhou =>
                    for i in ledg'range loop
                        ledg(i) <= '1';
                    end loop;
                when perdeu =>
                    for i in ledr'range loop
                        ledr(i) <= '1';
                    end loop;
            end case;
        end if;
    end process;
    process(rodadas)
    begin
        case rodadas is
            when "0110" =>
                hex0 <= "0000010";
            when "0101" =>
                hex0 <= "0010010";
            when "0100" =>
                hex0 <= "0011001";
            when "0011" =>
                hex0 <= "0110000";
            when "0010" =>
                hex0 <= "0100100";
            when "0001" =>
                hex0 <= "1111001";
            when "0000" =>
                hex0 <= "1000000";
            when others =>

        end case;
       -- if rodadas = "0000" then
            --if acertos = "111" then
              --  y <= ganhou;
            --else
              --  y <= perdeu;
            --end if;
       -- end if; 
    end process;

    

end batalha ;

