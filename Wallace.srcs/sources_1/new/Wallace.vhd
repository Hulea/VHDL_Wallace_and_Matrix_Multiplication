library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Wallace is
  Port (
        Clk: in std_logic;
        EN : in std_logic;
        X: in std_logic_vector(7 downto 0);
        Y: in std_logic_vector(7 downto 0);
        
        P: out std_logic_vector(15 downto 0)
   );
end Wallace;

architecture Behavioral of Wallace is

component Reg is
generic (n : INTEGER);
  Port (
  
  CLK : in std_logic;
  EN  : in std_logic;
  D  : in std_logic_vector(n-1 downto 0);
  Q : out std_logic_vector(n-1 downto 0)
  
  );
end component Reg;

component SST is
Port ( 
    A : in STD_LOGIC_VECTOR (15 downto 0);
    B : in STD_LOGIC_VECTOR (15 downto 0);
    C : in STD_LOGIC_VECTOR (15 downto 0);
    S : OUT STD_LOGIC_VECTOR (15 downto 0);
    T : OUT STD_LOGIC_VECTOR (15 downto 0));
end component SST;

component SPT is
generic (n : INTEGER);
 Port(
    X  : in std_logic_vector(n-1 downto 0);
    Y  : in std_logic_vector(n-1 downto 0);
    Tin: in std_logic;
    
    S   : out std_logic_vector(n-1 downto 0);
    Tout: out std_logic
    );
end component SPT;

type reg_data is array(0 to 4) of std_logic_vector(127 downto 0);
signal REG_IN : reg_data := (others => (others => '0'));
signal REG_OUT: reg_data := (others => (others => '0'));

type sum_and_transp is array(0 to 5) of std_logic_vector(15 downto 0);
signal SUMA : sum_and_transp := (others => (others => '0'));
signal TRANSP : sum_and_transp := (others => (others => '0'));

signal X_aux, Y_aux : std_logic_vector(7 downto 0) := (others => '0');
signal M0,M1,M2,M3,M4,M5,M6,M7 : std_logic_vector(15 downto 0) := (others => '0');
signal PP_reg : std_logic_vector(127 downto 0) := (others => '0');
signal Tout : std_logic := '0';

begin

stocare_deinmultit: Reg generic map (8) port map (CLK,EN,X,X_aux);
stocare_inmultitor: Reg generic map (8) port map (CLK,EN,Y,Y_aux);

M0 <= b"0000_0000"& (X_aux(7) and Y_aux(0)) & (X_aux(6) and Y_aux(0)) & (X_aux(5) and Y_aux(0)) & (X_aux(4) and Y_aux(0))&(X_aux(3) and Y_aux(0)) & (X_aux(2) and Y_aux(0)) & (X_aux(1) and Y_aux(0)) & (X_aux(0) and Y_aux(0));
M1 <= b"0000_000"&  (X_aux(7) and Y_aux(1)) & (X_aux(6) and Y_aux(1)) & (X_aux(5) and Y_aux(1)) & (X_aux(4) and Y_aux(1))&(X_aux(3) and Y_aux(1)) & (X_aux(2) and Y_aux(1)) & (X_aux(1) and Y_aux(1)) & (X_aux(0) and Y_aux(1)) & '0';
M2 <= b"0000_00"&   (X_aux(7) and Y_aux(2)) & (X_aux(6) and Y_aux(2)) & (X_aux(5) and Y_aux(2)) & (X_aux(4) and Y_aux(2))&(X_aux(3) and Y_aux(2)) & (X_aux(2) and Y_aux(2)) & (X_aux(1) and Y_aux(2)) & (X_aux(0) and Y_aux(2)) & "00";
M3 <= b"0000_0"&    (X_aux(7) and Y_aux(3)) & (X_aux(6) and Y_aux(3)) & (X_aux(5) and Y_aux(3)) & (X_aux(4) and Y_aux(3))&(X_aux(3) and Y_aux(3)) & (X_aux(2) and Y_aux(3)) & (X_aux(1) and Y_aux(3)) & (X_aux(0) and Y_aux(3)) & "000";
M4 <= b"0000"&      (X_aux(7) and Y_aux(4)) & (X_aux(6) and Y_aux(4)) & (X_aux(5) and Y_aux(4)) & (X_aux(4) and Y_aux(4))&(X_aux(3) and Y_aux(4)) & (X_aux(2) and Y_aux(4)) & (X_aux(1) and Y_aux(4)) & (X_aux(0) and Y_aux(4)) & "0000";
M5 <= b"000"&       (X_aux(7) and Y_aux(5)) & (X_aux(6) and Y_aux(5)) & (X_aux(5) and Y_aux(5)) & (X_aux(4) and Y_aux(5))&(X_aux(3) and Y_aux(5)) & (X_aux(2) and Y_aux(5)) & (X_aux(1) and Y_aux(5)) & (X_aux(0) and Y_aux(5)) & b"0000_0";
M6 <= b"00"&        (X_aux(7) and Y_aux(6)) & (X_aux(6) and Y_aux(6)) & (X_aux(5) and Y_aux(6)) & (X_aux(4) and Y_aux(6))&(X_aux(3) and Y_aux(6)) & (X_aux(2) and Y_aux(6)) & (X_aux(1) and Y_aux(6)) & (X_aux(0) and Y_aux(6)) & b"0000_00";
M7 <= '0' &         (X_aux(7) and Y_aux(7)) & (X_aux(6) and Y_aux(7)) & (X_aux(5) and Y_aux(7)) & (X_aux(4) and Y_aux(7))&(X_aux(3) and Y_aux(7)) & (X_aux(2) and Y_aux(7)) & (X_aux(1) and Y_aux(7)) & (X_aux(0) and Y_aux(7)) & b"0000_000";

