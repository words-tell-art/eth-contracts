//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "./opensea/ERC721Tradable.sol";
import "./NFT.sol";

contract WordNft is NFT {

    event MergeEvent(uint256 idMerged, uint256 idBurned);

    struct Data {
        string w1;
        string w2;
        string w3;
        string w4;
        string w5;
    }

    mapping(uint256 => Data) private nfts;

    constructor(address _proxyRegistryAddress) NFT("Words Tell Art - Origin", "WORDS", _proxyRegistryAddress){}

    function merge(uint256 art1, uint256 art2) external {
        require(_isApprovedOrOwner(msg.sender, art1), "Caller is not token owner");
        burn(art2);
        nfts[art1].w2 = nfts[art2].w2;
        nfts[art1].w4 = nfts[art2].w4;
        emit MergeEvent(art1, art2);
    }
}
