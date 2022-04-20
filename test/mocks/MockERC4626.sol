// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../../src/tokens/ERC20/ERC20.sol";
import "../../src/mixins/ERC4626.sol";

contract MockERC4626 is ERC4626 {
    uint256 public depositHookCallCounter;
    uint256 public withdrawHookCallCounter;

    constructor(
        ERC20 asset_,
        string memory name,
        string memory symbol
    ) ERC4626(asset_, name, symbol) {}

    function totalAssets()
        public view override
        returns (uint256)
    {
        return ERC20(underlying).balanceOf(address(this));
    }

    function afterDeposit(uint256, uint256)
        internal override
    {
        depositHookCallCounter++;
    }

    function beforeWithdraw(uint256, uint256)
        internal override
    {
        withdrawHookCallCounter++;
    }
}