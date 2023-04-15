// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

// Constants
const network_configs = {
  goerli: {
    word_address: "0x8186b1b1397acd543a990347b01d5ccf29490a66",
    metadata_uri: "https://metadata.dlab.ovh/api/metadata/ethereum/words-tell-art-craft-test/",
    contract_metadata_uri: "https://metadata.dlab.ovh/api/metadata/ethereum/words-tell-art-craft-test",
  },
  sepolia: {
    word_address: "0x8186b1b1397acd543a990347b01d5ccf29490a66",
    metadata_uri: "https://metadata.dlab.ovh/api/metadata/ethereum/words-tell-art-craft-test/",
    contract_metadata_uri: "https://metadata.dlab.ovh/api/metadata/ethereum/words-tell-art-craft-test"
  },
  eth : {
    word_address: "0xd5e5a0d5ad5048af6e0f9479603eacbdbcf400ce",
    metadata_uri: "https://metadata.dlab.ovh/api/metadata/ethereum/words-tell-art-craft/",
    contract_metadata_uri: "https://metadata.dlab.ovh/api/metadata/ethereum/words-tell-art-craft"
  },
}
let config;
let contractName = "ArtNFT"

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  await hre.run('compile');

  // We get the Assets contract to deploy
  if (network_configs[hre.network.name] != null) {
    config = network_configs[hre.network.name]
  } else {
    config = network_configs.eth
  }

  console.log("Network: ", hre.network.name)
  console.log("Metadata URI: ", config.metadata_uri)

  const ArtNft = await hre.ethers.getContractFactory(contractName);
  const artNft = await ArtNft.deploy(config.word_address, config.metadata_uri, config.contract_metadata_uri);
  await artNft.deployed();

  console.log("ArtNft deployed to:", artNft.address);

  await artNft.deployTransaction.wait(3);
  // verify the contracts
  await hre.run("verify:verify", {
    address: artNft.address,
    contract: `contracts/${contractName}.sol:${contractName}`,
    constructorArguments: [config.word_address, config.metadata_uri, config.contract_metadata_uri],
  });
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
