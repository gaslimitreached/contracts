// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../../utils/introspection/IERC165.sol";

/// @title ERC721 - Non-Fungible Token Standard
/// @dev https://eips.ethereum.org/EIPS/eip-721
/// Note: the ERC-165 identifier for this interface is 0x80ac58cd.
interface IERC721 is IERC165 {
    /// @dev Emits when ownership of any NFT changes.
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    /// @dev Emits when approved is changed or reaffirmed.
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    /// @dev Emits when operator is enabled or disabled for an owner.
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);
    /// @notice Count of tokens assigned to an owner.
    function balanceOf(address owner) external view returns (uint256);
    /// @notice Find the address of the token's owner.
    function ownerOf(uint256 tokenId) external view returns (address);
    /// @notice Transfer token ownership from one address to another.
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) external payable;
    /// @notice Transfer token ownership from one address to another.
    function safeTransferFrom(address from, address to, uint256 tokenId) external payable;
    /// @notice Transfer ownership of NFT.
    function transferFrom(address from, address to, uint256 tokenId) external payable;
    /// @notice Change or reaffirm the approved address for token.
    function approve(address approved, uint256 tokenId) external payable;
    /// @notice Toggle approval for third party operator to manage all assets.
    function setApproveForAll(address operator, bool approved) external;
    /// @notice Get approved address for single token.
    function getApproved(uint256 tokenId) external view returns (address);
    /// @notice Check is address is authorized operator for another address.
    function isApprovedForAll(address owner, address operator) external view returns (bool);
}