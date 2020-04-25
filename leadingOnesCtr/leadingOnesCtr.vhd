library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity leadingOnesCtr is
	generic (
		BITS_IN: positive := 8;
		BITS_OUT: positive := 4);	--calculated by user as ceil(log2(BITS_IN+1))
	port (
		inp_vector: in std_logic_vector(BITS_IN-1 downto 0);
		onesCount: out std_logic_vector(BITS_OUT-1 downto 0));
end entity;


architecture concurrent of leadingOnesCtr is
	type integer_array is array (0 to BITS_IN) of integer range 0 to BITS_IN;
	signal internalOnesCt: integer_array;
	signal internalOnes: std_logic_vector(BITS_IN downto 0);
begin
	internalOnesCt(0) <= 0;
	internalOnes(BITS_IN) <= '1';
	
	gen: for i in 0 to BITS_IN-1 generate
		internalOnes(BITS_IN - 1 - i) <= '1' when inp_vector(BITS_IN - 1 - i)
														  and internalOnes(BITS_IN - i)
														  else '0';
	end generate;
		
	gen2: for i in 1 to BITS_IN generate
		internalOnesCt(i) <= internalOnesCt(i-1) + 1 when internalOnes(i-1) else internalOnesCt(i-1);
	end generate;
	
	onesCount <= std_logic_vector(to_unsigned(internalOnesCt(BITS_IN), BITS_OUT));
	
end architecture;