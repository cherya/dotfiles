ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
NVIM_CONFIG_DIR = ${HOME}/.config/nvim
TMUX_CONFIG_DIR = ${HOME}
UNAME := $(shell uname)

# apt get install this
PACKAGES = "stow zsh"

.PHONY: all
all:
	$(error nothing)

.PHONY: pull
pull:
	git pull

__check_stow = $(if $(shell command -v stow 2> /dev/null),,\
                    $(error "stow not found, please install it and run `make $@` again. https://www.gnu.org/software/stow/manual/stow.html"))

ZGENOM_REPO_DIR = ${HOME}/zgenom
ZSH_QUICKSTART_REPO_DIR = ${HOME}/zsh-quickstart-kit
.PHONY: zsh
zsh:
	$(call __check_stow)
	# install zgenom
	git clone https://github.com/jandamm/zgenom.git ${ZGENOM_REPO_DIR}
	# install zsh-quickstart-kit
	git clone https://github.com/unixorn/zsh-quickstart-kit.git ${ZSH_QUICKSTART_REPO_DIR}
	# symlink zsh files
	stow --target=~ ${ZSH_QUICKSTART_REPO_DIR} zsh

.PHONY: nvim-config
nvim-config:
	$(call __check_stow)
ifneq ($(wildcard $(NVIM_CONFIG_DIR)/.),)
	echo "Found nvim config directory $(NVIM_CONFIG_DIR)"
else
	echo "Creating nvim config directory $(NVIM_CONFIG_DIR)"
	mkdir $(NVIM_CONFIG_DIR)
endif
	stow --restow --target=$(NVIM_CONFIG_DIR) nvim

.PHONY: tmux-config
tmux-config:
ifneq ($(wildcard $(TMUX_CONFIG_DIR)/.),)
	echo "Found tmux config directory $(TMUX_CONFIG_DIR)"
else
	echo "Creating tmux config directory $(TMUX_CONFIG_DIR)"
	mkdir $(TMUX_CONFIG_DIR)
endif
	rm -rf $(TMUX_CONFIG_DIR)/.tmux.conf $(TMUX_CONFIG_DIR)/.tmux.conf.local
	ln -s -f ${ROOT_DIR}/tmux/.tmux.conf $(TMUX_CONFIG_DIR)/.tmux.conf
	cp -r ${ROOT_DIR}/tmux/.tmux.conf.local $(TMUX_CONFIG_DIR)/.tmux.conf.local

