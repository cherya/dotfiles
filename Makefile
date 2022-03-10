NVIM_CONFIG_DIR = ${HOME}/.config/nvim

.PHONY: all
all:
	$(error nothing)

.PHONY: pull
pull:
	git pull

.PHONY: nvim-config
nvim-config:
ifneq ($(wildcard $(NVIM_CONFIG_DIR)/.),)
	echo "Found nvim config directory $(NVIM_CONFIG_DIR)"
else
	echo "Creating nvim config directory $(NVIM_CONFIG_DIR)"
	mkdir $(NVIM_CONFIG_DIR)
endif
	stow --restow --target=$(NVIM_CONFIG_DIR) nvim
