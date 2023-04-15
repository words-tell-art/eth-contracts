//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "./NFT.sol";
import "@openzeppelin/contracts/interfaces/IERC721.sol";

contract ArtNFT2 is NFT {
    event CraftEvent(uint256 id, uint256[] idBurned);
    event MergeEvent(uint256 id, uint256 idBurned);

    address burnAddress = 0x000000000000000000000000000000000000dEaD;
    IERC721 _wordNft;

    constructor(address wordNft, string memory metadata, string memory contractMetadata) NFT("Words Tell Art", "ART") {
        _wordNft = IERC721(wordNft);
        __baseURI = metadata;
        __contractBaseURI = contractMetadata;
    }

    function craft(uint256[] memory wordIs) external {
        require(_wordNft.isApprovedForAll(_msgSender(), address(this)), "ART contract not approved");
        require(wordIs.length >= 2, "Require at least 2 words.");
        uint max = wordIs.length;
        for (uint i = 0; i < max; i++) {
            _wordNft.safeTransferFrom(msg.sender, burnAddress, wordIs[i]);
        }
        _safeMint(msg.sender, wordIs[0]);
        emit CraftEvent(wordIs[0], wordIs);
    }

    function merge(uint256 art1, uint256 art2) external {
        require(_isApprovedOrOwner(msg.sender, art1), "Caller is not token owner");
        burn(art2);
        emit MergeEvent(art1, art2);
    }
}
