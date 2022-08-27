----------------------------------------------------------------------------------
-- Company:  FPGA'er
-- Engineer: Claudio Avi Chami - FPGA'er Website
--           http://fpgaer.tech
-- Create Date: 22.08.2022 
-- Module Name: demux.vhd
-- Description: Generic demultiplexer 
--              
-- Dependencies: None
-- 
-- Revision: 1
-- Revision  1 - File Created
-- 
----------------------------------------------------------------------------------
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity demux is 
	generic ( SEL_W		: natural := 4 );	
	
	port (
		
		-- inputs
		din: 		in std_logic;
		sel:		in std_logic_vector (SEL_W-1 downto 0);
		
		-- outputs
		data_out: 	out std_logic_vector (2**SEL_W-1 downto 0)
	);
end demux;


architecture rtl of demux is

begin 

	demux_pr: process(sel, din)
	begin
		-- set all the outputs to '0' to avoid inferred latches
		data_out <= (others => '0');
		-- Set input in correct line
		data_out(to_integer(unsigned(sel))) <= din;
	end process;

end rtl;
