// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "./mocks/MockPullPayment.sol";

contract PullPaymentTest is Test {
    MockPullPayment public mock;

    event Deposited(address indexed payee, uint256 amount);
    event Withdrawn(address indexed payee, uint256 amount);

    function setUp() public {
        mock = new MockPullPayment();
        vm.deal(address(mock), 2 ether);
    }

    function testDeposit() public {
        vm.expectEmit(true, true, true, true);
        emit Deposited(address(0xB0B), 1 ether);
        mock.deposit(address(0xB0B), 1 ether);
        assertEq(mock.payments(address(0xB0B)), 1 ether);
    }

    function testWithdraw() public {
        mock.deposit(address(0xB0B), 1 ether);
        vm.expectEmit(true, true, true, true);
        emit Withdrawn(address(0xB0B), 1 ether);
        vm.prank(address(0xB0B));
        mock.withdraw(payable(address(0xB0B)));
    }
}