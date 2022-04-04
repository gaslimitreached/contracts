// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../../utils/introspection/IERC165.sol";

/// @notice ERC2891 Interface - NFT Royalty Standard
/// @dev https://eips.ethereum.org/EIPS/eip-2981
interface IERC2981 is IERC165 {
    /// @notice Called with the sale price to determine royalty amount.
    /// @param tokenId NFT asset queried for royalty information.
    /// @param price Sale price of the NFT asset specified by _tokenId.
    /// @return receiver of the royalty payment.
    /// @return amount of royalty payment.
    function royaltyInfo(uint256 tokenId, uint256 price)
        external view
        returns (address receiver, uint256 amount);
}