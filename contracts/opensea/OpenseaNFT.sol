//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./ERC721Tradable.sol";
import "../utils/Maintainer.sol";

contract OpenseaNFT is ERC721Tradable, Maintainer {
    string private __baseURI;
    string private __contractBaseURI;

    constructor(string memory _name, string memory _symbol, address _proxyRegistryAddress) ERC721Tradable(_name, _symbol, _proxyRegistryAddress) Maintainer() {}

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

    function airdrop(address user, uint256 quantity) external onlyMaintainer {
        for (uint256 i = 0; i < quantity; i++) {
            _mintTo(user);
        }
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
}