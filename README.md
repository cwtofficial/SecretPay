# 🔐 SecretPay: Password-Protected ETH Transfers

[![Solidity](https://img.shields.io/badge/Solidity-0.8.28-363636?logo=solidity)](https://soliditylang.org/)
[![Foundry](https://img.shields.io/badge/Built%20with-Foundry-orange)](https://book.getfoundry.sh/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Tests](https://img.shields.io/badge/Tests-Passing-brightgreen)]()

> A production-ready decentralized escrow smart contract where senders can transfer ETH to recipients locked behind a password. Recipients must know the secret password to claim their ETH. If unclaimed by the deadline, senders can withdraw their funds back.

**Built with ❤️ by [CWT (CWT)](https://cwt.build)**

---

## 🎯 What is SecretPay?

SecretPay is a Solidity-based smart contract that enables secure, password-protected Ethereum transfers with escrow functionality. Perfect for gifts, freelance payments, educational rewards, and gaming treasure hunts.

### ✨ Key Features

- **🔒 Password Protection** - Transfers are secured with cryptographic hashing (keccak256)
- **⏰ Time-Based Escrow** - Set custom deadlines for fund claims
- **💸 Automatic Refunds** - Senders can reclaim funds after deadline expiry
- **🔐 Security First** - Re-entrancy protection and comprehensive testing
- **📊 Event Logging** - Full transparency with on-chain event emissions
- **✅ 100% Test Coverage** - Professional test suite included

---

## 🚀 Quick Start

### Prerequisites

- Basic programming knowledge (JavaScript, Python, or similar)
- [Foundry](https://book.getfoundry.sh/getting-started/installation) installed
- [MetaMask](https://metamask.io/) wallet (for testnet deployment)
- Testnet ETH from [Sepolia Faucet](https://sepoliafaucet.com/)

### Installation

```bash
# Clone the repository
git clone https://github.com/cwtofficial/secretpay.git
cd secretpay

# Install dependencies
forge install

# Build the project
forge build
```

### Run Tests

```bash
# Run all tests
forge test

# Run tests with detailed output
forge test -vvvv

# Run tests with gas reporting
forge test --gas-report

# Run specific test
forge test --match-test testClaimTransferSuccess
```

### Deploy to Sepolia Testnet

```bash
# Set environment variables
export PRIVATE_KEY=your_private_key_here
export SEPOLIA_RPC_URL=your_sepolia_rpc_url

# Deploy
forge script script/DeploySecretPay.s.sol:DeploySecretPay \
    --rpc-url $SEPOLIA_RPC_URL \
    --private-key $PRIVATE_KEY \
    --broadcast \
    --verify
```

---

## 📚 How It Works

### 1️⃣ Create a Password-Protected Transfer

```solidity
// Sender creates a transfer with password "secret123"
secretPay.createTransfer{value: 1 ether}(
    receiverAddress,
    keccak256(abi.encodePacked("secret123")),
    7 days  // deadline
);
```

### 2️⃣ Recipient Claims with Correct Password

```solidity
// Receiver claims by providing the password
secretPay.claimTransfer(transferId, "secret123");
```

### 3️⃣ Sender Refunds After Deadline (if unclaimed)

```solidity
// Sender reclaims funds after deadline passes
secretPay.refundTransfer(transferId);
```

---

## 🏗️ Project Structure

```
secretpay/
├── src/
│   └── SecretPay.sol          # Main smart contract
├── test/
│   └── SecretPay.t.sol        # Comprehensive test suite
├── script/
│   └── DeploySecretPay.s.sol  # Deployment script
├── lib/                       # Foundry dependencies
├── foundry.toml               # Foundry configuration
└── README.md
```

---

## 🧪 Testing

SecretPay includes a professional test suite covering:

- ✅ **Happy Path Tests** - Successful transfers, claims, and refunds
- ❌ **Failure Scenarios** - Wrong passwords, premature refunds, unauthorized access
- 🔄 **Edge Cases** - Duplicate transfers, expired deadlines, zero amounts
- 🛡️ **Security Tests** - Re-entrancy attack simulations
- 📊 **Event Emissions** - Verifying all events are properly emitted
- 🎲 **Fuzz Testing** - Random input validation

### Test Coverage

```bash
# Generate coverage report
forge coverage

# View detailed coverage
forge coverage --report lcov
```

---

## 🔐 Security Features

### Password Hashing
Passwords are never stored in plain text. SecretPay uses `keccak256` to hash passwords on-chain, ensuring security.

```solidity
bytes32 passwordHash = keccak256(abi.encodePacked(password));
```

### Re-entrancy Protection
Follows the Checks-Effects-Interactions pattern to prevent re-entrancy attacks:

```solidity
// 1. Checks
require(transfer.isClaimed == false, "Already claimed");

// 2. Effects
transfer.isClaimed = true;

// 3. Interactions
payable(msg.sender).transfer(amount);
```

### Access Control
Strict validation ensures only authorized parties can perform actions:
- Only the designated receiver can claim funds
- Only the original sender can request refunds
- Refunds only allowed after deadline expiry

---

## 🎓 Educational Tutorial

This project is part of a comprehensive **7-part tutorial series** covering:

1. **Solidity Fundamentals** - Syntax, state variables, data types
2. **Core Contract Structure** - Structs, mappings, payable functions
3. **Claim & Refund Logic** - Password verification, ETH transfers
4. **Events & Security** - Event emissions, modifiers, best practices
5. **Professional Setup** - Foundry installation and project structure
6. **Deployment & Verification** - Testnet deployment, Etherscan verification
7. **Professional Testing** - Comprehensive test suite with Foundry

### 📺 Watch the Full Tutorial

[👉 Watch on YouTube - CWT](https://youtube.com/@officialcwt)

---

## 💡 Real-World Use Cases

| Use Case | Description |
|----------|-------------|
| 🎁 **Crypto Gifts with Riddles** | Send ETH with a fun riddle as the password |
| 💼 **Freelance Escrow** | Release payment when work is completed |
| 🎓 **Educational Rewards** | Students earn crypto by solving challenges |
| 🎮 **Gaming Treasure Hunts** | Hide crypto rewards in game quests |
| 💝 **Birthday Surprises** | Send crypto gifts that unlock on a specific date |
| 🤝 **Conditional Payments** | Release funds when conditions are met |

---

## 🛠️ Built With Foundry

**Foundry** is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.

### Foundry Tools Used:

- **Forge** - Ethereum testing framework (like Truffle, Hardhat)
- **Cast** - Swiss army knife for interacting with EVM smart contracts
- **Anvil** - Local Ethereum node for development
- **Chisel** - Fast Solidity REPL

### Useful Commands

```bash
# Compile contracts
forge build

# Run tests
forge test

# Format code
forge fmt

# Gas snapshots
forge snapshot

# Start local node
anvil

# Interact with contracts
cast <subcommand>

# Help
forge --help
anvil --help
cast --help
```

---

## 📖 Documentation

- [Foundry Book](https://book.getfoundry.sh/)
- [Solidity Documentation](https://docs.soliditylang.org/)
- [Ethereum Development Docs](https://ethereum.org/en/developers/docs/)

---

## 🤝 Contributing

Contributions are welcome! Feel free to open issues or submit pull requests.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the CWT License.

---

## 🌟 Support the Project

If you found this project helpful:

- ⭐ Star this repository
- 📺 [Subscribe to CWT on YouTube](https://youtube.com/@officialcwt)
- 🐦 Follow on Twitter [@CWT](https://twitter.com/cwtofficial_)
- 🌐 Visit [CWT.build](https://cwt.build) for more projects

---

## 📞 Contact & Support

**Built by CWT (CWT)**

- 🌐 Website: [cwt.build](https://cwt.build)
- 📺 YouTube: [@officialcwt](https://youtube.com/@officialcwt)
- 💼 GitHub: [@cwtofficial](https://github.com/cwtofficial)
- 📧 Email: contact@cwt.build

---

## ⚠️ Disclaimer

This project is for educational purposes. Always conduct thorough security audits before deploying smart contracts to mainnet with real funds.

---

<div align="center">

**Made with 💜 by [CWT](https://cwt.build)**

*Complete Smart Contract Development Workflow: Code → Deploy → Test*

</div>