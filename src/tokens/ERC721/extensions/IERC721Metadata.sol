// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../IERC721.sol";

/// @title ERC-721 - Optional metadata extension
/// @dev See https://eips.ethereum.org/EIPS/eip-721
/// Note: the ERC-165 identifier for this interface is 0x5b5e139f.
interface IERC721Metadata is IERC721 {
    /// @notice Name for the collection.
    function name() external view returns (string memory name);
    /// @notice An abbreviated name for the collection.
    function symbol() external view returns (string memory symbol);
    /// @notice A distinct Uniform Resource Identifier (URI) for a given asset.
    function tokenURI(uint256 tokenId) external view returns (string memory);
}