// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../utils/Escrow.sol";

abstract contract PullPayment {
    Escrow private immutable escrow;

    constructor () {
        escrow = new Escrow();
    }

    function payments(address payee) public view returns (uint256) {
        return escrow.deposits(payee);
    }

    function withdraw(address payable payee) public virtual {
        escrow.withdraw((payee));
    }

    function _deposit(address payee, uint256 amount) internal virtual {
        escrow.deposit{value: amount}(payee);
    }
}