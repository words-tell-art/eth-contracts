//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Pausable.sol";
import "./utils/Maintainer.sol";

contract NFT is ERC721, ERC721Burnable, ERC721Pausable, Maintainer {
    string internal __baseURI;
    string internal __contractBaseURI;

    constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) Maintainer() {}

    function contractURI() public view returns (string memory) {
        return __contractBaseURI;
    }

    // override views
    function _baseURI() internal view override(ERC721) returns (string memory) {
        return __baseURI;
    }

    function setBaseURI(string memory newBaseURI) external onlyMaintainer {
        __baseURI = newBaseURI;
    }

    // public functions
    // batch transfer all the tokens to a same address
    function safeTransferFromBatch(
        address from,
        address to,
        uint256[] calldata tokenIds
    ) external {
        for (uint256 i = 0; i < tokenIds.length; i++) {
            safeTransferFrom(from, to, tokenIds[i]);
        }
    }

    // batch transfer tokens to different addresses
    function safeTransferFromToAddresses(
        address from,
        address[] calldata receivers,
        uint256[] calldata tokenIds
    ) external {
        for (uint256 i = 0; i < receivers.length; i++) {
            safeTransferFrom(from, receivers[i], tokenIds[i]);
        }
    }

    function pause() external onlyMaintainer {
        _pause();
    }

    function unpause() external onlyMaintainer {
        _unpause();
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId,
        uint256 batchSize
    ) internal override(ERC721, ERC721Pausable) {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }
}