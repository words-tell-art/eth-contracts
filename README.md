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
npx hardhat --network mainnet run scripts/art_deploy.js
```

### Deploy to Goerli testnet
```
npx hardhat --network goerli run scripts/art_deploy.js
```

## Deployed contract addresses
### Mainnet deployed contract addresses:
- WORD [Zora] deployed to: `0xd5e5a0d5ad5048af6e0f9479603eacbdbcf400ce`
- ART [custom] deployed to: `0x29434F7628864Ef44fc6Ce20A2f9D28f90Bb85ac`
### Goerli deployed contract addresses:
- WORD [Zora] deployed to: `0x8186b1b1397acd543a990347b01d5ccf29490a66`
- ART [custom] deployed to: `0xe4A4786956B7643b05642f3c3fE10d9298c65E48`

### Dev envs
Art: 0x135C5cEC37294B70C4C5a8F9bc60a246080e5102
Art2: 0xe4A4786956B7643b05642f3c3fE10d9298c65E48
Art3: 0x235B61EF53403368BC4B975134d8d7a33a1e7508
Art4: 0xe7415bb81bE6d9683F2b4D317c6268156771c6C5
