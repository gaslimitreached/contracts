// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./utils/BaseTest.sol";
import "./utils/mocks/MockERC721.sol";

contract ERC721Test is BaseTest {
    MockERC721 internal token;

    function setUp() public {
        token = new MockERC721("TEST", "TEST");
    }

    function testMint() public {
        token.mint(address(0xB0B), 1);
        assertEq(token.balanceOf(address(0xB0B)), 1);
        assertEq(token.ownerOf(1), address(0xB0B));
    }
}