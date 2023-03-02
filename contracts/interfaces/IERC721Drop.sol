interface IERC721Drop {
    function burn(uint256 tokenId) external;
    function isApprovedForAll(address nftOwner, address operator) external view returns (bool);
    function setApprovalForAll(address operator, bool approved) external;
    function ownerOf(uint256 tokenId) external view returns (address);
}