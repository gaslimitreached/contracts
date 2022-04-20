// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "./mocks/MockERC20.sol";

contract ERC20Test is Test {
    MockERC20 internal token;

    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Approval(address indexed owner, address indexed spender, uint256 amount);

    function setUp() public {
        token = new MockERC20("TEST", "TEST", 18);
    }

    function testMint() public {
        vm.expectEmit(true, true, true, true);
        emit Transfer(address(this), address(0xB0B), 1 ether);
        token.mint(address(0xB0B), 1 ether);

        assertEq(token.totalSupply(), 1 ether);
        assertEq(token.balanceOf(address(0xB0B)), 1 ether);
    }

    function testBurn() public {
        token.mint(address(0xB0B), 2 ether);
        vm.expectEmit(true, true, true, true);
        emit Transfer(address(0xB0B), address(0), 1 ether);
        token.burn(address(0xB0B), 1 ether);

        assertEq(token.totalSupply(), 1 ether);
        assertEq(token.balanceOf(address(0xB0B)), 1 ether);
    }

    function testApprove() public {
        token.mint(address(0xB0B), 2 ether);
        // Bob allows Alice to spend 1 ether
        vm.expectEmit(true, true, true, true);
        emit Approval(address(0xB0B), address(0xA71CE), 1 ether);
        vm.prank(address(0xB0B));
        assertTrue(token.approve(address(0xA71CE), 1 ether));
        assertEq(token.allowance(address(0xB0B), address(0xA71CE)), 1 ether);
    }

    function testTransfer() public {
        token.mint(address(this), 1 ether);

        assertTrue(token.transfer(address(0xB0B), 1 ether));
        assertEq(token.totalSupply(), 1 ether);

        assertEq(token.balanceOf(address(this)), 0);
        assertEq(token.balanceOf(address(0xB0B)), 1 ether);
    }

    function testTransferFrom() public {
        token.mint(address(0xA71CE), 1 ether);

	    vm.prank(address(0xA71CE));
	    token.approve(address(this), 1 ether);

        assertTrue(token.transferFrom(address(0xA71CE), address(0xB0B), 1 ether));
        assertEq(token.totalSupply(), 1 ether);

        assertEq(token.allowance(address(0xA71CE), address(this)), 0);

        assertEq(token.balanceOf(address(0xA71CE)), 0);
        assertEq(token.balanceOf(address(0xB0B)), 1 ether);
    }

    function testTransferInsufficientBalance() public {
        token.mint(address(this), 0.9e18);
        vm.expectRevert(stdError.arithmeticError);
        token.transfer(address(0xB0B), 1 ether);
    }
}
