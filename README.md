# Ethereum contracts
NFT & Opensea Store Contracts

# Setup
```
npm install
```

## Environment
### .env
```dotenv
ETHERSCAN_API_KEY=
PRIVATE_KEY=
```
Export your ETH private key from your wallet and put it next PRIVATE_KEY=
Etherscan api key is optional, it is used to validate the contract on etherscan after it is deployed.

# Deployment
### Deploy to mainnet
npx hardhat --network mainnet run scripts/word_deploy.js
### Deploy to Goerli testnet
npx hardhat --network goerli run scripts/word_deploy.js

## Deployed contract addresses
### Mainnet deployed contract addresses:
- WORDs deployed to: ``
- ARTs deployed to: ``
### Goerli deployed contract addresses:
- WORDs deployed to: ``
- WORDs deployed to: `0x23cb09531b6f604F5A4b05E03235082Bede0Ce6f`
