// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title ERC20 - Token Standard
/// @dev https://eips.ethereum.org/EIPS/eip-20
interface IERC20 {
    /// @dev Emitted when tokens are transferred from one account to another.
    event Transfer(address indexed from, address indexed to, uint256 amount);
    /// @dev Emitted when the allowance of a `spender` is set.
    event Approval(address indexed owner, address indexed spender, uint256 amount);
    /// @notice Total amount of tokens in existence.
    /// @return The existing supply.
    function totalSupply() external view returns (uint256);
    /// @notice Amount of tokens owned by `account`.
    /// @param account The address of the account.
    /// @return The balance.
    function balanceOf(address account) external view returns (uint256);
    /// @notice Send token `amount` to `to` from `msg.sender`.
    /// @param to The recipeint's address.
    /// @param amount The amount of token to transfer.
    /// @return Whether the transfer worked.
    function transfer(address to, uint256 amount) external returns (bool);
    /// @notice Remaining tokens `spender` is approved to transfer.
    /// @param owner The address of the owner account.
    /// @param spender The address of the account able to transfer.
    /// @return Amount of remaining token allowance.
    function allowance(address owner, address spender) external view returns (uint256);
    /// @notice Set token `amount` that can be spent by `spender`.
    /// @param spender The address of the account able to transfer.
    /// @param amount The amount of token to approve.
    function approve(address spender, uint256 amount) external returns (bool);
    /// @notice Send token `amount` to `to` if `from` approved.
    /// @param from Address of the spender.
    /// @param to The recipeint's address.
    /// @param amount The amount of token to transfer.
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}