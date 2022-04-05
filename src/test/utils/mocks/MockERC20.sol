// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../../../tokens/ERC20/ERC20.sol";

contract MockERC20 is ERC20 {
    constructor(
        string memory name,
        string memory symbol,
        uint8 decimals
    ) ERC20(name, symbol, decimals) {}

    function mint(address to, uint256 amount)
        public virtual
    {
        _mint(to, amount);
    }

    function burn(address from, uint256 amount)
        public virtual
    {
        _burn(from, amount);
    }
}