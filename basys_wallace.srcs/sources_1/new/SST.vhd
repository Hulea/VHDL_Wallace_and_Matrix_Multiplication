library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity SST is
Port ( 
    A : in STD_LOGIC_VECTOR (15 downto 0);
    B : in STD_LOGIC_VECTOR (15 downto 0);
    C : in STD_LOGIC_VECTOR (15 downto 0);
    S : OUT STD_LOGIC_VECTOR (15 downto 0);
    T : OUT STD_LOGIC_VECTOR (15 downto 0));
end SST;
 
architecture Behavioral of SST is

component Adder is
Port ( 
     A : in STD_LOGIC;
     B : in STD_LOGIC;
     Tin : in STD_LOGIC;
     S : out STD_LOGIC;
     Tout : out STD_LOGIC);
end component Adder;
 
signal X,Y,T_aux: STD_LOGIC_VECTOR(15 downto 0);
signal C1,C2,C3,c4,c5,c6,c7: STD_LOGIC;

 
begin

ad1:  Adder port map( A(0)  ,B(0)  ,C(0)  ,S(0)  ,T_aux(0));
ad2:  Adder PORT MAP( A(1)  ,B(1)  ,C(1)  ,S(1)  ,T_aux(1));
ad3:  Adder PORT MAP( A(2)  ,B(2)  ,C(2)  ,S(2)  ,T_aux(2));
ad4:  Adder PORT MAP( A(3)  ,B(3)  ,C(3)  ,S(3)  ,T_aux(3));
ad5:  Adder PORT MAP( A(4)  ,B(4)  ,C(4)  ,S(4)  ,T_aux(4));
ad6:  Adder PORT MAP( A(5)  ,B(5)  ,C(5)  ,S(5)  ,T_aux(5));
ad7:  Adder PORT MAP( A(6)  ,B(6)  ,C(6)  ,S(6)  ,T_aux(6));
ad8:  Adder PORT MAP( A(7)  ,B(7)  ,C(7)  ,S(7)  ,T_aux(7));
ad9:  Adder PORT MAP( A(8)  ,B(8)  ,C(8)  ,S(8)  ,T_aux(8));
ad10: Adder PORT MAP( A(9)  ,B(9)  ,C(9)  ,S(9)  ,T_aux(9));
ad11: Adder PORT MAP( A(10) ,B(10) ,C(10) ,S(10) ,T_aux(10));
ad12: Adder PORT MAP( A(11) ,B(11) ,C(11) ,S(11) ,T_aux(11));
ad13: Adder PORT MAP( A(12) ,B(12) ,C(12) ,S(12) ,T_aux(12));
ad14: Adder PORT MAP( A(13) ,B(13) ,C(13) ,S(13) ,T_aux(13));
ad15: Adder PORT MAP( A(14) ,B(14) ,C(14) ,S(14) ,T_aux(14));
ad16: Adder PORT MAP( A(15) ,B(15) ,C(15) ,S(15) ,T_aux(15));
 
T <= T_aux(14 downto 0) & '0'; --shift
 
end Behavioral;
