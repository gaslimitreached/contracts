// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./IERC165.sol";

/// @notice Implementation of the {IERC165} interface.
contract ERC165 is IERC165 {
    /// @dev Override {supportsInterface} to check for additional interfaces.
    function supportsInterface(bytes4 interfaceId)
        public view virtual override
        returns (bool)
    {
        return interfaceId == type(IERC165).interfaceId;
    }
}