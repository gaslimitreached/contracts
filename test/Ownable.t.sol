// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "./Mocks/MockOwnable.sol";

contract OwnableTest is Test {
    MockOwnable internal mock;

    function setUp() public {
        mock = new MockOwnable();
    }

    function testTranferOwner() public {
        mock.transferOwnership(address(0xB0B));
        assertEq(mock.owner(), address(0xB0B));
    }

    function testTransferToZeroAddress() public {
        vm.expectRevert("Zero address");
        mock.transferOwnership(address(0));
    }

    function testTranferOwner(address successor) public {
        if (successor == address(0)) return;
        mock.transferOwnership(successor);
        assertEq(mock.owner(), successor);
    }

    function testCalledByNonOwner(address addr) public {
        if (addr == mock.owner()) return;
        vm.expectRevert("Ownable: caller is not the owner");
        vm.prank(addr);
        mock.protected();
    }
}