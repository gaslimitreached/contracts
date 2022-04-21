// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "../../src/security/PullPayment.sol";

contract MockPullPayment is PullPayment {
    function deposit(address payee, uint256 amount) public {
        super._deposit(payable(payee), amount);
    }
}
