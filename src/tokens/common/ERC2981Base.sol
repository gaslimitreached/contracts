// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../../interfaces/IERC2981.sol";
import "../../utils/introspection/ERC165.sol";
import "../../utils/introspection/IERC165.sol";

abstract contract ERC2981Base is IERC2981, ERC165 {
    struct RoyaltyInfo {
        address receiver;
        uint24 fraction;
    }
    
    /// @dev See {IERC165-supportsInterface}
    function supportsInterface(bytes4 interfaceId)
        public view virtual override(IERC165, ERC165)
        returns (bool)
    {
        return interfaceId == type(IERC2981).interfaceId
            || super.supportsInterface(interfaceId)
            ;
    }
}