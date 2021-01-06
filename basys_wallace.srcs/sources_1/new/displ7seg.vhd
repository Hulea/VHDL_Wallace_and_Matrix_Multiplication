----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/25/2020 12:37:43 PM
-- Design Name: 
-- Module Name: displ7seg - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity displ7seg is
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
end displ7seg;

architecture Behavioral of displ7seg is

constant CLK_RATE  : INTEGER := 100_000_000;  -- frecventa semnalului Clk
constant CNT_100HZ : INTEGER := 2**20;        -- divizor pentru rata de
                                              -- reimprospatare de ~100 Hz
constant CNT_500MS : INTEGER := CLK_RATE / 2; -- divizor pentru 500 ms
signal Count       : INTEGER range 0 to CNT_100HZ - 1 := 0;
signal CountBlink  : INTEGER range 0 to CNT_500MS - 1 := 0;
--signal BlinkOn     : STD_LOGIC := '0';
signal CountVect   : STD_LOGIC_VECTOR (19 downto 0) := (others => '0');
signal LedSel      : STD_LOGIC_VECTOR (2 downto 0) := (others => '0');
signal Digit1      : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
signal Digit2      : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
signal Digit3      : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
signal Digit4      : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');

signal numberSelected: STD_LOGIC_VECTOR (3 downto 0);

begin
   -- Proces pentru divizarea frecventei ceasului
   div_clk: process (Clk)
   begin
      if RISING_EDGE (Clk) then
         if (Rst = '1') then
            Count <= 0;
         elsif (Count = CNT_100HZ - 1) then
            Count <= 0;
         else
            Count <= Count + 1;
         end if;
      end if;
   end process div_clk;

   CountVect <= CONV_STD_LOGIC_VECTOR (Count, 20);
   LedSel <= CountVect (19 downto 17);
 
   Digit1 <=   Data(15 downto 12);
  
   Digit2 <=  Data(11 downto 8);
             
   Digit3 <=   Data (7 downto 4);
   
   Digit4 <=   Data (3 downto 0);

 process(LedSel)
 begin
 
 case(LedSel) is
 when "000"=> numberSelected<=Digit4;
 when "001"=> numberSelected<=Digit3;
 when "010"=> numberSelected<=Digit2;
 when "011"=> numberSelected<=Digit1;
when others => numberSelected<="1111";
 end case;
 
 end process;
 
 
 
 process(LedSel)
 begin
 
 case LedSel is
 when "000"=> An<="1110";
 when "001"=> An<="1101";
 when "010"=> An<="1011";
 when "011"=> An<="0111";
 when others=> An<="1111";
 end case;
 
 end process;

 ---alegem cifra afisata in functie de numberSelected bazat pe semnalul 
 
 process(numberSelected)
 begin
 
 case (numberSelected) is
  when "0000"=>Seg<="1000000";
  when "0001"=> Seg<="1111001";  --1
  when "0010"=> Seg<="0100100";   --2
  when "0011"=> Seg<="0110000"; --3
  when "0100"=> Seg<="0011001";   --4
  when "0101"=> Seg<="0010010";  --5
  when "0110"=> Seg<="0000010";   --6
  when "0111"=> Seg<="1111000";   --7
  when "1000"=> Seg<="0000000";    --8
  when "1001"=> Seg<="0010000";   --9
  when "1010"=>Seg<="0001000";    --A
  when "1011"=>Seg<="0000011";   --b
  when "1100"=>Seg<="1000110";   --C
  when "1101"=>Seg<="0100001";  --d
  when "1110"=>Seg<="0000110";   --E
  when "1111"=>Seg<="0001110";   --F
   end case;
 
 end process;
         

end Behavioral;


