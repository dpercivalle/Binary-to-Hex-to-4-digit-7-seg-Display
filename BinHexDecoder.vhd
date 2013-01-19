----------------------------------------------------------------------------------
-- Engineer: Donald Percivalle 
-- 
-- Create Date:    16:51:11 01/17/2013
-- Description:    Decoder module for 16-bit binary to
--                 4 7-segment displays.
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BinHexDecoder is
    Port ( BINARY_IN : in  STD_LOGIC_VECTOR (3 downto 0);
           DISP_OUT : out  STD_LOGIC_VECTOR (6 downto 0));
end BinHexDecoder;

architecture Behavioral of BinHexDecoder is

begin

   DISP_OUT <= "0000001" when BINARY_IN = "0000" else
               "1001111" when BINARY_IN = "0001" else
               "0010010" when BINARY_IN = "0010" else
               "0000110" when BINARY_IN = "0011" else
               --GREATER THAN 3
               "1001100" when BINARY_IN = "0100" else
               "0100100" when BINARY_IN = "0101" else
               "0100000" when BINARY_IN = "0110" else
               "0001111" when BINARY_IN = "0111" else
               --GREATER THAN 7
               "0000000" when BINARY_IN = "1000" else
               "0000100" when BINARY_IN = "1001" else
               "0001000" when BINARY_IN = "1010" else
               "1100000" when BINARY_IN = "1011" else
               --GREATER THAN 11
               "0110001" when BINARY_IN = "1100" else
               "1000010" when BINARY_IN = "1101" else
               "0110000" when BINARY_IN = "1110" else
               "0111000" when BINARY_IN = "1111";

end Behavioral;