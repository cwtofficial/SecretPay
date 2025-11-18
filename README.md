# 🔐 SecretPay - Password-Protected ETH Transfers

![Solidity](https://img.shields.io/badge/Solidity-^0.8.0-363636?style=for-the-badge&logo=solidity)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)
![Beginner Friendly](https://img.shields.io/badge/Level-Beginner-blue?style=for-the-badge)

A beginner-friendly Solidity tutorial that teaches you how to build a decentralized escrow smart contract with password protection. Send ETH with a secret password - only those who know the password can claim it!

**Full Video Tutorial:** [Watch on YouTube](https://youtube.com/@officialcwt)  
**Our Wwebsite:** [Visit CWT](https://cwt.build)

---

## 📖 Table of Contents

- [About](#about)
- [Features](#features)
- [Use Cases](#use-cases)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Project Structure](#project-structure)
- [Tutorial Breakdown](#tutorial-breakdown)
- [Smart Contract Overview](#smart-contract-overview)
- [Deployment Guide](#deployment-guide)
- [Frontend Integration (Optional)](#frontend-integration-optional)
- [Security Considerations](#security-considerations)
- [Testing](#testing)
- [Gas Optimization](#gas-optimization)
- [Common Issues & Solutions](#common-issues--solutions)
- [Contributing](#contributing)
- [Resources](#resources)
- [License](#license)

---

## 🎯 About

**SecretPay** is an educational smart contract project designed to teach Solidity fundamentals through a practical, real-world application. Unlike typical token or NFT tutorials, this project covers:

- ✅ Handling ETH transactions
- ✅ Cryptographic password hashing
- ✅ Time-based escrow logic
- ✅ Access control patterns
- ✅ Event emission and logging
- ✅ Security best practices

**Perfect for:** Developers with basic programming knowledge who want to learn blockchain development from scratch.

**Time to Complete:** 2-2.5 hours (core tutorial) + 30 minutes (optional frontend)

---

## ✨ Features

### Core Functionality

- **Password-Protected Transfers:** Lock ETH behind a secret password
- **Claim Mechanism:** Recipients unlock funds with the correct password
- **Automatic Refunds:** Senders can withdraw if unclaimed after deadline
- **Multiple Transfers:** Support for unlimited concurrent transfers
- **Event Tracking:** All actions emit events for off-chain monitoring

### Security Features

- **Hashed Passwords:** Uses `keccak256` for secure password storage
- **Access Control:** Only authorized parties can execute specific functions
- **Re-entrancy Protection:** Follows checks-effects-interactions pattern
- **Time Locks:** Deadline-based refund mechanism

---

## 💡 Use Cases

### 1. **Crypto Gifts with Riddles** 🎁

Send ETH with a riddle as the password. Perfect for birthdays, holidays, or special occasions.

**Example:**

```
Password: "What has keys but no locks, space but no room?"
Answer: "keyboard"
```

### 2. **Freelance Escrow** 💼

Lock payment until project completion. The password acts as the delivery confirmation.

**Flow:**

1. Client creates transfer with agreed password
2. Freelancer completes work, receives password
3. Freelancer claims payment

### 3. **Educational Rewards** 🎓

Teachers can reward students who solve challenges correctly.

**Example:**

```
Challenge: "Calculate 15% of 280"
Password: "42"
```

### 4. **Gaming Treasure Hunts** 🎮

Hide crypto rewards in games where players discover passwords through gameplay.

**Example:**

```
Quest: Complete dungeon level 5
Reward: 0.1 ETH locked with password found at end of level
```

---

## 📋 Prerequisites

### Required

- ✅ **Basic programming knowledge** (JavaScript, Python, or any language)
- ✅ **Web browser** (Chrome, Firefox, or Brave)

### Optional (for deployment)

- 🔵 **MetaMask wallet** (we'll set up together in tutorial)
- 🔵 **Test ETH** (free from Sepolia faucet)

### Optional (for frontend)

- 🔵 **Node.js** (v16 or higher)
- 🔵 **React knowledge** (basic understanding)

**No blockchain experience required!** We teach everything from scratch.

---

## 🚀 Quick Start

### Option 1: Browser-Only (Recommended for Beginners)

1. **Open Remix IDE**

   ```
   https://remix.ethereum.org
   ```

2. **Create New File**

   - Click "Create New File" in file explorer
   - Name it: `SecretPay.sol`

3. **Copy Contract Code**

   ```solidity
   // Paste the contract code from /contracts/SecretPay.sol
   ```

4. **Compile**

   - Go to "Solidity Compiler" tab
   - Click "Compile SecretPay.sol"

5. **Deploy & Test**
   - Go to "Deploy & Run Transactions" tab
   - Select "Remix VM (Shanghai)" environment
   - Click "Deploy"
   - Start testing with different accounts!

### Option 2: Local Development

```bash
# Clone the repository
git clone https://github.com/CodeWithTy/secretpay-tutorial.git
cd secretpay-tutorial

# Install dependencies (optional - for frontend)
cd frontend
npm install

# Run frontend (optional)
npm run dev
```

---

## 📁 Project Structure

```
secretpay-tutorial/
├── contracts/
│   ├── SecretPay.sol              # Main smart contract
│   ├── SecretPay-starter.sol      # Starter template for students
│   └── SecretPay-commented.sol    # Heavily commented version
├── frontend/ (optional)
│   ├── src/
│   │   ├── components/
│   │   │   ├── CreateTransfer.jsx
│   │   │   ├── ClaimTransfer.jsx
│   │   │   └── TransferList.jsx
│   │   ├── App.jsx
│   │   └── main.jsx
│   ├── package.json
│   └── vite.config.js
├── test/
│   └── SecretPay.test.js          # Smart contract tests
├── scripts/
│   ├── deploy.js                  # Deployment script
│   └── interact.js                # Interaction examples
├── docs/
│   ├── tutorial-landing.html      # Tutorial landing page
│   ├── TUTORIAL.md                # Step-by-step written guide
│   └── SECURITY.md                # Security best practices
├── .env.example                   # Environment variables template
├── README.md                      # This file
└── LICENSE
```

---

## 📚 Tutorial Breakdown

### **Part 1: Solidity Fundamentals** (20 minutes)

- Introduction to Smart Contracts & Solidity
- Setting up Remix IDE
- Basic syntax: pragma, contract structure
- Data types: address, uint, bool
- Your first "Hello World" contract

### **Part 2: Building the Core** (35 minutes)

- Designing the Transfer struct
- Using mappings for storage
- Payable functions & accepting ETH
- Creating the `createTransfer()` function
- Password hashing with `keccak256`
- Time-based logic with `block.timestamp`

### **Part 3: Claim & Refund Logic** (30 minutes)

- Building the `claimTransfer()` function
- Password verification
- Sending ETH: `transfer()` vs `call()`
- Building the `refundTransfer()` function
- Access control implementation
- Error handling with `require()`

### **Part 4: Security & Events** (25 minutes)

- Creating and emitting events
- Building custom modifiers
- Re-entrancy attack prevention
- Checks-Effects-Interactions pattern
- Gas optimization techniques

### **Part 5: Testing & Deployment** (25 minutes)

- Testing in Remix with multiple accounts
- Setting up MetaMask
- Getting testnet ETH
- Deploying to Sepolia testnet
- Verifying contract on Etherscan
- Interacting via Etherscan

### **Part 6: React Frontend** (30-35 minutes) - Optional

- React setup with Vite
- Installing ethers.js/wagmi
- Wallet connection
- Building transfer forms
- Displaying active transfers
- Transaction handling

**Total Time:** 2 hours 15 minutes (core) + 30 minutes (frontend)

---

## 🔧 Smart Contract Overview

### Main Functions

#### `createTransfer(address _recipient, string memory _password, uint256 _deadline)`

Creates a new password-protected transfer.

**Parameters:**

- `_recipient`: Address that can claim the funds
- `_password`: Secret password (will be hashed)
- `_deadline`: Duration in seconds before refund is possible

**Requirements:**

- Must send ETH (value > 0)
- Password cannot be empty
- Deadline must be in the future

**Example:**

```javascript
// Create transfer: 0.1 ETH, password "secret123", 7 days deadline
createTransfer(
  '0x742d35Cc6634C0532925a3b844Bc9e7595f0bEb',
  'secret123',
  604800, // 7 days in seconds
);
```

#### `claimTransfer(uint256 _transferId, string memory _password)`

Claim funds by providing correct password.

**Parameters:**

- `_transferId`: ID of the transfer to claim
- `_password`: Password to unlock funds

**Requirements:**

- Must be the recipient
- Password must match
- Deadline not yet passed
- Transfer not already claimed

**Example:**

```javascript
claimTransfer(0, 'secret123');
```

#### `refundTransfer(uint256 _transferId)`

Refund unclaimed transfer after deadline.

**Parameters:**

- `_transferId`: ID of the transfer to refund

**Requirements:**

- Must be the sender
- Deadline must have passed
- Transfer not already claimed

**Example:**

```javascript
refundTransfer(0);
```

### Events

```solidity
event TransferCreated(
    uint256 indexed transferId,
    address indexed sender,
    address indexed recipient,
    uint256 amount,
    uint256 deadline
);

event TransferClaimed(
    uint256 indexed transferId,
    address indexed recipient,
    uint256 amount
);

event TransferRefunded(
    uint256 indexed transferId,
    address indexed sender,
    uint256 amount
);
```

---

## 🌐 Deployment Guide

### Deploy to Sepolia Testnet

#### Step 1: Get Testnet ETH

1. Visit [Sepolia Faucet](https://sepoliafaucet.com/)
2. Connect your MetaMask wallet
3. Request test ETH (wait 1-2 minutes)

#### Step 2: Deploy via Remix

1. Open Remix IDE
2. Compile `SecretPay.sol`
3. Go to "Deploy & Run Transactions"
4. Select "Injected Provider - MetaMask"
5. Click "Deploy"
6. Confirm transaction in MetaMask

#### Step 3: Verify on Etherscan

1. Copy deployed contract address
2. Go to [Sepolia Etherscan](https://sepolia.etherscan.io)
3. Search for your contract
4. Click "Contract" → "Verify and Publish"
5. Follow verification steps

### Deploy via Hardhat (Advanced)

```bash
# Install Hardhat
npm install --save-dev hardhat

# Create Hardhat project
npx hardhat

# Deploy script
npx hardhat run scripts/deploy.js --network sepolia
```

**Deploy Script Example:**

```javascript
const hre = require('hardhat');

async function main() {
  const SecretPay = await hre.ethers.getContractFactory('SecretPay');
  const secretPay = await SecretPay.deploy();
  await secretPay.deployed();

  console.log('SecretPay deployed to:', secretPay.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
```

---

## 💻 Frontend Integration (Optional)

### Setup React + Vite

```bash
npm create vite@latest secretpay-frontend -- --template react
cd secretpay-frontend
npm install ethers wagmi viem
```

### Connect Wallet Example

```javascript
import { useAccount, useConnect, useDisconnect } from 'wagmi';
import { MetaMaskConnector } from 'wagmi/connectors/metaMask';

function WalletConnect() {
  const { address, isConnected } = useAccount();
  const { connect } = useConnect({
    connector: new MetaMaskConnector(),
  });
  const { disconnect } = useDisconnect();

  if (isConnected) {
    return (
      <div>
        <p>Connected: {address}</p>
        <button onClick={() => disconnect()}>Disconnect</button>
      </div>
    );
  }

  return <button onClick={() => connect()}>Connect Wallet</button>;
}
```

### Create Transfer Example

```javascript
import { useContractWrite } from 'wagmi';
import { parseEther } from 'viem';

function CreateTransfer() {
  const { write } = useContractWrite({
    address: 'YOUR_CONTRACT_ADDRESS',
    abi: SecretPayABI,
    functionName: 'createTransfer',
  });

  const handleSubmit = (e) => {
    e.preventDefault();
    write({
      args: [recipientAddress, password, deadline],
      value: parseEther(amount),
    });
  };

  return <form onSubmit={handleSubmit}>{/* Form fields */}</form>;
}
```

---

## 🔒 Security Considerations

### ✅ Implemented Security Features

1. **Password Hashing**

   - Never stores plain text passwords
   - Uses `keccak256` for one-way hashing
   - Resistant to rainbow table attacks

2. **Re-entrancy Protection**

   - Follows checks-effects-interactions pattern
   - Updates state before external calls
   - No known re-entrancy vulnerabilities

3. **Access Control**
   - Only recipient can claim
   - Only sender can refund
   - Time-based restrictions enforced

### ⚠️ Important Warnings

1. **Passwords are NOT Private**

   ```
   ⚠️ Anyone can see the password hash on-chain
   ⚠️ If someone knows possible passwords, they can brute force
   ⚠️ Don't use this for high-value transfers in production
   ```

2. **Block Timestamp Manipulation**

   ```
   ⚠️ Miners can manipulate timestamps by ~15 seconds
   ⚠️ Don't rely on exact deadline precision
   ⚠️ Use block numbers for critical timing
   ```

3. **Gas Limitations**
   ```
   ⚠️ `transfer()` has 2300 gas limit
   ⚠️ May fail with smart contract recipients
   ⚠️ Consider using `call()` for production
   ```

### 🛡️ Production Improvements

For production use, consider:

- **Commit-Reveal Scheme:** Two-step password submission
- **Multi-Signature:** Require multiple parties to approve
- **Upgradeable Contracts:** Use proxy patterns for bug fixes
- **Professional Audit:** Get code reviewed by security experts
- **Emergency Pause:** Add circuit breaker functionality

---

## 🧪 Testing

### Manual Testing in Remix

```solidity
// Test Scenario 1: Successful Transfer & Claim
1. Deploy contract with Account A
2. Create transfer to Account B (0.1 ETH, password: "test123")
3. Switch to Account B
4. Claim transfer with password "test123"
5. Verify Account B received ETH

// Test Scenario 2: Wrong Password
1. Create transfer to Account C (0.1 ETH, password: "secret")
2. Switch to Account C
3. Try claiming with wrong password "wrong"
4. Verify transaction reverts

// Test Scenario 3: Refund After Deadline
1. Create transfer with 60 second deadline
2. Wait 60 seconds
3. Call refund as sender
4. Verify sender received ETH back
```

### Automated Testing (Hardhat)

```javascript
const { expect } = require('chai');
const { ethers } = require('hardhat');

describe('SecretPay', function () {
  let secretPay;
  let owner, recipient;

  beforeEach(async function () {
    [owner, recipient] = await ethers.getSigners();
    const SecretPay = await ethers.getContractFactory('SecretPay');
    secretPay = await SecretPay.deploy();
  });

  it('Should create a transfer', async function () {
    await secretPay.createTransfer(recipient.address, 'password123', 86400, {
      value: ethers.utils.parseEther('0.1'),
    });

    const transfer = await secretPay.transfers(0);
    expect(transfer.amount).to.equal(ethers.utils.parseEther('0.1'));
  });

  it('Should allow claim with correct password', async function () {
    await secretPay.createTransfer(recipient.address, 'password123', 86400, {
      value: ethers.utils.parseEther('0.1'),
    });

    await secretPay.connect(recipient).claimTransfer(0, 'password123');
    const transfer = await secretPay.transfers(0);
    expect(transfer.claimed).to.be.true;
  });

  it('Should reject claim with wrong password', async function () {
    await secretPay.createTransfer(recipient.address, 'password123', 86400, {
      value: ethers.utils.parseEther('0.1'),
    });

    await expect(
      secretPay.connect(recipient).claimTransfer(0, 'wrongpassword'),
    ).to.be.revertedWith('Incorrect password');
  });
});
```

---

## ⚡ Gas Optimization

### Current Implementation

- **createTransfer:** ~90,000 gas
- **claimTransfer:** ~45,000 gas
- **refundTransfer:** ~35,000 gas

### Optimization Tips

1. **Use uint256 instead of uint8**

   ```solidity
   // Less gas (counterintuitively!)
   uint256 public transferCount;
   ```

2. **Pack struct variables**

   ```solidity
   struct Transfer {
       address sender;      // 20 bytes
       address recipient;   // 20 bytes
       uint96 amount;       // 12 bytes (fits in same slot!)
       // ... rest of struct
   }
   ```

3. **Use events instead of storage**

   ```solidity
   // Don't store if you only need history
   emit TransferCreated(id, sender, recipient, amount);
   ```

4. **Batch operations**
   ```solidity
   // Create multiple transfers in one transaction
   function createMultipleTransfers(...) external payable {
       // Saves deployment overhead
   }
   ```

---

## 🐛 Common Issues & Solutions

### Issue 1: "Transaction Reverted"

**Cause:** Not sending enough ETH with `createTransfer()`

**Solution:**

```javascript
// In Remix, set "Value" field before calling function
// In ethers.js:
await contract.createTransfer(recipient, password, deadline, {
  value: ethers.utils.parseEther('0.1'),
});
```

### Issue 2: "Incorrect Password"

**Cause:** Password case sensitivity or extra spaces

**Solution:**

```javascript
// Passwords are case-sensitive!
"Secret123" ≠ "secret123"

// Trim spaces
password.trim()
```

### Issue 3: "Deadline Not Passed"

**Cause:** Trying to refund before deadline

**Solution:**

```javascript
// Check current time
const now = Math.floor(Date.now() / 1000);
const deadline = await contract.transfers(0).deadline;
console.log(`Wait ${deadline - now} more seconds`);
```

### Issue 4: "Not the Recipient"

**Cause:** Wrong account trying to claim

**Solution:**

```javascript
// Switch MetaMask account to recipient address
// Or in Remix, select correct account from dropdown
```

---

## 🤝 Contributing

We welcome contributions! Here's how you can help:

### Types of Contributions

- 🐛 Bug fixes
- ✨ New features
- 📖 Documentation improvements
- 🎨 UI/UX enhancements
- 🧪 Additional tests
- 🌍 Translations

### How to Contribute

1. **Fork the repository**

   ```bash
   git clone https://github.com/cwtofficial/SecretPay.git
   ```

2. **Create a feature branch**

   ```bash
   git checkout -b feature/amazing-feature
   ```

3. **Make your changes**

   ```bash
   # Edit files
   git add .
   git commit -m "Add amazing feature"
   ```

4. **Push to your fork**

   ```bash
   git push origin feature/amazing-feature
   ```

5. **Open a Pull Request**
   - Go to original repository
   - Click "New Pull Request"
   - Describe your changes

### Code Style

- Use 4 spaces for indentation
- Follow Solidity style guide
- Comment complex logic
- Write descriptive variable names

---

## 📚 Resources

### Official Documentation

- [Solidity Docs](https://docs.soliditylang.org/)
- [Remix IDE](https://remix.ethereum.org/)
- [Ethers.js Docs](https://docs.ethers.org/)
- [MetaMask Docs](https://docs.metamask.io/)

### Learning Resources

- [CryptoZombies](https://cryptozombies.io/) - Interactive Solidity tutorial
- [Solidity by Example](https://solidity-by-example.org/) - Code examples
- [OpenZeppelin](https://docs.openzeppelin.com/) - Secure contract templates
- [Ethereum.org](https://ethereum.org/en/developers/) - Developer portal

### Tools

- [Remix IDE](https://remix.ethereum.org/) - Browser-based IDE
- [Hardhat](https://hardhat.org/) - Development environment
- [Etherscan](https://etherscan.io/) - Blockchain explorer
- [Sepolia Faucet](https://sepoliafaucet.com/) - Get test ETH

### Community

- [CodeWithTy Discord](https://discord.com/invite/THq8mTmX) - Get help with the tutorial

---

## 📊 Project Stats

- ⭐ **Difficulty:** Beginner
- ⏱️ **Time to Complete:** 2-2.5 hours
- 📝 **Lines of Code:** ~150 (contract only)
- 🔧 **Technologies:** Solidity 0.8.0+, Remix, MetaMask
- 🎯 **Concepts Covered:** 8 core Solidity patterns

---

## 🎓 What You'll Learn

By completing this tutorial, you will:

- ✅ Understand how smart contracts work
- ✅ Write, compile, and deploy Solidity code
- ✅ Handle cryptocurrency transactions (ETH)
- ✅ Implement cryptographic hashing
- ✅ Build time-based escrow logic
- ✅ Create access control systems
- ✅ Emit and listen to events
- ✅ Follow security best practices
- ✅ Deploy to live testnet
- ✅ Interact with contracts via Etherscan
- ✅ (Optional) Build React dApp frontend

---

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

```
MIT License

Copyright (c) 2025 CodeWithTy

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
```

---

## 🙏 Acknowledgments

- **Ethereum Foundation** - For building the blockchain
- **OpenZeppelin** - For security best practices
- **Remix Team** - For the amazing IDE
- **Solidity Community** - For educational resources
- **All Contributors** - Thank you for improving this tutorial!

---

## 📞 Support

### Need Help?

- 📺 **Watch the video tutorial:** [YouTube](https://youtube.com/@officialcwt)
- 💬 **Join Discord:** [CodeWithTy Community](https://discord.com/invite/THq8mTmX)
- 🐛 **Report bugs:** [GitHub Issues](https://github.com/cwtofficial/secretpay/issues)
- 📧 **Email:** hello@cwt.build
- 🌐 **Website:** [cwt.build](https://cwt.build)

### FAQ

**Q: Do I need cryptocurrency to start?**  
A: No! We use free testnet ETH for learning. No real money required.

**Q: How long does the tutorial take?**  
A: 2-2.5 hours for the core contract + 30 minutes for optional frontend.

**Q: Can I use this in production?**  
A: This is for educational purposes. See [Security Considerations](#security-considerations) before using in production.

**Q: What if I get stuck?**  
A: Join our Discord community, comment on the YouTube video, or open a GitHub issue!

**Q: Can I modify the code?**  
A: Absolutely! This is MIT licensed - modify, extend, and share!

---

## 🚀 Next Steps

After completing this tutorial, try:

1. **Add features:**

   - Multiple recipients
   - Partial refunds
   - Password hints system
   - ERC20 token support

2. **Build similar projects:**

   - Voting system
   - Crowdfunding platform
   - NFT marketplace
   - DAO governance

3. **Go deeper:**

   - Learn Hardhat for testing
   - Study gas optimization
   - Explore Layer 2 solutions
   - Get a security audit

4. **Share your work:**
   - Deploy to mainnet
   - Write a blog post
   - Create a video walkthrough
   - Help others learn!

---

## ⭐ Star This Repo!

If this tutorial helped you, please star the repository to help others find it!

[![Star on GitHub](https://img.shields.io/github/stars/cwtofficial/SecretPay?style=social)](https://github.com/cwtofficial/SecretPay)

---

**Built with 💜 by [CWT](https://cwt.build)**

_Techcrafting Ideas..._

---

**Happy Coding! 🚀**

_Questions? Reach out anytime - we're here to help!_
