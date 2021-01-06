library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Main is
  Port ( 
  CLK: in std_logic;
  RST : in std_logic;
  EN : in std_logic;
  X : in std_logic_vector(7 downto 0);
  Y : in std_logic_vector(7 downto 0);
  An   : out STD_LOGIC_VECTOR (3 downto 0); 
  Seg  : out STD_LOGIC_VECTOR (6 downto 0)
  );
end Main;

architecture Behavioral of Main is

component Wallace is
 Port (
    
    CLK : in std_logic;
    EN  : in std_logic;
    X   : in std_logic_vector(7 downto 0);
    Y   : in std_logic_vector(7 downto 0);
    
    P   : out std_logic_vector(15 downto 0)  
  );
end component Wallace;


component debounce is
    Port ( Clk : in STD_LOGIC;
           Rst : in STD_LOGIC;
           Din : in STD_LOGIC;
           Qout : out STD_LOGIC);
end component debounce;


component displ7seg is
 Port (
         Clk  : in  STD_LOGIC;
        
          Rst  : in  STD_LOGIC;
         
          Data : in  STD_LOGIC_VECTOR (15 downto 0); 
                 -- date de afisat (cifra 1 din stanga: biti 31..28)
          An   : out STD_LOGIC_VECTOR (3 downto 0); 
                 -- semnale pentru anozi (active in 0 logic)
          Seg  : out STD_LOGIC_VECTOR (6 downto 0)
                 -- semnale pentru segmentele (catozii) cifrei active
          );
end component displ7seg;


signal EN_aux : std_logic;
signal P : std_logic_vector(15 downto 0);
signal Data : std_logic_vector(31 downto 0);

begin

debouncer: debounce port map(CLK,RST,EN,EN_aux);
AUX : Wallace port map(CLK, EN_aux, X, Y, P);
displ: displ7seg port map(CLK,RST,P,An,Seg);



end Behavioral;
