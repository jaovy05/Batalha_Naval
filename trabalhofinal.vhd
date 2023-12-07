library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity batalhaNaval is
  port (
    sw0, sw1, sw2, sw3, sw4, sw6, sw7, sw8, sw9, key1, key0: in std_logic;
    hex0, hex1, hex2, hex3: out std_logic_vector(6 downto 0);
    ledr9, ledr8, ledr7, ledr6, ledg0, ledg1, ledg2, ledg3, ledg4, ledg5, ledg6, ledg7, disparar: out std_logic
  ) ;
end batalhaNaval ; 

architecture batalha of batalhaNaval is
    type tipo_estado is (setBarco1, setBarco2, posbarco2, disparo, comparar);
    signal y : tipo_estado;

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

    function somar(x : std_logic_vector(3 downto 0); y_dasoma: std_logic_vector(3 downto 0)) return std_logic_vector is
        variable carry: std_logic := '0';
        variable resultado : std_logic_vector(3 downto 0);
    begin
        for i in x'range loop
            resultado(i) := (x(i) xor y_dasoma(i)) xor carry;
            carry := (x(i) and y_dasoma(i)) or ((x(i) or y_dasoma(i)) and carry);
        end loop;

        return resultado;
    end somar;

begin
    process(key1, key0)
        variable barco1, barco2_casa1, barco2_casa2, disp: std_logic_vector(3 downto 0);
        variable rodadas: std_logic_vector(3 downto 0) := "0110";
        variable acertos: std_logic_vector(2 downto 0);
    begin
        if key1 = '1' then
            y <= setBarco1;
            ledr9 <= '1';
            ledr8 <= '1';
            ledr7 <= '1';
            ledr6 <= '1';
        elsif key0'event and key0 = '0' then
            case y is
                when setBarco1 => 
                    barco1(0) := sw0;
                    barco1(1) := sw1;
                    barco1(2) := sw2;
                    barco1(3) := sw3;
                    y <= setBarco2;
                    ledr9 <= '0';
                when setBarco2 =>
                    barco2_casa1(0) := sw0;
                    barco2_casa1(1) := sw1;
                    barco2_casa1(2) := sw2;
                    barco2_casa1(3) := sw3;
                    y <= posbarco2;
                    ledr8 <= '0';     
                when posbarco2 => 
                    if sw4 = '1' then
                        barco2_casa2 := somar(barco2_casa1, "0001");
                    else 
                        barco2_casa2 := somar(barco2_casa1, "0100");
                    end if;
                    y <= disparo;
                    ledr7 <= '0';
                    disparar <= '1';
                when disparo =>
                    disp(0) := sw6;
                    disp(1) := sw7;
                    disp(2) := sw8;
                    disp(3) := sw9;
                    ledr6 <= '0';
                    y <= comparar;
                when comparar =>  
                    disp := codificar(disp);
                    if disp = barco1 then
                        ledg0 <= '1';
                        ledg1 <= '1';
                        ledg2 <= '1';
                        ledg3 <= '1';
                        acertos(0) := '1';
                    elsif disp = barco2_casa1 then
                        ledg4 <= '1';
                        ledg5 <= '1';
                        ledg6 <= '1';
                        ledg7 <= '1';
                        acertos(1) := '1';
                    elsif disp = barco2_casa2 then
                        ledg4 <= '1';
                        ledg5 <= '1';
                        ledg6 <= '1';
                        ledg7 <= '1';
                        acertos(2) := '1';
                    end if;
                    
                    rodadas := somar(rodadas, "1111");
                    y <= disparo;
                  
            end case;
        end if;
    end process;

end batalha ;