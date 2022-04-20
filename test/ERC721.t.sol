// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "./mocks/MockERC721.sol";

contract ERC721Test is Test {
    MockERC721 internal token;

    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    function setUp() public {
        token = new MockERC721("TEST", "TEST");
    }

    function testMint() public {
        vm.expectEmit(true, true, true, true);
        emit Transfer(address(0), address(0xB0B), 1);
        token.mint(address(0xB0B), 1);
        assertEq(token.balanceOf(address(0xB0B)), 1);
        assertEq(token.ownerOf(1), address(0xB0B));
    }
}