// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./ERC2981Base.sol";

abstract contract ERC2981 is ERC2981Base {
    RoyaltyInfo private defaultRoyalty;
    mapping (uint256 => RoyaltyInfo) private royalties;

    function royaltyInfo(uint256 tokenId, uint256 price)
        public view virtual override
        returns (address, uint256)
    {
        RoyaltyInfo memory royalty = royalties[tokenId];

        if (royalty.receiver == address(0)) royalty = defaultRoyalty;
    
        uint256 amount = (price * royalty.fraction) / denominator();

        return (royalty.receiver, amount);
    }

    function denominator()
        internal pure virtual
        returns (uint24)
    {
        return 10_000;
    }

    /// @dev Set default royalties for all tokens
    function setDefaultRoyalty(address receiver, uint24 fraction)
        internal virtual
    {
        require(fraction <= denominator(), "ERC2981: fee exceeds sale price");
        require(receiver != address(0), "ERC2981: invalid receiver");

        defaultRoyalty = RoyaltyInfo(receiver, fraction);
    }

    /// @dev Remove default royalty information.
    function deleteDefaultRoyalty()
        internal virtual
    {
        delete defaultRoyalty;
    }

    function setTokenRoyalty(uint256 tokenId, address receiver, uint24 fraction)
        internal virtual
    {
        require( fraction <= denominator(), "ERC2981: fee exceeds sale price");
        require(receiver != address(0), "ERC2981: invalid receiver");
        royalties[tokenId] = RoyaltyInfo(receiver, fraction);
    }

    function resetRoyalty(uint256 tokenId)
        internal virtual
    {
        delete royalties[tokenId];
    }
}