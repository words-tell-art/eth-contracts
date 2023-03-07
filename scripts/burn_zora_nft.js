// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

// Constants
const network_configs = {
    goerli: {
        contract_address: "0x23cb09531b6f604F5A4b05E03235082Bede0Ce6f",
    },
    eth : {
        contract_address: "",
    },
}
let config;

async function main() {
    // Hardhat always runs the compile task when running scripts with its command
    // line interface.
    //
    // If this script is run directly using `node` you may want to call compile
    // manually to make sure everything is compiled
    // await hre.run('compile');

    // We get the Assets contract to deploy
    if (hre.network.name === "goerli") {
        config = network_configs.goerli
    } else {
        config = network_configs.eth
    }
    console.log("Network: ", hre.network.name)

    const WordNft = await hre.ethers.getContractAt("IERC721Drop", "0x8186b1b1397acd543a990347b01d5ccf29490a66");
    console.log("Word: ", WordNft)
    const burn = await WordNft.burn(4);
    console.log("WordNft burn?", burn);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
