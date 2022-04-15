// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "./utils/mocks/MockERC20.sol";
import "./utils/mocks/MockERC4626.sol";

contract ERC2646 is Test {
    MockERC20 internal underlying;
    MockERC4626 internal vault;

    function setUp() public {
        underlying = new MockERC20("Mock", "MOCK", 18);
        vault = new MockERC4626(underlying, "MockTokenVault", "MTV");
    }

    function testFailRedeemZero() public {
        vault.redeem(0, address(this), address(this));
    }

    function testWithdrawZero() public {
        vault.withdraw(0, address(this), address(this));

        assertEq(vault.balanceOf(address(this)), 0);
        assertEq(vault.convertToAssets(vault.balanceOf(address(this))), 0);
        assertEq(vault.totalSupply(), 0);
        assertEq(vault.totalAssets(), 0);
    }
}