//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ArtNFT4 is ERC721, Ownable {
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

    function craft(uint256[] memory wordIds) external {
        require(wordIds[0] != 0, "missing word1");
        require(wordIds[1] != 0, "missing word2");
        _wordNft.safeTransferFrom(_msgSender(), burnAddress, wordIds[0]);
        _wordNft.safeTransferFrom(_msgSender(), burnAddress, wordIds[1]);
        if (wordIds[2] != 0) {
            _wordNft.safeTransferFrom(_msgSender(), burnAddress, wordIds[2]);
        }
        if (wordIds[3] != 0) {
            _wordNft.safeTransferFrom(_msgSender(), burnAddress, wordIds[3]);
        }
        if (wordIds[4] != 0) {
            _wordNft.safeTransferFrom(_msgSender(), burnAddress, wordIds[4]);
        }
        _safeMint(_msgSender(), wordIds[0]);
        emit CraftEvent(wordIds[0], wordIds);
    }

    function merge(uint256 art1, uint256 art2) external {
        require(_isApprovedOrOwner(_msgSender(), art1), "not owner");
        safeTransferFrom(_msgSender(), burnAddress, art2);
        emit MergeEvent(art1, art2);
    }
}
