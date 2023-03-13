interface IERC721Drop {
    function safeTransferFrom(address from, address to, uint256 tokenId) external;
    function isApprovedForAll(address nftOwner, address operator) external view returns (bool);
    function setApprovalForAll(address operator, bool approved) external;
    function ownerOf(uint256 tokenId) external view returns (address);
}