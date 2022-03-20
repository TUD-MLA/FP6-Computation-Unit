library work;
use work.array_vector_package.all;

library ieee;
use ieee.std_logic_1164.all;
 


entity sa_tb is -- systolic array testbench
end sa_tb;

architecture test of sa_tb is

	component sa is -- systolic array
        generic (systolicArraySize:integer := 8;bitSize:integer := 8);
        port ( -- c: clock; r: reset
            upperInputVectors : in std_1d_vector_array(0 to array_size-1); -- upper side
            leftInputVectors : in std_1d_vector_array(0 to array_size-1); -- left side
            clk : in std_logic;
            reset : in std_logic;
            outMatrix : out std_2d_vector_array(0 to array_size-1, 0 to array_size-1)
        );
    end component;

    --constant array_size : integer := 8;
    
	signal a, b: std_1d_vector_array(0 to array_size-1)  ;
	signal c, r: std_logic;
	signal d: std_2d_vector_array(0 to array_size-1, 0 to array_size-1);
	
	signal outputVector1: std_logic_vector(7 downto 0);
	signal outputVector2: std_logic_vector(7 downto 0);
	signal outputVector3: std_logic_vector(7 downto 0);
	signal outputVector4: std_logic_vector(7 downto 0);
	signal outputVector5: std_logic_vector(7 downto 0);
	signal outputVector6: std_logic_vector(7 downto 0);
	signal outputVector7: std_logic_vector(7 downto 0);
	signal outputVector8: std_logic_vector(7 downto 0);
	
begin

    sa1: sa generic map(systolicArraySize=>array_size, bitSize=>8)port map(upperInputVectors => a, leftInputVectors => b, clk => c, reset => r, outMatrix => d);
    
    
    
    outputVector1 <= getVectored2D(d, 0, 0);
    outputVector2 <= getVectored2D(d, 1, 1);
    outputVector3 <= getVectored2D(d, 2, 2);
    outputVector4 <= getVectored2D(d, 3, 3);
    outputVector5 <= getVectored2D(d, 4, 4);
    outputVector6 <= getVectored2D(d, 5, 5);
    outputVector7 <= getVectored2D(d, 6, 6);
    outputVector8 <= getVectored2D(d, 7, 7);
	
	process begin
        forloopc: for i in 100 downto 0 loop
            c <= '0';
            wait for 5 ns;
            c <= '1';
            wait for 5 ns;
        end loop;
        wait;

    end process;
    
	process begin

		for i in 0 to 7 loop
            a(i) <= "00000100";
            b(i) <= "00000010";
        end loop;
        r <= '1';
        wait for 1 ns;
        r <= '0';
        wait for 1 ns;
        wait for 100 ns;
        for i in 0 to 7 loop
            a(i) <= "00000000";
            b(i) <= "00000000";
        end loop;
        
		wait;
	end process;
end test;
