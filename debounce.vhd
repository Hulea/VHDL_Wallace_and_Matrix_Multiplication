
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity debounce is
    Port ( Clk : in STD_LOGIC;
           Rst : in STD_LOGIC;
           Din : in STD_LOGIC;
           Qout : out STD_LOGIC);
end debounce;

architecture Behavioral of debounce is
signal Q1, Q2, Q3 : std_logic;
begin


process(Clk)
begin
   if (Clk'event and Clk = '1') then
      if (Rst = '1') then
         Q1 <= '0';
         Q2 <= '0';
         Q3 <= '0';
      else
         Q1 <= Din;
         Q2 <= Q1;
         Q3 <= Q2;
      end if;
   end if;
end process;

Qout <= Q1 and Q2 and (not Q3);

end Behavioral;
