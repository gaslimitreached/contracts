// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../../src/tokens/ERC721/ERC721.sol";

contract MockERC721 is ERC721 {
    // solhint-disable no-empty-blocks
    constructor(string memory name, string memory symbol) ERC721(name, symbol) {}

    function tokenURI(uint256) public pure virtual override returns (string memory) {}
    // solhint-enable no-empty-blocks

    function mint(address to, uint256 tokenId) public virtual {
        _mint(to, tokenId);
    }

    function burn(uint256 tokenId) public virtual {
        _burn(tokenId);
    }

    function safeMint(address to, uint256 tokenId) public virtual {
        _safeMint(to, tokenId);
    }

    function safeMint(address to, uint256 tokenId, bytes memory data) public virtual {
        _safeMint(to, tokenId, data);
    }
}