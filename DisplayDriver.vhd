----------------------------------------------------------------------------------
-- Engineer: Donald Percivalle 
-- 
-- Create Date:    18:32:52 01/17/2013 
-- Description:    Driver for 4-digit 7-segment display.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DisplayDriver is
    Port ( DISP1 : in  STD_LOGIC_VECTOR (6 downto 0);
           DISP2 : in  STD_LOGIC_VECTOR (6 downto 0);
           DISP3 : in  STD_LOGIC_VECTOR (6 downto 0);
           DISP4 : in  STD_LOGIC_VECTOR (6 downto 0);
             CLK : in  STD_LOGIC;
     DISPLAY_SEG : out  STD_LOGIC_VECTOR (6 downto 0);
     DISPLAY_ENA : out  STD_LOGIC_VECTOR (3 downto 0));
end DisplayDriver;

architecture Behavioral of DisplayDriver is

signal cnt : STD_LOGIC_VECTOR (1 downto 0);

begin
   process (CLK) begin
      if (rising_edge(CLK)) then
         cnt <= cnt + 1;
         if (cnt = "11") then
            cnt <= "00";
         end if;
     case (cnt) is
        when "00" =>
           DISPLAY_SEG <= DISP1;
           DISPLAY_ENA <= "1110";
        when "01" =>
           DISPLAY_SEG <= DISP2;
           DISPLAY_ENA <= "1101";
        when "10" =>
           DISPLAY_SEG <= DISP3;
           DISPLAY_ENA <= "1011";
        when "11" =>
           DISPLAY_SEG <= DISP4;
           DISPLAY_ENA <= "0111";
        when others =>
           DISPLAY_SEG <= (others => '0');
           DISPLAY_ENA <= "0000";
     end case;
      end if;
  end process;
  

end Behavioral;