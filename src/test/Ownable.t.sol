// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "./utils/Mocks/MockOwnable.sol";

contract OwnableTest is Test {
    MockOwnable internal mock;

    function setUp() public {
        mock = new MockOwnable();
    }

    function testTranferOwner() public {
        vm.prank(mock.owner());
        mock.transferOwnership(address(0xB0B));
        assertEq(mock.owner(), address(0xB0B));
    }

    function testFailTransferToZeroAddress() public {
        vm.prank(mock.owner());
        mock.transferOwnership(address(0));
    }

    function testNominateSuccessor() public {
        vm.prank(mock.owner());
        mock.nominateSuccessor(address(0xB0B));
        assertEq(mock.nominated(), address(0xB0B));
        vm.prank(address(0xB0B));
        mock.acceptNomination();
        assertEq(mock.owner(), address(0xB0B));
    }

    function testTranferOwner(address successor) public {
        if (successor == address(0)) return;
        vm.prank(mock.owner());
        mock.transferOwnership(successor);
        assertEq(mock.owner(), successor);
    }

    function testNominateSuccessor(address successor) public {
        vm.prank(mock.owner());
        mock.nominateSuccessor(successor);
        assertEq(mock.nominated(), successor);
        vm.prank(successor);
        mock.acceptNomination();
        assertEq(mock.owner(), successor);
    }

    function testFailCalledByNonOwner(address addr) public {
        require(addr != mock.owner());
        vm.prank(addr);
        mock.protected();
    }
}