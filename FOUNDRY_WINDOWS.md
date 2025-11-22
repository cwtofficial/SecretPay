# Installing Foundry on Windows - Quick Guide

A step-by-step guide to install Foundry (Ethereum development framework) on Windows using WSL.

---

## Prerequisites

- Windows 10 version 2004+ or Windows 11
- Administrator access
- ~30 minutes for first-time setup

---

## Installation Steps

### Step 1: Install WSL (Windows Subsystem for Linux)

1. **Open PowerShell as Administrator**

   - Right-click the Windows Start button
   - Select "Windows PowerShell (Admin)" or "Terminal (Admin)"

2. **Run the installation command:**

   ```powershell
   wsl --install
   ```

3. **Restart your computer** (required!)

> ⚠️ **Important**: `wsl --install` only installs WSL and Ubuntu. It does NOT install Foundry. You'll install Foundry in the next steps.

---

### Step 2: Set Up Ubuntu

1. **Open Ubuntu**

   - Search for "Ubuntu" in the Windows Start menu
   - Click the Ubuntu app
   - Wait 1-2 minutes for initial installation

2. **Create your Ubuntu user account**

   ```
   Enter new UNIX username: [your_username]
   New password: [your_password]
   Retype new password: [your_password]
   ```

   > 💡 **Note**: Your password won't show as you type (this is normal for security)

3. **You should now see a terminal prompt like:**
   ```bash
   your_username@COMPUTER-NAME:~$
   ```

---

### Step 3: Update Ubuntu and Install Dependencies

Run these commands in the Ubuntu terminal:

1. **Update package lists:**

   ```bash
   sudo apt update
   ```

2. **Upgrade installed packages:**

   ```bash
   sudo apt upgrade -y
   ```

3. **Install required tools:**
   ```bash
   sudo apt install -y build-essential curl git
   ```

> 💡 This installs compilers, curl (for downloading), and git (version control)

---

### Step 4: Install Foundry

1. **Download and install Foundry:**

   ```bash
   curl -L https://foundry.paradigm.xyz | bash
   ```

2. **Load Foundry into your terminal:**

   ```bash
   source ~/.bashrc
   ```

   Or simply close and reopen the Ubuntu terminal

3. **Complete Foundry installation:**

   ```bash
   foundryup
   ```

   You'll see progress bars as it installs `forge`, `cast`, `anvil`, and `chisel`

4. **Verify installation:**

   ```bash
   forge --version
   ```

   Should display something like:

   ```
   forge 0.2.0 (abc1234 2025-01-01T00:00:00.000000000Z)
   ```

✅ **Foundry is now installed!**

---

## Set Up VSCode (Optional but Recommended)

1. **Download and install VSCode:**

   - Visit https://code.visualstudio.com
   - Download and install for Windows

2. **Install the WSL extension:**

   - Open VSCode
   - Click the Extensions icon (or press `Ctrl+Shift+X`)
   - Search for "WSL"
   - Install "WSL" by Microsoft

3. **Connect VSCode to WSL:**

   - Press `Ctrl+Shift+P`
   - Type "WSL: Connect to WSL"
   - Press Enter
   - New VSCode window opens connected to Ubuntu

4. **Verify connection:**
   - Look at the bottom-left corner of VSCode
   - Should show: `WSL: Ubuntu`

---

## Quick Start - Create Your First Project

1. **Open Ubuntu terminal**

2. **Create a project folder:**

   ```bash
   mkdir ~/blockchain-projects
   cd ~/blockchain-projects
   ```

3. **Initialize a Foundry project:**

   ```bash
   forge init my-first-project
   cd my-first-project
   ```

4. **Open in VSCode:**

   ```bash
   code .
   ```

5. **Compile the example contract:**

   ```bash
   forge build
   ```

6. **Run tests:**
   ```bash
   forge test
   ```

🎉 **You're ready to develop smart contracts!**

---

## Understanding File Paths

When working with WSL, you can access your Windows files:

| Windows Path                  | Ubuntu/WSL Path                   |
| ----------------------------- | --------------------------------- |
| `C:\Users\YourName\Documents` | `/mnt/c/Users/YourName/Documents` |
| `D:\Projects`                 | `/mnt/d/Projects`                 |

**Recommendation:** Create projects in your Ubuntu home directory (`~`) for better performance:

```bash
cd ~
mkdir projects
cd projects
```

---

## Common Commands

### Foundry Commands

```bash
forge init          # Create new project
forge build         # Compile contracts
forge test          # Run tests
forge test --gas-report  # Show gas costs
forge clean         # Remove build files
```

### Cast Commands (Blockchain Interaction)

```bash
cast --version      # Check cast version
cast balance <address> --rpc-url <url>  # Check balance
cast call <address> "func()" --rpc-url <url>  # Call contract
```

### Ubuntu Commands

```bash
ls                  # List files
cd <directory>      # Change directory
pwd                 # Print working directory
mkdir <name>        # Create directory
cat <file>          # View file contents
clear               # Clear terminal
```

---

## Troubleshooting

### Issue: "wsl --install" not working

**Solution:**

- Make sure you're running PowerShell as Administrator
- Check Windows version: Press `Win+R`, type `winver`, press Enter
- Need Windows 10 version 2004+ or Windows 11

### Issue: "curl: command not found"

**Solution:**

```bash
sudo apt update
sudo apt install -y curl
```

### Issue: "forge: command not found" after installation

**Solution:**

```bash
source ~/.bashrc
# Or close and reopen Ubuntu terminal
```

Still not working? Add to PATH manually:

```bash
echo 'export PATH="$HOME/.foundry/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### Issue: Ubuntu app not appearing

**Solution:**

1. Open Microsoft Store
2. Search "Ubuntu"
3. Install "Ubuntu" (the plain version)
4. Launch Ubuntu

---

## Verification Checklist

Before starting development, verify everything works:

- [ ] WSL installed (`wsl --version` in PowerShell shows version)
- [ ] Ubuntu terminal opens
- [ ] Can run: `sudo apt update`
- [ ] `curl --version` shows version
- [ ] `git --version` shows version
- [ ] `forge --version` shows version
- [ ] `cast --version` shows version
- [ ] VSCode opens with WSL extension
- [ ] Can run: `code .` from Ubuntu terminal

If all checked ✅ - You're ready for blockchain development!

---

## Why WSL?

**Benefits:**

- ✅ Same commands as Mac/Linux (most tutorials assume Unix)
- ✅ Better compatibility with blockchain development tools
- ✅ Professional development environment
- ✅ Industry standard for Windows developers
- ✅ Can still access all your Windows files
- ✅ Faster compilation and testing

**The alternative (Git Bash) is less reliable and has more compatibility issues.**

---

## Resources

- **Foundry Documentation:** https://book.getfoundry.sh
- **WSL Documentation:** https://docs.microsoft.com/windows/wsl
- **Solidity Documentation:** https://docs.soliditylang.org
- **Ethereum Development:** https://ethereum.org/developers

---

## Getting Help

If you encounter issues:

1. Read the error message carefully
2. Search the error on Google
3. Check Foundry GitHub Issues: https://github.com/foundry-rs/foundry/issues
4. Ask in blockchain development communities (Discord, Reddit)

---

## What's Next?

After installation:

1. Follow a Solidity tutorial
2. Learn about smart contracts
3. Deploy to testnets (Sepolia, Goerli)
4. Build your first DeFi/NFT project
5. Join the Web3 community!

---

**Happy Coding! 🚀**

Built with ❤️ by [CWT](https://cwt.build).
