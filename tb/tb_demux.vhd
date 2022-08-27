----------------------------------------------------------------------------------
-- Company:  FPGA'er
-- Engineer: Claudio Avi Chami - FPGA'er Website
--           http://fpgaer.tech
-- Create Date: 26.08.2022 
-- Module Name: tb_demux.vhd
-- Description: test bench for demux
--              
-- Dependencies: demux.vhd
-- 
-- Revision: 1
-- Revision  1 - File Created
-- 
----------------------------------------------------------------------------------
library ieee;
    use ieee.std_logic_1164.all;
	use ieee.numeric_std.ALL;
    
entity tb_demux is
end entity;

architecture test of tb_demux is

    constant SEL_W  : natural := 3;
	
    signal din       : std_logic ;
    signal sel       : std_logic_vector (SEL_W-1 downto 0);
    signal endSim	 : boolean   := false;

    component demux  is
	generic (
		SEL_W		: natural := 4
	);	
	
	port (
		
		-- inputs
		din: 		in std_logic;
		sel:		in std_logic_vector (SEL_W-1 downto 0);
		
		-- outputs
		data_out: 	out std_logic_vector (2**SEL_W-1 downto 0)
	);
    end component;
    

begin

	-- Main simulation process
	process 
	begin
	
		din 	<= '1';
		sel		<= (others => '0');
		wait for 40 ns;
		for I in 0 to 2**SEL_W-1 loop
			sel	<= std_logic_vector(to_unsigned(I, sel'length));
			wait for 20 ns;
		end loop;	
		wait for 40 ns;
		
	    sel	<= std_logic_vector(to_unsigned(3, sel'length));
		wait for 10 ns;
		din <= '0';
		wait for 20 ns;
		din <= '1';
		wait for 20 ns;
	    sel	<= std_logic_vector(to_unsigned(5, sel'length));
		wait for 30 ns;
    
		endSim  <= true;
	end	process;	
		
	-- End the simulation
	process 
	begin
		if (endSim) then
			assert false 
				report "End of simulation." 
				severity failure; 
		end if;
		wait for 10 ns;
	end process;	

    demux_inst : demux
    generic map (
		SEL_W	 => SEL_W
	)
    port map (
		
        din      => din,
        sel      => sel,
		
        data_out => open
    );

end architecture;
