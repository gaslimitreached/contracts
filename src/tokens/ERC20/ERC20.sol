// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./IERC20.sol";
import "./IERC20Metadata.sol";

contract ERC20 is IERC20, IERC20Metadata {
    string public name;
    string public symbol;
    uint8 public immutable decimals;

    uint256 public supply;

    mapping (address => uint256) public balances;
    mapping (address => mapping(address => uint256)) public allowances;

    constructor(string memory name_, string memory symbol_, uint8 decimals_) {
        name = name_;
        symbol = symbol_;
        decimals = decimals_;
    }

    function allowance(address owner, address spender)
        external view
        returns (uint256)
    {
        return allowances[owner][spender];
    }

    function approve(address spender, uint256 amount)
        public virtual
        returns (bool)
    {
        allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function balanceOf(address account)
        external view
        returns (uint256)
    {
        return balances[account];
    }

    function totalSupply() external view returns (uint256) {
        return supply;
    }

    function transfer(address to, uint256 amount)
        public virtual
        returns (bool)
    {
        balances[msg.sender] -= amount;
        balances[to] += amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    function transferFrom(address from, address to, uint256 amount)
        public virtual
        returns (bool)
    {
        uint256 allowed = allowances[from][msg.sender];
        if (allowed != type(uint256).max) {
            // Underflow enforces allowance.
            allowances[from][msg.sender] = allowed - amount;
        }

        balances[from] -= amount;

        // balance can not exceed uint256 max.
        unchecked { balances[to] += amount; }

        emit Transfer(from, to, amount);
        return true;
    }

    function _mint(address to, uint256 amount)
        internal virtual
    {
        supply += amount;
        // balance can not exceed uint256 max.
        unchecked { balances[to] += amount; }
        emit Transfer(msg.sender, to, amount);
    }

    function _burn(address from, uint256 amount)
        internal virtual
    {
        balances[from] -= amount;
        // Balance will never exceed total supply.
        unchecked { supply -= amount; }
        emit Transfer(from, address(0), amount);
    }
}