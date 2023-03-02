// const { describe, beforeEach, it } = require('mocha');
const { expect } = require("chai");
const { ethers, upgrades} = require("hardhat");

function getTokenId(modelId, number) {
  return (modelId * (2 ** 32)) + number
}

describe("ART NFT", function () {

});
