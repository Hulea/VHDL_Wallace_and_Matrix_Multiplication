library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Main is
  Port ( 
  CLK: in std_logic;
  RST : in std_logic;
  EN : in std_logic;
  X : in std_logic_vector(7 downto 0);
  Y : in std_logic_vector(7 downto 0);
  An   : out STD_LOGIC_VECTOR (7 downto 0); 
  Seg  : out STD_LOGIC_VECTOR (7 downto 0)
  );
end Main;

architecture Behavioral of Main is

component Matrix is
generic(n:natural := 8);
 Port (
    
    CLK : in std_logic;
    EN  : in std_logic;
    X   : in std_logic_vector(n-1 downto 0);
    Y   : in std_logic_vector(n-1 downto 0);
    
    P   : out std_logic_vector(2*n-1 downto 0)  
  );
end component Matrix;


component debounce is
    Port ( Clk : in STD_LOGIC;
           Rst : in STD_LOGIC;
           Din : in STD_LOGIC;
           Qout : out STD_LOGIC);
end component debounce;


component displ7seg is
   Port ( Clk  : in  STD_LOGIC;
          Rst  : in  STD_LOGIC;
          Data : in  STD_LOGIC_VECTOR (31 downto 0); 
                 -- date de afisat (cifra 1 din stanga: biti 63..56)
          An   : out STD_LOGIC_VECTOR (7 downto 0); 
                 -- semnale pentru anozi (active in 0 logic)
          Seg  : out STD_LOGIC_VECTOR (7 downto 0)); 
                 -- semnale pentru segmentele (catozii) cifrei active
end component displ7seg;


signal EN_aux : std_logic;
signal P : std_logic_vector(15 downto 0);
signal Data : std_logic_vector(31 downto 0);

begin

Data <= X & Y & P;

debouncer: debounce port map(CLK,RST,EN,EN_aux);
AUX : Matrix port map(CLK, EN_aux, X, Y, P);
displ: displ7seg port map(CLK,RST,Data,An,Seg);



end Behavioral;
