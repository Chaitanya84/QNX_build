# Makefile for building QNX IFS Image for Raspberry Pi 5
# Location: /home/cp/QNX_Practice/Makefile

SHELL := /bin/bash

BSP_IMAGES_DIR := /home/cp/qnx800/bsp/BSP_raspberrypi-bcm2712-rpi5_be-800_SVN1024006_JBN381/images
ENV_SCRIPT     := /home/cp/QNX_Practice/qnxsdp-env.sh

.PHONY: all clean rebuild help

# Default target: build ifs-rpi5.bin
all:
	@if [ -z "$$QNX_HOST" ]; then \
		echo "QNX environment not detected. Sourcing $(ENV_SCRIPT)..."; \
		source $(ENV_SCRIPT) && $(MAKE) -C $(BSP_IMAGES_DIR) all; \
	else \
		$(MAKE) -C $(BSP_IMAGES_DIR) all; \
	fi

# Clean built IFS images and symbol files
clean:
	@if [ -z "$$QNX_HOST" ]; then \
		echo "QNX environment not detected. Sourcing $(ENV_SCRIPT)..."; \
		source $(ENV_SCRIPT) && $(MAKE) -C $(BSP_IMAGES_DIR) clean; \
	else \
		$(MAKE) -C $(BSP_IMAGES_DIR) clean; \
	fi

# Perform a clean rebuild
rebuild: clean all

help:
	@echo "Available targets:"
	@echo "  make all       - Build final QNX IFS image (ifs-rpi5.bin)"
	@echo "  make clean     - Clean generated IFS images in BSP directory"
	@echo "  make rebuild   - Clean and rebuild the IFS image"
