// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../access/Ownable.sol";
import "forge-std/console.sol";

/// @title Escrow
/// @dev Base escrow holding designated for payee.
/// @dev Modified https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/escrow/Escrow.sol
///
/// The contract that uses the escrow as its payment method should be its owner,
/// and provide public methods redirecting to the escrow's deposit and withdraw.
contract Escrow is Ownable {
    event Deposited(address indexed payee, uint256 amount);
    event Withdrawn(address indexed payee, uint256 amount);

    mapping(address => uint256) public deposits;

    function deposit(address payee) public payable virtual onlyOwner {
        deposits[payee] += msg.value;
        emit Deposited(payee, msg.value);
    }

    function withdraw(address payee) public virtual onlyOwner {
        uint256 amount = deposits[payee];
        require(address(this).balance >= amount, "Escrow: insufficient balance");

        deposits[payee] = 0;

        emit Withdrawn(payee, amount);

        (bool success,) = payee.call{value: amount}("");
        require(success, "Escrow: unable to send value");
    }
}
