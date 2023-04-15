//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ArtNFT is ERC721, Ownable {
    string __baseURI;
    string __contractBaseURI;
    address burnAddress = 0x000000000000000000000000000000000000dEaD;
    IERC721 _wordNft;

    event CraftEvent(uint256 id, uint256[] idBurned);
    event MergeEvent(uint256 id, uint256 idBurned);

    constructor(address wordNft, string memory metadata, string memory contractMetadata) ERC721("Words Tell Art", "ART") {
        _wordNft = IERC721(wordNft);
        __baseURI = metadata;
        __contractBaseURI = contractMetadata;
    }

    function contractURI() public view returns (string memory) {
        return __contractBaseURI;
    }

    function _baseURI() internal view override(ERC721) returns (string memory) {
        return __baseURI;
    }

    function setBaseURI(string memory newBaseURI) external onlyOwner {
        __baseURI = newBaseURI;
    }

    function craft(uint256[] memory wordIs) external {
        require(_wordNft.isApprovedForAll(_msgSender(), address(this)), "not approved");
        require(wordIs.length >= 2, "missing words");
        uint max = wordIs.length;
        for (uint i = 0; i < max; i++) {
            _wordNft.safeTransferFrom(_msgSender(), burnAddress, wordIs[i]);
        }
        _safeMint(_msgSender(), wordIs[0]);
        emit CraftEvent(wordIs[0], wordIs);
    }

    function merge(uint256 art1, uint256 art2) external {
        require(_isApprovedOrOwner(_msgSender(), art1), "not owner");
        safeTransferFrom(_msgSender(), burnAddress, art2);
        emit MergeEvent(art1, art2);
    }
}
