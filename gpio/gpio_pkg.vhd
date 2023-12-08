library ieee;
    use ieee.std_logic_1164.all;

package GPIO_PKG is

    type gpio_pins_t is array (integer range <>) of std_logic_vector;

end package GPIO_PKG;