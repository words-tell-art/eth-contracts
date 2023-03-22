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

# Hardhat
### Build contract
```
npx hardhat compile
```

# Deployment
### Deploy to mainnet
```
npx hardhat --network mainnet run scripts/word_deploy.js
```

### Deploy to Goerli testnet
```
npx hardhat --network goerli run scripts/word_deploy.js
```

## Deployed contract addresses
### Mainnet deployed contract addresses:
- WORD [Zora] deployed to: `0xd5e5a0d5ad5048af6e0f9479603eacbdbcf400ce`
- ART [custom] deployed to: ``
### Goerli deployed contract addresses:
- WORD [Zora] deployed to: `0x8186b1b1397acd543a990347b01d5ccf29490a66`
- ART [custom] deployed to: `0xe4A4786956B7643b05642f3c3fE10d9298c65E48`
