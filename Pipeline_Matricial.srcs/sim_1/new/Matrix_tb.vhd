library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity Matrix_tb is
end Matrix_tb;

architecture Behavioral of Matrix_tb is

component Matrix is
 Port (
    
    CLK : in std_logic;
    EN  : in std_logic;
    X   : in std_logic_vector(7 downto 0);
    Y   : in std_logic_vector(7 downto 0);
    
    P   : out std_logic_vector(15 downto 0)  
  );
end component Matrix;

signal CLK : std_logic := '0';
signal EN  : std_logic := '0';
signal X   : std_logic_vector(7 downto 0) := "00000000";
signal Y   : std_logic_vector(7 downto 0) := "00000000";
signal P   : std_logic_vector(15 downto 0) := "0000000000000000";                                                       

constant CLK_PERIOD : TIME := 10 ns;

begin

AUX : Matrix port map (CLK,EN,X,Y,P);

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
    
   
        for i in 0 to 5 loop
            for j in 6 to 10 loop
                
                X <= conv_std_logic_vector(i, X'length);
                Y <= conv_std_logic_vector(j, Y'length);
                Corect := conv_std_logic_vector((i*j), P'length);
                
                wait for 200 ns;
                
                if P /= Corect then
                     report "gresit" & INTEGER'image(i) & "," & INTEGER'image(j);
                     NrErr := NrErr + 1;
                end if;
                
                wait for 200 ns;
                
            end loop;
        end loop;
        
        
        for i in 100 to 110 loop
            for j in 111 to 121 loop
                
                X <= conv_std_logic_vector(i, X'length);
                Y <= conv_std_logic_vector(j, Y'length);
                Corect := conv_std_logic_vector((i*j), P'length);
                
                wait for 200 ns;
                
                if P /= Corect then
                     NrErr := NrErr + 1;
                     report "gresit" & INTEGER'image(i) & "," & INTEGER'image(j);
                end if;
                
                wait for 200 ns;
                
            end loop;
        end loop;
        
       
        for i in 252 to 255 loop
            for j in 252 to 255 loop
                
                X <= conv_std_logic_vector(i, X'length);
                Y <= conv_std_logic_vector(j, Y'length);
                Corect := conv_std_logic_vector((i*j), P'length);
                
                
                wait for 200 ns;
                
                if P /= Corect then
                     NrErr := NrErr + 1;
                     report "gresit" & INTEGER'image(i) & "," & INTEGER'image(j);             
                end if;
                
                wait for 200 ns;
                
            end loop;
        end loop;
            
    report "numar erori: " & INTEGER'image(NrErr);
    
    wait;
    end process test;


end Behavioral;
