library ieee;
    use ieee.std_logic_1164.all;

library gpio_lib;
    use gpio_lib.gpio_pkg.all;
    use gpio_lib.gpio_comp_pkg.all;

entity GPIO_TB is
end entity GPIO_TB;

architecture TB of GPIO_TB is

    signal w_clk       : std_logic;
    signal w_reset     : std_logic;
    signal w_addr      : std_logic_vector(15 downto 0);
    signal w_wr_data   : std_logic_vector(7 downto 0);
    signal w_wr_en     : std_logic;
    signal w_rd_data   : std_logic_vector(7 downto 0);
    signal w_rd_valid  : std_logic;
    signal w_gpio_pins : gpio_pins_t(0 to 0)(7 downto 0);

begin

    -- clock generation process
    CLK_GEN : process
    begin
        w_clk <= '0';
        wait for 10 ns;
        w_clk <= '1';
        wait for 10 ns;
    end process CLK_GEN;

    TB_PROC : process
    begin

        w_reset <= '1';
        wait for 20 ns;

        w_reset   <= '0';
        w_addr    <= x"0000";
        w_wr_data <= x"F0";
        w_wr_en   <= '1';

        wait for 20 ns;

        w_addr    <= x"0001";
        w_wr_data <= x"A0";
        w_wr_en   <= '1';

        wait;

    end process TB_PROC;

    -- component instantiations
    U_GPIO : GPIO
        generic map (
            G_NUM_BANKS => 1,
            G_BANK_SIZE => 8,
            G_DATA_SIZE => 8,
            G_ADDR_SIZE => 16,
            G_BASE_ADDR => (others => '0')
        )
        port map (
            I_CLK        => w_clk,
            I_RESET      => w_reset,
    
            I_ADDR       => w_addr,
            I_WR_DATA    => w_wr_data,
            I_WR_EN      => w_wr_en,
            O_RD_DATA    => w_rd_data,
            O_RD_VALID   => w_rd_valid,
    
            IO_GPIO_PINS => w_gpio_pins
        );

end architecture TB;