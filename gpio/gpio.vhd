library ieee;
    use ieee.std_logic_1164.all;

library gpio_lib;
    use gpio_lib.gpio_pkg.all;

entity GPIO is
    generic (
        G_NUM_BANKS : positive := 1; -- number of pin banks to generate
        G_BANK_SIZE : positive := 8; -- number of pins in each bank
        G_DATA_SIZE : positive := 8; -- data size of the memory bus
        G_ADDR_SIZE : positive := 16; -- address size of the memory
        G_BASE_ADDR : std_logic_vector(G_ADDR_SIZE - 1 downto 0) := (others => '0') -- base address of the block
    );
    port (
        I_CLK : in  std_logic;
        I_RESET : in  std_logic;

        I_ADDR : in  std_logic_vector(G_ADDR_SIZE - 1 downto 0);
        I_WR_DATA : in  std_logic_vector(G_DATA_SIZE - 1 downto 0);
        I_WR_EN : in  std_logic;
        O_RD_DATA : out std_logic_vector(G_DATA_SIZE - 1 downto 0);
        O_RD_VALID : out std_logic_vector(G_DATA_SIZE - 1 downto 0);

        IO_GPIO_PINS : inout gpio_pins_t(0 to G_NUM_BANKS - 1)(G_BANK_SIZE - 1 downto 0)
    );
end entity GPIO;