// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "./mocks/MockOwnableByNomination.sol";

contract OwnableByNominationTest is Test {
    MockOwnableByNomination internal mock;

    function setUp() public {
        mock = new MockOwnableByNomination();
    }

    function testNominateSuccessor() public {
        mock.nominateSuccessor(address(0xB0B));
        assertEq(mock.nominated(), address(0xB0B));
        vm.prank(address(0xB0B));
        mock.acceptNomination();
        assertEq(mock.owner(), address(0xB0B));
    }

    function testNominateSuccessor(address successor) public {
        if (successor == address(0)) return;
        mock.nominateSuccessor(successor);
        assertEq(mock.nominated(), successor);
        vm.prank(successor);
        mock.acceptNomination();
        assertEq(mock.owner(), successor);
    }

    function testNominateZeroAddress() public {
        vm.expectRevert("Zero address");
        mock.nominateSuccessor(address(0));
    }
}