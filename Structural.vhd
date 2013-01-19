----------------------------------------------------------------------------------
-- Engineer: Donald Percivalle
-- 
-- Create Date:    16:48:44 01/17/2013 
-- Description:    Structural level for 16-bit binary to
--                 7-segment display in hex.  4 displays.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Structural is
    Port ( SWI_IN : in  STD_LOGIC_VECTOR (7 downto 0);
             LOAD : in  STD_LOGIC;
              CLK : in  STD_LOGIC;
              RST : in  STD_LOGIC;
              LED : out STD_LOGIC;
         SEGMENTS : out STD_LOGIC_VECTOR (7 downto 0);
           ANODES : out STD_LOGIC_VECTOR (3 downto 0));
end Structural;

architecture Behavioral of Structural is
   --DEFINE DECODER COMPONENT
   component BinHexDecoder
       Port ( BINARY_IN : in  STD_LOGIC_VECTOR (3 downto 0);
               DISP_OUT : out  STD_LOGIC_VECTOR (6 downto 0));
   end component;
   
   --DEFINE REGISTER COMPONENT
   component InputLoader
       Port ( BINARY_INPUT : in  STD_LOGIC_VECTOR (7 downto 0);
                FULL_INPUT : out  STD_LOGIC_VECTOR (15 downto 0);
                       LED : out STD_LOGIC;
                      LOAD : in  STD_LOGIC;
                       CLK : in  STD_LOGIC;
                       RST : in  STD_LOGIC);
   end component;
   
   --DEFINE DISPLAY DRIVER COMPONENT
   component DisplayDriver
       Port ( DISP1 : in  STD_LOGIC_VECTOR (6 downto 0);
              DISP2 : in  STD_LOGIC_VECTOR (6 downto 0);
              DISP3 : in  STD_LOGIC_VECTOR (6 downto 0);
              DISP4 : in  STD_LOGIC_VECTOR (6 downto 0);
                CLK : in  STD_LOGIC;
        DISPLAY_SEG : out  STD_LOGIC_VECTOR (6 downto 0);
        DISPLAY_ENA : out  STD_LOGIC_VECTOR (3 downto 0));
   end component;
   
   --DEFINE CLOCK DIVIDER
   component clk_div
       Port (  clk : in std_logic;
           sclk : out std_logic);
   end component;
   
   --DEFINE SIGNALS
   signal BIN_IN : STD_LOGIC_VECTOR (15 downto 0);
   signal slow_clock : STD_LOGIC;
   signal DISP1, DISP2, DISP3, DISP4 : STD_LOGIC_VECTOR (6 downto 0);
   
begin
   SEGMENTS(0) <= '1';
   INPUTS: InputLoader   port map (BINARY_INPUT => SWI_IN,
                                     FULL_INPUT => BIN_IN,
                                            LED => LED,
                                           LOAD => LOAD,
                                            CLK => CLK,
                                            RST => RST);
   DIGIT1: BinHexDecoder port map (BINARY_IN => BIN_IN (3 downto 0),
                                    DISP_OUT => DISP1);
   DIGIT2: BinHexDecoder port map (BINARY_IN => BIN_IN (7 downto 4),
                                    DISP_OUT => DISP2);
   DIGIT3: BinHexDecoder port map (BINARY_IN => BIN_IN (11 downto 8),
                                    DISP_OUT => DISP3);
   DIGIT4: BinHexDecoder port map (BINARY_IN => BIN_IN (15 downto 12),
                                    DISP_OUT => DISP4);
   CLOCKD:       clk_div port map (clk => clk,
                                  sclk => slow_clock);
   DRIVER: DisplayDriver port map (DISP1 => DISP1,
                                   DISP2 => DISP2,
                                   DISP3 => DISP3,
                                   DISP4 => DISP4,
                                     CLK => slow_clock,
                             DISPLAY_SEG => SEGMENTS(7 downto 1),
                             DISPLAY_ENA => ANODES);                      
end Behavioral;
