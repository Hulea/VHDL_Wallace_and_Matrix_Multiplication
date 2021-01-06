library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Matrix is
generic(n:natural := 8);
 Port (
    
    CLK : in std_logic;
    EN  : in std_logic;
    X   : in std_logic_vector(n-1 downto 0);
    Y   : in std_logic_vector(n-1 downto 0);
    
    P   : out std_logic_vector(2*n-1 downto 0)  
  );
end Matrix;

architecture Behavioral of Matrix is

    component M is
      Port ( 
      
      X  : in std_logic;
      Y  : in std_logic;
      A  : in std_logic;
      Tin: in std_logic;
      
      S   : out std_logic;
      Tout: out std_logic 
      );
    end component;


    component Reg is
      generic ( n : natural);
      Port (
      
      CLK : in std_logic;
      EN  : in std_logic;
      
      D  : in std_logic_vector(3*n - 1 downto 0);
      Q : out std_logic_vector(3*n - 1 downto 0)
      
      );
    end component Reg;

    signal iy: std_logic_vector(n-1 downto 0) := (others => '0');

    type registre is array(0 to n-1) of std_logic_vector(3*n-1 downto 0);
    signal OUT_REGISTRU : registre := (others => (others =>'0'));
    signal IN_REGISTRU : registre := (others => (others =>'0'));
    
    type sumatoare is array(0 to n-1) of std_logic_vector(n-1 downto 0);
    signal SUMATOR_NIVEL : sumatoare := (others => (others =>'0'));
    
    type transport_sumatoare is array(0 to n-1) of std_logic_vector(n downto 0);
    signal TRANSPORT_NIVEL : transport_sumatoare := (others => (others =>'0'));
    
begin

generare_registru: for i in 0 to n-1 generate
    Regg: Reg generic map (n) port map(CLK,EN,IN_REGISTRU(i),OUT_REGISTRU(i));
end generate generare_registru;

swap: for i in 0 to n-1 generate
    iy(i) <= Y(n-1-i);
end generate swap;

IN_REGISTRU(0)(3*n-1 downto n) <= X & iy;
IN_REGISTRU(1) <= OUT_REGISTRU(0)(3*n-1 downto 2*n) & OUT_REGISTRU(0)(2*n-2 downto n) & TRANSPORT_NIVEL(0)(n) & SUMATOR_NIVEL(0);
intermediate_val: for i in 2 to n-1 generate 
    IN_REGISTRU(i) <= OUT_REGISTRU(i-1)(3*n-1 downto 2*n) & OUT_REGISTRU(i-1)(2*n-2 downto n-1+i) &TRANSPORT_NIVEL(i-1)(n) & SUMATOR_NIVEL(i-1) & OUT_REGISTRU(i-1)(i-2 downto 0);
end generate intermediate_val;

P(2*n-2) <= SUMATOR_NIVEL(n-1)(n-1);
P(2*n-1) <= TRANSPORT_NIVEL(n-1)(n);

f : for i in 0 to n-2 generate
    P(n+i-1) <= SUMATOR_NIVEL(n-1)(i);
    P(i) <= OUT_REGISTRU(n-1)(i);
end generate f;

ii: for i in 0 to n-1 generate
	jj: for j in 0 to n-1 generate
        sums: M port map( OUT_REGISTRU(i)(2*n+j),OUT_REGISTRU(i)(2*n-1),OUT_REGISTRU(i)(i+j),TRANSPORT_NIVEL(i)(j),SUMATOR_NIVEL(i)(j),TRANSPORT_NIVEL(i)(j+1));
    end generate jj;    
end generate ii;


end Behavioral;
