----------------------------------------------------------------------------------
-- Engineer: 
-- 
-- Create Date:    18:08:54 01/17/2013 
-- Description:    Because the board only has 8 switches,
--                 the input needs to be registered to have a
--                 16 bit input.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity InputLoader is
    Port ( BINARY_INPUT : in  STD_LOGIC_VECTOR (7 downto 0);
             FULL_INPUT : out  STD_LOGIC_VECTOR (15 downto 0);
                    LED : out STD_LOGIC;
                   LOAD : in  STD_LOGIC;
                    CLK : in  STD_LOGIC;
                    RST : in  STD_LOGIC);
end InputLoader;

architecture Behavioral of InputLoader is
   --DEFINE TEMPORARY SIGNALS
   signal bottom_8, top_8 : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
   signal          PS, NS : STD_LOGIC := '0';

begin
   process (CLK, RST) begin
      if (RST = '1') then
         bottom_8 <= (others => '0');
            top_8 <= (others => '0');
               PS <= '0';
      elsif (rising_edge(CLK)) then
         PS <= NS;
         case (PS) is
            when '0' =>
                    LED <= '0';
               bottom_8 <= BINARY_INPUT;
               if (LOAD = '0') then
                  NS <= PS;
               else
                  NS <= '1';
               end if;
            when '1' =>
                 LED <= '1';
               top_8 <= BINARY_INPUT;
                  NS <= PS;
            when others =>
                  NS <= '0';
            end case;
      end if;
   end process;
   FULL_INPUT <= top_8 & bottom_8;

end Behavioral;
