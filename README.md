# 🌯 Tibix (FHS Wrapper)

> **⚠️ Disclaimer:** This script is currently explicitly configured for **AMD GPUs**. It mounts the specific drivers and paths required for AMD Vulkan/Mesa graphics acceleration. If you are using an NVIDIA or Intel GPU, you will need to adjust the Nix dependencies and hardware mounts accordingly.

This repository provides a Nix FHS (Filesystem Hierarchy Standard) wrapper to run the Linux Tibia client natively on NixOS. 

## Prerequisites

1. **Tibia Client:** Download the Linux client directly from the [Tibia website](https://www.tibia.com/).

## Step 1: Directory Setup

1. Extract the downloaded Tibia client archive to a folder of your choice.
2. Place the `tibia.nix` file script directly into the root of that extracted folder.

Your directory structure should look like this:

```text
Tibia/
├── 3rdpartylicences/
├── lib/
├── plugins/
├── qt.conf
├── Tibia
├── tibia.ico
└── tibia.nix
```

## Step 2: Building the Environment
Open your terminal, navigate to the directory containing your tibia.nix and Tibia executable, and run the following command:

```
nix-build tibia.nix
```

## Step 3: Running the Client
Once the build successfully completes, you can launch the game by executing the generated wrapper:

```
./result/bin/Tibix
```