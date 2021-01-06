library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity Wallace_tb is
end Wallace_tb;

architecture Behavioral of Wallace_tb is

component Wallace is
  Port (
        Clk: in std_logic;
        EN : in std_logic;
        X: in std_logic_vector(7 downto 0);
        Y: in std_logic_vector(7 downto 0);
        
        P: out std_logic_vector(15 downto 0)
   );
end component;

signal  CLK :  std_logic:= '0';
signal  EN  :  std_logic:= '0';
signal  ovf  :  std_logic:= '0';
signal  X   :  std_logic_vector(7 downto 0) := "00000000";
signal  Y   :  std_logic_vector(7 downto 0) := "00000000";
signal  P   : std_logic_vector(15 downto 0) := "0000000000000000";

constant CLK_PERIOD : TIME := 10 ns;

begin

AUX : Wallace port map (CLK,EN,X,Y,P);

gen_clk: process
begin
    CLK <= '0';
    wait for (CLK_PERIOD/2);
    CLK <= '1';
    wait for (CLK_PERIOD/2);
end process gen_clk;


test: process

    variable Corect: std_logic_vector(15 downto 0);
    variable NrErr : INTEGER := 0;
     
begin

        EN <= '0';
        wait for 100 ns;
        EN <= '1';
        wait for 100 ns;

    for i in 0 to 15 loop
            for j in 0 to 15 loop
                
                X <= conv_std_logic_vector(i, X'length);
                Y <= conv_std_logic_vector(j, Y'length);
                Corect := conv_std_logic_vector((i*j), P'length);
                
 
                if P /= Corect then
                     report "gresit" & INTEGER'image(i) & "," & INTEGER'image(j);
                     NrErr := NrErr + 1;
                end if;
                
                wait for 100 ns;
                
            end loop;
        end loop;
        
        
    for i in 100 to 110 loop
            for j in 111 to 121 loop
                
                X <= conv_std_logic_vector(i, X'length);
                Y <= conv_std_logic_vector(j, Y'length);
                Corect := conv_std_logic_vector((i*j), P'length);
                
                
                if P /= Corect then
                     NrErr := NrErr + 1;
                     report "gresit" & INTEGER'image(i) & "," & INTEGER'image(j);
                end if;
                
                wait for 100 ns;
                
            end loop;
        end loop;
        
        
    for i in 253 to 255 loop
            for j in 252 to 255 loop
                
                X <= conv_std_logic_vector(i, X'length);
                Y <= conv_std_logic_vector(j, Y'length);
                Corect := conv_std_logic_vector((i*j), P'length);
                
 
                if P /= Corect then
                     report "gresit" & INTEGER'image(i) & "," & INTEGER'image(j);
                     NrErr := NrErr + 1;
                end if;
                
                wait for 100 ns;
                
            end loop;
        end loop;
      
    report "numar erori: " & INTEGER'image(NrErr);
    
wait;
end process test;


end Behavioral;

