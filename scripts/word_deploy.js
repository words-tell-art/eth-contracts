// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

// Constants
const network_configs = {
  goerli: {
    proxyRegistryAddress: "0x1E525EEAF261cA41b809884CBDE9DD9E1619573A",
    metadata_uri: "http://words.dlab.ovh/metadata/",
  },
  eth : {
    proxyRegistryAddress: "0x1E525EEAF261cA41b809884CBDE9DD9E1619573A",
    metadata_uri: "http://words.dlab.ovh/metadata/",
  },
}
let config;

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  await hre.run('compile');

  // We get the Assets contract to deploy
  if (hre.network.name === "goerli") {
    config = network_configs.goerli
  } else {
    config = network_configs.eth
  }

  console.log("Network: ", hre.network.name)
  console.log("Metadata URI: ", config.metadata_uri)

  const WordNft = await hre.ethers.getContractFactory("WordNft");
  const wordNft = await WordNft.deploy(config.proxyRegistryAddress);
  await wordNft.deployed();


  console.log("WordNft deployed to:", wordNft.address);
  await wordNft.setBaseURI(config.metadata_uri);
  console.log("WordNft metadata added: ", config.metadata_uri);
  await wordNft.addMaintainer("0x5FbDB2315678afecb367f032d93F642f64180aa3");
  console.log("WordNft maintainer added: ", "0x5FbDB2315678afecb367f032d93F642f64180aa3");

  await wordNft.deployTransaction.wait(3);
  // verify the contracts
  await hre.run("verify:verify", {
    address: wordNft.address,
    contract: "contracts/WordNft.sol:WordNft",
    constructorArguments: [config.proxyRegistryAddress],
  });
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
