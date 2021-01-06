library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Adder is
 Port ( 
     A : in STD_LOGIC;
     B : in STD_LOGIC;
     Tin : in STD_LOGIC;
     S : out STD_LOGIC;
     Tout : out STD_LOGIC);
end Adder;
 
architecture Behavioral of Adder is
 
begin
 
 S <= A XOR B XOR Tin ;
 Tout <= (A AND B) OR (A AND Tin) OR (B AND Tin) ;
 
end Behavioral;
