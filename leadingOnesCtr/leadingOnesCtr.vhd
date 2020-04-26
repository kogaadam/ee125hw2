library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity leadingOnesCtr is
	generic (
		BITS_IN: positive := 8;
		BITS_OUT: positive := 4);	--calculated by user as ceil(log2(BITS_IN+1))
	port (
		inp_vector: in std_logic_vector(BITS_IN-1 downto 0);
		ssd: out std_logic_vector(6 downto 0));
end entity;


architecture concurrent of leadingOnesCtr is
	type integer_array is array (0 to BITS_IN) of integer range 0 to BITS_IN;
	signal internalLeadOnesCt: integer_array;
	signal internalLeadOnes: std_logic_vector(BITS_IN downto 0);
	signal onesCount: std_logic_vector(BITS_OUT-1 downto 0);
begin
	internalLeadOnesCt(0) <= 0;
	internalLeadOnes(BITS_IN) <= '1';
	
	gen: for i in 0 to BITS_IN-1 generate
		internalLeadOnes(BITS_IN - 1 - i) <= '1' when inp_vector(BITS_IN - 1 - i) and internalLeadOnes(BITS_IN - i) else '0';
	end generate;
		
	gen2: for i in 1 to BITS_IN generate
		internalLeadOnesCt(i) <= internalLeadOnesCt(i-1) + 1 when internalLeadOnes(i-1) else internalLeadOnesCt(i-1);
	end generate;
	
	onesCount <= std_logic_vector(to_unsigned(internalLeadOnesCt(BITS_IN), BITS_OUT));
	
	with onesCount select
		ssd <= "0000001" when "0000",
				 "1001111" when "0001",
				 "0010010" when "0010",
				 "0000110" when "0011",
				 "1001100" when "0100",
				 "0100100" when "0101",
				 "0100000" when "0110",
				 "0001111" when "0111",
				 "0000000" when "1000",
				 "1111110" when others;
	
end architecture;