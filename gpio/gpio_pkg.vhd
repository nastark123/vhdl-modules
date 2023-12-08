library ieee;
    use ieee.std_logic_1164.all;

package GPIO_PKG is

    -- type declarations
    -- type gpio_regs_t is record
    --     GPIO_DIR      : std_logic_vector(G_BANK_SIZE - 1 downto 0);
    --     GPIO_OUT_DATA : std_logic_vector(G_BANK_SIZE - 1 downto 0);
    --     GPIO_IN_DATA  : std_logic_vector(G_BANK_SIZE - 1 downto 0);
    -- end record gpio_regs_t;
    
    -- constant c_gpio_regs_t_reset : gpio_regs_t := (GPIO_DIR => (others => '0'), GPIO_OUT_DATA => (others => '0'), GPIO_IN_DATA => (others => '0'));

    type gpio_pins_t is array (integer range <>) of std_logic_vector;

end package GPIO_PKG;