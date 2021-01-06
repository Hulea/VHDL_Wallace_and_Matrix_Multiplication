library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity M is
  Port ( 
  
  X  : in std_logic;
  Y  : in std_logic;
  A  : in std_logic;
  Tin: in std_logic;
  
  S   : out std_logic;
  Tout: out std_logic 
  );
end M;

architecture Behavioral of M is

begin

    S    <= A xor (X and Y) xor Tin;
    
    Tout <= (A and (X and Y)) or ((A or (X and Y)) and Tin);

end Behavioral;
