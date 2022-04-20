// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "./MockERC20.sol";
import "../../src/tokens/ERC20/extensions/ERC20Permit.sol";

contract MockERC20Permit is MockERC20, ERC20Permit {
    constructor(
        string memory name,
        string memory symbol,
        uint8 decimals
    ) MockERC20(name, symbol, decimals) {}
}