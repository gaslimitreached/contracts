// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title Permit Signed Approvals
/// @dev https://eips.ethereum.org/EIPS/eip-2612
interface IERC2612 {
    /// @dev Set `value` as allowance of `spender` over `owner`'s tokens.
    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;
    /// @dev Returns the current nonce for `owner`.
    /// @dev Succesful call increases `owner`'s nonce by one.
    function nonces(address owner) external view returns (uint256);
    /// @dev Returns the domain seperator used in the encoding of the signature.
    // solhint-disable-next-line func-name-mixedcase
    function DOMAIN_SEPERATOR() external view returns (bytes32);
}