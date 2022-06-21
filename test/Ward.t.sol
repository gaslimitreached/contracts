// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "./mocks/MockWard.sol";

contract WardTest is Test {
    MockWard internal mock;

    function setUp() public {
        mock = new MockWard();
    }

    function testNominateWarden() public {
        vm.prank(address(this));
        mock.nominate(address(0xB0B));
        assertTrue(mock.nominated(address(0xB0B)));
        mock.acceptNomination(address(0xB0B));
        assertTrue(mock.wards(address(0xB0B)));
    }

    function testNominateWarden(address successor) public {
        mock.nominate(successor);
        assert(mock.nominated(successor));
        mock.acceptNomination(successor);
        assert(mock.wards(successor));
    }

    function testCalledByNonOwner(address addr) public {
        if (mock.wards(addr) || addr == address(0)) return;
        vm.expectRevert("Ward: caller is not a ward");
        vm.prank(addr);
        mock.protected();
    }
}
