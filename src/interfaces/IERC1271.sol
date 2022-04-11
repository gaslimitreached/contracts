// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title IERC1271 - Standard Signature Validation Method for Contracts
/// @dev https://eips.ethereum.org/EIPS/eip-1271
interface IERC1271 {
    /// @dev Should return wheter the signature provided is valid for the hash.
    /// @param hash Hash of the data to be signed
    /// @param signature byte array associated with hash_
    function isValidSignature(bytes32 hash, bytes memory signature) external view returns (bytes4);
}