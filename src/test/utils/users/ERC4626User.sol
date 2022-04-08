// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../../../mixins/ERC4626.sol";
import "./ERC20User.sol";

contract ERC4626User is ERC20User {
    ERC4626 public vault;

    constructor(ERC4626 vault_, ERC20 token_)
        ERC20User(token_)
    {
        vault = vault_;
    }

    function deposit(uint256 amount, address to)
        public virtual
        returns (uint256 shares)
    {
        return vault.deposit(amount, to);
    }

    function mint(uint256 shares, address to)
        public virtual
        returns (uint256)
    {
        return vault.mint(shares, to);
    }

    function redeem(uint256 shares, address to, address from)
        public virtual
        returns (uint256)
    {
        return vault.redeem(shares, to, from);
    }
    function withdraw(uint256 amount, address to, address from)
        public virtual
        returns (uint256)
    {
        return vault.withdraw(amount, to, from);
    }
}