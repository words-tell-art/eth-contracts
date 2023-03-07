//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "./NFT.sol";
import "./interfaces/IERC721Drop.sol";

contract ArtNft is NFT {
    event CraftEvent(uint256 idCraft, uint256 idBurned, uint256 idBurned2, uint256 idBurned3, uint256 idBurned4, uint256 idBurned5);
    event MergeEvent(uint256 idMerged, uint256 idBurned);

    IERC721Drop _wordNft;

    constructor(address wordNft, address proxyRegistryAddress) NFT("Words Tell Art", "ART", proxyRegistryAddress) {
        _wordNft = IERC721Drop(wordNft);
    }

    function craft(uint256 w1, uint256 w2, uint256 w3, uint256 w4, uint256 w5) external {
        require(_wordNft.isApprovedForAll(_msgSender(), address(this)), "ART contract not approved");
        uint max = wordIs.length;
        for (uint i = 0; i < max; i++) {
            _wordNft.burn(wordIs[i]);
        }
        _mintTo(msg.sender, w1);
        emit CraftEvent(w1, w1, w2, w3, w4, w5);
    }

    function _mintTo(address _to, uint256 _tokenId) internal override {
        _safeMint(_to, _tokenId);
    }

    function merge(uint256 art1, uint256 art2) external {
        require(_isApprovedOrOwner(msg.sender, art1), "Caller is not token owner");
        burn(art2);
        emit MergeEvent(art1, art2);
    }
}
