//SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.4;

interface IDelysiumAssets {
    // structs
    struct MintParams {
        address receiver;
        uint32 amount;
    }

    // views
    function baseURI() external view returns (string memory);

    function tokenURI(uint256 tokenId) external view returns (string memory);

    function getModelId(uint256 tokenId) external view returns (uint32);

    // minter functions
    function mint(
        address to,
        uint32 _modelId,
        uint32 amount
    ) external;

    function mintBatch(MintParams[] calldata receivers) external;

    // maintainer functions
    function unpause() external;

    function pause() external;

    function setBaseURI(string memory newBaseURI) external;

    // public functions
    function safeTransferFromBatch(
        address from,
        address to,
        uint256[] calldata tokenIds
    ) external;

    function safeTransferFromToAddresses(
        address from,
        address[] calldata receivers,
        uint256[] calldata tokenIds
    ) external;
}
