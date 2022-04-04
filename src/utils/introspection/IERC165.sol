// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title ERC165 Interface - Standard Interface Detection
/// @dev https://eips.ethereum.org/EIPS/eip-165
interface IERC165 {
    /// @dev https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified
    /// @dev Function call must use less than 30_000 gas.
    /// @return true if contract supports the given interface identifier.
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}