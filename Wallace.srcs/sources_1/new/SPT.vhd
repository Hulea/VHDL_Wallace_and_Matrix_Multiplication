library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SPT is
generic (n : INTEGER);
 Port(
    X  : in std_logic_vector(n-1 downto 0);
    Y  : in std_logic_vector(n-1 downto 0);
    Tin: in std_logic;
    
    S   : out std_logic_vector(n-1 downto 0);
    Tout: out std_logic
    );
end SPT;

architecture Behavioral of SPT is
begin

    process(X, Y, Tin)
    variable AUX : std_logic_vector(n downto 0);
    begin
    
        AUX(0) := Tin;
        
        for i in 0 to n-1 loop
            S(i) <= X(i) xor Y(i) xor AUX(i);
            AUX(i+1) := (X(i) and Y(i)) or (X(i) and AUX(i)) or (Y(i) and AUX(i));
        end loop;
        
        Tout <= AUX(n);
        
    end process;

end Behavioral;
