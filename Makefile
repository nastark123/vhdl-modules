ANALYZE_CMD=ghdl -a
ELABORATE_CMD=ghdl -e
RUN_CMD=ghdl -r

ANALYZE_FLAGS=--std=08

BUILD_DIR=build

LIB_DIR=lib

GPIO_LIB=gpio_lib

gpio_lib : gpio/*.vhd
	mkdir -p $(BUILD_DIR)/$(LIB_DIR)/$(GPIO_LIB)
	$(ANALYZE_CMD) $(ANALYZE_FLAGS) --work=$(GPIO_LIB) --workdir=$(BUILD_DIR)/$(LIB_DIR)/$(GPIO_LIB) gpio/gpio_pkg.vhd
	$(ANALYZE_CMD) $(ANALYZE_FLAGS) --work=$(GPIO_LIB) --workdir=$(BUILD_DIR)/$(LIB_DIR)/$(GPIO_LIB) gpio/gpio_bank.vhd
	$(ANALYZE_CMD) $(ANALYZE_FLAGS) --work=$(GPIO_LIB) --workdir=$(BUILD_DIR)/$(LIB_DIR)/$(GPIO_LIB) gpio/gpio_bank-rtl.vhd
	$(ANALYZE_CMD) $(ANALYZE_FLAGS) --work=$(GPIO_LIB) --workdir=$(BUILD_DIR)/$(LIB_DIR)/$(GPIO_LIB) gpio/gpio_bank_regs.vhd
	$(ANALYZE_CMD) $(ANALYZE_FLAGS) --work=$(GPIO_LIB) --workdir=$(BUILD_DIR)/$(LIB_DIR)/$(GPIO_LIB) gpio/gpio_bank_regs-rtl.vhd
	$(ANALYZE_CMD) $(ANALYZE_FLAGS) --work=$(GPIO_LIB) --workdir=$(BUILD_DIR)/$(LIB_DIR)/$(GPIO_LIB) gpio/gpio.vhd
	$(ANALYZE_CMD) $(ANALYZE_FLAGS) --work=$(GPIO_LIB) --workdir=$(BUILD_DIR)/$(LIB_DIR)/$(GPIO_LIB) gpio/gpio-rtl.vhd

clean : 
	rm -rf $(BUILD_DIR)