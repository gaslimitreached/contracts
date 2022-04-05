// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./IERC20.sol";

interface IERC20Metadata is IERC20 {
    /// @dev Name of the token.
    function name() external view returns (string memory);
    /// @dev Symbol of the token.
    function symbol() external view returns (string memory);
    /// @dev Decimal places of the token.
    function decimals() external view returns (uint8);
}
