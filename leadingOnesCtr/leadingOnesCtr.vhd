library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity leadingOnesCtr is
	generic (
		BITS_IN: positive := 8;
		BITS_OUT: positive := 4);	--calculated by user as ceil(log2(BITS_IN+1))
	port (
		inp_vector: in std_logic_vector(BITS_IN-1 downto 0));
end entity;


architecture rtl of leadingOnesCtr is
begin
end architecture;