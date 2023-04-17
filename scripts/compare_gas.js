// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

// Constants
const network_configs = {
    goerli: {
        art_address1: "0xe4A4786956B7643b05642f3c3fE10d9298c65E48",
        art_address2: "0x135C5cEC37294B70C4C5a8F9bc60a246080e5102",
        art_address3: "0x235B61EF53403368BC4B975134d8d7a33a1e7508",
        art_address4: "0xe7415bb81bE6d9683F2b4D317c6268156771c6C5",
        art_address5: "0xe7415bb81bE6d9683F2b4D317c6268156771c6C5",
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
        throw "not supported"
    }

    console.log("Network: ", hre.network.name)
    const ArtNft1 = await hre.ethers.getContractFactory("ArtNFT2");
    const artNft1 = await ArtNft1.attach(config.art_address1);
    console.log("ArtNft1: ", artNft1.address);
    const ArtNft2 = await hre.ethers.getContractFactory("ArtNFT");
    const artNft2 = await ArtNft2.attach(config.art_address2);
    console.log("ArtNft2: ", artNft2.address);
    const ArtNft3 = await hre.ethers.getContractFactory("ArtNFT3");
    const artNft3 = await ArtNft3.attach(config.art_address3);
    console.log("ArtNft3: ", artNft3.address);
    const ArtNft4 = await hre.ethers.getContractFactory("ArtNFT4");
    const artNft4 = await ArtNft4.attach(config.art_address4);
    console.log("ArtNft4: ", artNft4.address);

    const g1 = await artNft1.estimateGas.craft([41, 43, 45, 50, 52])
    console.log("Art1: ", g1);
    const g2 = await artNft2.estimateGas.craft([41, 43, 45, 50, 52])
    console.log("Art2: ", g2);
    const g3 = await artNft3.estimateGas.craft([41, 43, 45, 50, 52])
    console.log("Art3: ", g3);
    const g4 = await artNft4.estimateGas.craft([41, 43, 45, 50, 52])
    console.log("Art4: ", g4);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
