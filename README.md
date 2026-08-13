# QNX_build - Build Infrastructure & Environment Setup

This repository contains the build automation, environment setup scripts, and workflow configuration for the **QNX SDP 8.0 Raspberry Pi 5 (`bcm2712`) Project**.

---

## 📁 Workspace Folder Structure

```text
/home/cp/QNX_Practice/                           # Main Google Repo Workspace Root
├── QNX_build/                                   # Build Infrastructure & Configuration Repo (This repo)
│   ├── Makefile                                 # Top-level Makefile (Auto-copied to workspace root on repo sync)
│   ├── qnxsdp-env.sh                            # QNX SDP Environment Script (Auto-copied to workspace root)
│   └── README.md                                # Setup & Workflow Documentation
├── Appl_PSM/                                    # Application Source Code Repository
├── RequirementPSM/                              # Project Requirements & Specifications Repository
├── Makefile                                     # Automatically generated at root by `repo sync`
├── qnxsdp-env.sh                                # Automatically generated at root by `repo sync`
└── .repo/                                       # Repo Manifest & Metadata Storage
    └── manifests/default.xml                    # Project Manifest Configuration

External QNX Installation:
/home/cp/qnx800/                                 # QNX SDP 8.0 Installation Directory
├── host/linux/x86_64                            # Host Compiler & Toolchain Binaries (qcc, mkifs, etc.)
├── target/qnx                                   # Target Headers, Standard Libraries & C Runtime
└── bsp/BSP_raspberrypi-bcm2712-rpi5...          # Raspberry Pi 5 Board Support Package (BSP)
    └── images/                                  # IFS Image Generation Location (ifs-rpi5.bin)
```

---

## ⚙️ Environment Setup

Before compiling applications or building images, the QNX SDP 8.0 environment variables (`QNX_HOST`, `QNX_TARGET`, `MAKEFLAGS`, `PATH`) must be initialized.

### 1. Manual Setup
Run the following command from the workspace root (`/home/cp/QNX_Practice`):

```bash
source qnxsdp-env.sh
```

This sets:
- `QNX_HOST=/home/cp/qnx800/host/linux/x86_64`
- `QNX_TARGET=/home/cp/qnx800/target/qnx`
- `MAKEFLAGS=-I/home/cp/qnx800/target/qnx/usr/include`
- Adds QNX toolchain binaries (`qcc`, `mkifs`, `pidin`, etc.) to your shell `PATH`.

### 2. Automatic Setup
The root `Makefile` automatically detects if `QNX_HOST` is missing in your current shell and sources `qnxsdp-env.sh` automatically before building.

---

## 🛠️ Build Commands

All build operations can be executed directly from the workspace root (`/home/cp/QNX_Practice`):

### 1. Build Final QNX IFS Image (`ifs-rpi5.bin`)
Builds the bootable QNX Image Filesystem (IFS) binary for Raspberry Pi 5:
```bash
make
# OR
make all
```
> **Output Location**: `/home/cp/qnx800/bsp/BSP_raspberrypi-bcm2712-rpi5_be-800_SVN1024006_JBN381/images/ifs-rpi5.bin`

### 2. Clean Built Images
Removes generated IFS images and symbol files:
```bash
make clean
```

### 3. Clean Rebuild
Runs a complete clean followed by a build:
```bash
make rebuild
```

### 4. Build Application Code
To compile application binaries using QNX `qcc` compiler:
```bash
# Ensure environment is sourced
source qnxsdp-env.sh

# Compile ARM64 Little-Endian application binary
qcc -Vgcc_ntoaarch64le Appl.c -o out/appl
```

---

## 🔄 Google Repo Tool Commands

Manage all sub-repositories (`QNX_build`, `Appl_PSM`, `RequirementPSM`) using `repo`:

- **Synchronize Workspace**:
  ```bash
  repo sync
  ```
  *(Automatically updates projects and copies `Makefile` & `qnxsdp-env.sh` to the root workspace)*

- **Start a Development Branch Across Repositories**:
  ```bash
  repo start <branch-name> --all
  ```

- **Check Repository Status**:
  ```bash
  repo status
  ```