library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.std_logic_misc.all;

library gpio_lib;
    use gpio_lib.gpio_pkg.all;
    use gpio_lib.gpio_bank_comp_pkg.all;
    use gpio_lib.gpio_bank_regs_comp_pkg.all;

architecture RTL of GPIO is
    
    -- type declarations
    type gpio_regs_t is record
        GPIO_DIR      : std_logic_vector(G_BANK_SIZE - 1 downto 0);
        GPIO_OUT_DATA : std_logic_vector(G_BANK_SIZE - 1 downto 0);
        GPIO_IN_DATA  : std_logic_vector(G_BANK_SIZE - 1 downto 0);
    end record gpio_regs_t;
    
    constant c_gpio_regs_t_reset : gpio_regs_t := (GPIO_DIR => (others => '0'), GPIO_OUT_DATA => (others => '0'), GPIO_IN_DATA => (others => '0'));

    type gpio_regs_array_t is array (0 to G_NUM_BANKS - 1) of gpio_regs_t;

    type rd_data_array_t is array (integer range <>) of std_logic_vector(G_DATA_SIZE - 1 downto 0);

    -- function declarations
    function or_reduce(arr : rd_data_array_t) return std_logic_vector is
        variable ret : std_logic_vector(G_DATA_SIZE - 1 downto 0) := (others => '0');
    begin
        for I in arr'range
        loop
            ret := ret or arr(I);
        end loop;

        return ret;
    end function or_reduce;

    -- signal declarations
    signal w_gpio_regs  : GPIO_REGS_ARRAY_T;
    signal w_read_data  : rd_data_array_t(0 to G_NUM_BANKS - 1);
    signal w_read_valid : std_logic_vector(0 to G_NUM_BANKS - 1);

begin

    -- output signal assignments
    O_RD_DATA  <= or_reduce(w_read_data);
    O_RD_VALID <= or_reduce(w_read_valid);

    -- component instantiations
    GEN_BANKS : for I in 0 to G_NUM_BANKS - 1 generate
        U_GPIO_BANK : GPIO_BANK
            generic map (
                G_NUM_PINS => G_BANK_SIZE
            )
            port map (
                I_CLK           => I_CLK,
                I_RESET         => I_RESET,

                I_GPIO_DIR      => w_gpio_regs(I).GPIO_DIR,
                I_GPIO_OUT_DATA => w_gpio_regs(I).GPIO_OUT_DATA,
                O_GPIO_IN_DATA  => w_gpio_regs(I).GPIO_IN_DATA,

                IO_GPIO_PINS    => IO_GPIO_PINS(I)
            );

        U_GPIO_BANK_REGS : GPIO_BANK_REGS
            generic map (
                G_BANK_SIZE => G_BANK_SIZE,
                G_DATA_SIZE => G_DATA_SIZE,
                G_ADDR_SIZE => G_ADDR_SIZE,
                G_BASE_ADDR => std_logic_vector(unsigned(G_BASE_ADDR) + to_unsigned(3 * I, G_ADDR_SIZE))
            )
            port map (
                I_CLK      => I_CLK,
                I_RESET    => I_RESET,

                I_ADDR     => I_ADDR,
                I_WR_DATA  => I_WR_DATA,
                I_WR_EN    => I_WR_EN,
                O_RD_DATA  => w_read_data(I),
                O_RD_VALID => w_read_valid(I),

                O_GPIO_DIR      => w_gpio_regs(I).GPIO_DIR,
                O_GPIO_OUT_DATA => w_gpio_regs(I).GPIO_OUT_DATA,
                I_GPIO_IN_DATA  => w_gpio_regs(I).GPIO_IN_DATA
            );
    end generate GEN_BANKS;

end architecture RTL;