// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "forge-std/Test";
// import "./utils/BaseTest.sol";
import "./utils/mocks/MockERC20.sol";

contract ERC20Test is Test {
    MockERC20 internal token;

    function setUp() public {
        token = new MockERC20("TEST", "TEST", 18);
    }

    function testMint() public {
        token.mint(address(0xB0B), 1 ether);

        assertEq(token.totalSupply(), 1 ether);
        assertEq(token.balanceOf(address(0xB0B)), 1 ether);
    }

    function testBurn() public {
        token.mint(address(0xB0B), 2 ether);
        token.burn(address(0xB0B), 1 ether);

        assertEq(token.totalSupply(), 1 ether);
        assertEq(token.balanceOf(address(0xB0B)), 1 ether);
    }

    function testApprove() public {
        assertTrue(token.approve(address(0xB0B), 1 ether));
        assertEq(token.allowance(address(this), address(0xB0B)), 1 ether);
    }

    function testTransfer() public {
        token.mint(address(this), 1 ether);

        assertTrue(token.transfer(address(0xB0B), 1 ether));
        assertEq(token.totalSupply(), 1 ether);

        assertEq(token.balanceOf(address(this)), 0);
        assertEq(token.balanceOf(address(0xB0B)), 1 ether);
    }

    function testTransferFrom() public {
	    address alice = address(0xA71CE);
        token.mint(address(alice), 1 ether);

	    vm.prank(address(alice));
	    token.approve(address(this), 1 ether);

        assertTrue(token.transferFrom(address(alice), address(0xB0B), 1 ether));
        assertEq(token.totalSupply(), 1 ether);

        assertEq(token.allowance(address(alice), address(this)), 0);

        assertEq(token.balanceOf(address(alice)), 0);
        assertEq(token.balanceOf(address(0xB0B)), 1 ether);
    }

    function testFailTransferInsufficientBalance() public {
        token.mint(address(this), 0.9e18);
        token.transfer(address(0xB0B), 1 ether);
    }
}
