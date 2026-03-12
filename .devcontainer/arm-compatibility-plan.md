# ARM Compatibility Plan for Dev Container

## Overview
The current dev container uses `mcr.microsoft.com/devcontainers/universal:2.0-linux` which aims to be architecture-agnostic but may rely on x86_64 assumptions. This document outlines the steps to ensure the container operates correctly on ARM devices.

## Action Items
1. **Audit Base Image Architecture**
   - Verify that `universal:2.0-linux` pulls an ARM64 base on the target device.
   - Confirm absence of x86-specific binaries.

2. **Validate Post‑Create Commands**
   - Review `postCreateCommand` for ARM‑compatible packages.
   - Ensure `build-essential` and `jq` are available for ARM.

3. **Check VS Code Extensions**
   - Confirm all listed extensions have ARM‑compatible builds.
   - Validate any extension dependencies.

4. **Adjust Platform‑Specific Settings**
   - If the base image is not ARM‑ready, switch to an ARM‑specific image such as `mcr.microsoft.com/devcontainers/base:arch64`.
   - Update `postCreateCommand` to install ARM‑compatible dependencies or add `--arch=arm64` where needed.

5. **Test ARM Build**
   - Build the dev container on an ARM workstation using `docker build . -f .devcontainer/devcontainer.json`.
   - Capture any build failures and fix them.

6. **Document Fixes**
   - Add a README in `.devcontainer/` summarizing the ARM compatibility changes.
   - Include comments in `devcontainer.json` explaining platform overrides.

## Next Steps
- Implement the above actions in the repository.
- Re‑run the dev container on ARM and verify functionality.
- Collect feedback and iterate as needed.