PP_reg <= M7 & M6 & M5 & M4 & M3 & M2 & M1 & M0;

REG_IN(0) <= PP_reg;
Reg_0: Reg generic map(128) port map(CLK, EN, REG_IN(0), REG_OUT(0) );

SST_0: SST  port map(
        A => REG_OUT(0)(47 downto 32),  
        B => REG_OUT(0)(31 downto 16),
        C => REG_OUT(0)(15 downto 0),
        S => SUMA(0),
        T => TRANSP(0)
);

SST_1: SST port map(

        A => REG_OUT(0)(95 downto 80),
        B => REG_OUT(0)(79 downto 64),
        C => REG_OUT(0)(63 downto 48),
        S => SUMA(1),
        T => TRANSP(1) 
);
        
REG_IN(1)(95 downto 80) <= REG_OUT(0)(127 downto 112);
REG_IN(1)(79 downto 64) <= REG_OUT(0)(111 downto 96);
REG_IN(1)(63 downto 48) <= TRANSP(1);
REG_IN(1)(47 downto 32) <= SUMA(1);
REG_IN(1)(31 downto 16) <= TRANSP(0);
REG_IN(1)(15 downto 0) <= SUMA(0);
Reg_1: Reg generic map(128) port map(CLK, EN, REG_IN(1), REG_OUT(1));

SST_2: SST  port map(
        A => REG_OUT(1)(47 downto 32),  
        B => REG_OUT(1)(31 downto 16),
        C => REG_OUT(1)(15 downto 0),
        S => SUMA(2),
        T => TRANSP(2)
);

SST_3: SST port map(
        
        A => REG_OUT(1)(95 downto 80),  
        B => REG_OUT(1)(79 downto 64),
        C => REG_OUT(1)(63 downto 48),
        S => SUMA(3),
        T => TRANSP(3) 
);

REG_IN(2)(63 downto 48) <= TRANSP(3);
REG_IN(2)(47 downto 32) <= SUMA(3);
REG_IN(2)(31 downto 16) <= TRANSP(2);
REG_IN(2)(15 downto 0) <= SUMA(2);
Reg_2:Reg generic map(128) port map(CLK, EN, REG_IN(2), REG_OUT(2));

SST_4: entity work.SST port map(
        A => REG_OUT(2)(47 downto 32),  
        B => REG_OUT(2)(31 downto 16),
        C => REG_OUT(2)(15 downto 0),
        S => SUMA(4),
        T => TRANSP(4) 
);

REG_IN(3)(47 downto 32)  <= REG_OUT(2)(63 downto 48);
REG_IN(3)(31 downto 16) <= TRANSP(4);
REG_IN(3)(15 downto 0) <= SUMA(4);
Reg_3: Reg generic map(128) port map(CLK, EN, REG_IN(3), REG_OUT(3));

SST_5: SST port map(
        A => REG_OUT(3)(47 downto 32),  
        B => REG_OUT(3)(31 downto 16),
        C => REG_OUT(3)(15 downto 0),
        S => SUMA(5),
        T => TRANSP(5) 
);

REG_IN(4)(31 downto 16) <= TRANSP(5);
REG_IN(4)(15 downto 0) <= SUMA(5);
Reg_4: Reg generic map(128) port map(CLK, EN, REG_IN(4), REG_OUT(4));

SPT_0 : SPT generic map (16) port map(
            X => REG_OUT(4)(31 downto 16),
            Y => REG_OUT(4)(15 downto 0),
            Tin => '0',
            S => P,
            Tout => Tout
    );
end Behavioral;
