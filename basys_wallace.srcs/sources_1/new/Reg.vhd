library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Reg is
generic (n : INTEGER);
  Port (
  
  CLK : in std_logic;
  EN  : in std_logic;
  D  : in std_logic_vector(n-1 downto 0);
  Q : out std_logic_vector(n-1 downto 0)
  
  );
end Reg;

architecture Behavioral of Reg is
begin

    process(CLK)
    begin
        if rising_edge(CLK) then
             if EN = '1' then
                Q <= D;
            end if;
        end if;
    end process;
    
end Behavioral;
