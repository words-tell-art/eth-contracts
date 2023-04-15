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
        art_address: "0xe4A4786956B7643b05642f3c3fE10d9298c65E48",
        //art_address: "0x135C5cEC37294B70C4C5a8F9bc60a246080e5102"
    },
    eth: {
        art_address: ""
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
    const ArtNft = await hre.ethers.getContractFactory("ArtNFT");
    const artNft = await ArtNft.attach(config.art_address);
    console.log("ArtNft: ", artNft.address);

    const resp2 = await artNft.merge(1, 7);
    console.log("Art merge done: ", resp2);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
