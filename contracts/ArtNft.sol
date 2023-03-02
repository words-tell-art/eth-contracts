//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "./opensea/ERC721Tradable.sol";
import "./NFT.sol";
import "./interfaces/IERC721Drop.sol";
import "./InputVerifier.sol";

contract ArtNft is NFT, InputVerifier {
    event MergeEvent(uint256 idMerged, uint256 idBurned);

    struct Data {
        string w1;
        string w2;
        string w3;
        string w4;
        string w5;
    }

    IERC721Drop _wordNft;
    mapping(uint256 => Data) private _nfts;

    constructor(address wordNft, address proxyRegistryAddress, address signer) NFT("Words Tell Art", "ART", proxyRegistryAddress) InputVerifier(signer) {
        _wordNft = IERC721Drop(wordNft);
    }

    function craft(uint256[] memory wordIs, string memory w1, string memory w2, string memory w3, string memory w4, string memory w5, bytes memory signature) external {
        require(_wordNft.isApprovedForAll(_msgSender(), address(this)), "ART contract not approved");
        bytes32 messageHash = keccak256(abi.encodePacked(wordIs, w1, w2, w3, w4, w5));
        _verifyMessage(messageHash, signature);
        address caller = _wordNft.ownerOf(wordIs[0]);
        uint max = wordIs.length;
        for (uint i = 0; i < max; i++) {
            _wordNft.burn(wordIs[i]);
        }
        _mintTo(caller);
    }

    function merge(uint256 art1, uint256 art2) external {
        require(_isApprovedOrOwner(msg.sender, art1), "Caller is not token owner");
        burn(art2);
        _nfts[art1].w2 = _nfts[art2].w2;
        _nfts[art1].w4 = _nfts[art2].w4;
        emit MergeEvent(art1, art2);
    }

    function setSigner(address signer) external onlyMaintainer {
        _setSigner(signer);
    }
}
