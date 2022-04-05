// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../../../tokens/ERC20/ERC20.sol";

contract ERC20User {
    ERC20 internal token;
    constructor(ERC20 token_) { token = token_; }

    function approve(address spender, uint256 amount)
        public virtual
        returns (bool)
    {
        return token.approve(spender, amount);
    }

    function transfer(address to, uint256 amount)
        public virtual
        returns (bool)
    {
        return token.transfer(to, amount);
    }

    function transferFrom(address from, address to, uint256 amount)
        public virtual
        returns (bool)
    {
        return token.transferFrom(from, to, amount);
    }
}