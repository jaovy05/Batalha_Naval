library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity ent is
    port (
      clock, reset : in std_logic;
      p0, p1, p2, p3, p4, p5, p6, p7, p8, p9: in std_logic_vector(4 downto 0);
      hex00, hex01, hex02, hex03, hex04, hex05, hex06,
      hex10, hex11, hex12, hex13, hex14, hex15, hex16,
      hex20, hex21, hex22, hex23, hex24, hex25, hex26,
      hex30, hex31, hex32, hex33, hex34, hex35, hex36: out std_logic
    );
  end ent;
  
  architecture arch of ent is
    component ler is
      port (
        clock, reset : in std_logic;
        p0, p1, p2, p3, p4, p5, p6, p7, p8, p9: in std_logic_vector(4 downto 0);
        hex00, hex01, hex02, hex03, hex04, hex05, hex06,
        hex10, hex11, hex12, hex13, hex14, hex15, hex16,
        hex20, hex21, hex22, hex23, hex24, hex25, hex26,
        hex30, hex31, hex32, hex33, hex34, hex35, hex36: out std_logic
      );
    end component ler;
    signal p0i: std_logic_vector(4 downto 0);
    -- Aqui você instancia o componente e conecta diretamente as saídas
    signal hex00_i, hex01_i, hex02_i, hex03_i, hex04_i, hex05_i, hex06_i,
           hex10_i, hex11_i, hex12_i, hex13_i, hex14_i, hex15_i, hex16_i,
           hex20_i, hex21_i, hex22_i, hex23_i, hex24_i, hex25_i, hex26_i,
           hex30_i, hex31_i, hex32_i, hex33_i, hex34_i, hex35_i, hex36_i: std_logic;
  
  begin
    p0i <= "00001";
    escrever: ler
      port map (
        clock => clock,
        reset => reset,
        p0 => p0i,
        p1 => p1,
        p2 => p2,
        p3 => p3,
        p4 => p4,
        p5 => p5,
        p6 => p6,
        p7 => p7,
        p8 => p8,
        p9 => p9,
        hex00 => hex00_i,
        hex01 => hex01_i,
        hex02 => hex02_i,
        hex03 => hex03_i,
        hex04 => hex04_i,
        hex05 => hex05_i,
        hex06 => hex06_i,
        hex10 => hex10_i,
        hex11 => hex11_i,
        hex12 => hex12_i,
        hex13 => hex13_i,
        hex14 => hex14_i,
        hex15 => hex15_i,
        hex16 => hex16_i,
        hex20 => hex20_i,
        hex21 => hex21_i,
        hex22 => hex22_i,
        hex23 => hex23_i,
        hex24 => hex24_i,
        hex25 => hex25_i,
        hex26 => hex26_i,
        hex30 => hex30_i,
        hex31 => hex31_i,
        hex32 => hex32_i,
        hex33 => hex33_i,
        hex34 => hex34_i,
        hex35 => hex35_i,
        hex36 => hex36_i
      );
  
    -- Aqui você atribui as saídas do componente interno às saídas do componente principal
    hex00 <= hex00_i;
    hex01 <= hex01_i;
    hex02 <= hex02_i;
    hex03 <= hex03_i;
    hex04 <= hex04_i;
    hex05 <= hex05_i;
    hex06 <= hex06_i;
    hex10 <= hex10_i;
    hex11 <= hex11_i;
    hex12 <= hex12_i;
    hex13 <= hex13_i;
    hex14 <= hex14_i;
    hex15 <= hex15_i;
    hex16 <= hex16_i;
    hex20 <= hex20_i;
    hex21 <= hex21_i;
    hex22 <= hex22_i;
    hex23 <= hex23_i;
    hex24 <= hex24_i;
    hex25 <= hex25_i;
    hex26 <= hex26_i;
    hex30 <= hex30_i;
    hex31 <= hex31_i;
    hex32 <= hex32_i;
    hex33 <= hex33_i;
    hex34 <= hex34_i;
    hex35 <= hex35_i;
    hex36 <= hex36_i;
  end architecture;
  