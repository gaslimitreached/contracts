// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./IERC165.sol";

/// @notice Library to check interface implementations defined via {IERC165}.
/// @dev These functions do not revert and handling is left to the caller.
library ERC165Checker {
    /// @dev Check if account supports {IERC165} interface.
    /// @param account Address of contract to query.
    function supportsERC165(address account)
        internal view
        returns (bool)
    {
        return supportsERC165Interface(account, type(IERC165).interfaceId)
            && !supportsERC165Interface(account, 0xffffffff)
            ;
    }

    /// @dev Check if account suports given interface in addition to {IERC165}.
    /// @param account Address of contract to query.
    /// @param interfaceId Interface identifier per ERC165.
    function supportsInterface(address account, bytes4 interfaceId)
        internal view
        returns (bool)
    {
        return supportsERC165(account)
            && supportsERC165Interface(account, interfaceId)
            ;
    }

    /// @dev Check if account supports all given interfaces.
    /// @param account Address of contract to query.
    /// @param interfaces An array of bytes4 interface identifiers as defined by {IERC165}.
    /// @return True if all interfaces are supported. False otherwise.
    function supportsAllInterfaces(address account, bytes4[] memory interfaces)
        internal view
        returns (bool)
    {
        if (!supportsERC165(account)) return false;

        uint256 length = interfaces.length;
        for (uint i; i < length;) {
            if (!supportsERC165Interface(account, interfaces[i])) {
                return false;
            }
            unchecked { ++i; }
        }

        return true;
    }

    /// @dev Maps given array of interfaces to implemented flag.
    /// @param account Address of contract to query.
    /// @param interfaces An array of bytes4 interface identifiers as defined by {IERC165}.
    /// @return List of flags corresponding to given interfaces.
    function getSupportedInterfaces(address account, bytes4[] memory interfaces)
        internal view
        returns (bool[] memory)
    {
        uint256 length = interfaces.length;
        bool[] memory supported = new bool[](length);
        if (!supportsERC165(account)) return supported;
        for (uint i; i < length;) {
            supported[i] = supportsERC165Interface(account, interfaces[i]);
            unchecked{ ++i; }
        }
        return supported;
    }

    /// @dev Check that a contract implements the given interface.
    /// @param account Address of contract to query.
    /// @param interfaceId Interface identifier per ERC165.
    /// @return true if the interface is implemented. False otherwise.
    function supportsERC165Interface(address account, bytes4 interfaceId)
        private view
        returns (bool)
    {
        bytes memory params = abi.encodeWithSelector(
            IERC165.supportsInterface.selector,
            interfaceId 
        );
        (bool ok, bytes memory result) = account.staticcall{gas: 30_000}(params);
        if (result.length < 32) return false;
        return ok && abi.decode(result, (bool));
    }
}