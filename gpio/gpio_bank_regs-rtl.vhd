library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library gpio_lib;
    use gpio_lib.gpio_pkg.all;

architecture RTL of GPIO_BANK_REGS is

    type gpio_regs_t is record
        GPIO_DIR      : std_logic_vector(G_BANK_SIZE - 1 downto 0);
        GPIO_OUT_DATA : std_logic_vector(G_BANK_SIZE - 1 downto 0);
        GPIO_IN_DATA  : std_logic_vector(G_BANK_SIZE - 1 downto 0);
    end record gpio_regs_t;
    
    constant c_gpio_regs_t_reset : gpio_regs_t := (GPIO_DIR => (others => '0'), GPIO_OUT_DATA => (others => '0'), GPIO_IN_DATA => (others => '0'));

    -- signal declarations
    signal q_gpio_regs, n_gpio_regs : GPIO_REGS_T;

begin

    -- input signal assignments
    n_gpio_regs.GPIO_IN_DATA <= I_GPIO_IN_DATA;

    -- output signal assignments
    O_GPIO_DIR      <= q_gpio_regs.GPIO_DIR;
    O_GPIO_OUT_DATA <= q_gpio_regs.GPIO_OUT_DATA;

    -- asynchronous processes
    MEM_WRITE_PROC : process(I_ADDR, I_WR_DATA, I_WR_EN)
    begin

        if I_WR_EN = '1' then

            if unsigned(I_ADDR) = unsigned(G_BASE_ADDR) then
                n_gpio_regs.GPIO_DIR <= std_logic_vector(resize(unsigned(I_WR_DATA), G_BANK_SIZE));
            elsif unsigned(I_ADDR) = unsigned(G_BASE_ADDR) + 1 then
                n_gpio_regs.GPIO_OUT_DATA <= std_logic_vector(resize(unsigned(I_WR_DATA), G_BANK_SIZE));
            end if;

        end if;

    end process MEM_WRITE_PROC;

    MEM_READ_PROC : process(I_ADDR)
    begin

        if unsigned(I_ADDR) = unsigned(G_BASE_ADDR) then
            O_RD_DATA  <= std_logic_vector(resize(unsigned(q_gpio_regs.GPIO_DIR), G_DATA_SIZE));
            O_RD_VALID <= '1';
        elsif unsigned(I_ADDR) = unsigned(G_BASE_ADDR) + 1 then
            O_RD_DATA  <= std_logic_vector(resize(unsigned(q_gpio_regs.GPIO_OUT_DATA), G_DATA_SIZE));
            O_RD_VALID <= '1';
        elsif unsigned(I_ADDR) = unsigned(G_BASE_ADDR) + 2 then
            O_RD_DATA  <= std_logic_vector(resize(unsigned(q_gpio_regs.GPIO_IN_DATA), G_DATA_SIZE));
            O_RD_VALID <= '1';
        else
            O_RD_DATA  <= (others => '0');
            O_RD_VALID <= '0';
        end if;

    end process MEM_READ_PROC;

    -- synchronous processes
    SYNC_PROC : process(I_CLK, I_RESET)
    begin

        if I_RESET = '1' then
            q_gpio_regs <= c_gpio_regs_t_reset;
        elsif rising_edge(I_CLK) then
            q_gpio_regs <= n_gpio_regs;
        end if;

    end process SYNC_PROC;

end architecture RTL;