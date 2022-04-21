// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../../src/access/OwnableByNomination.sol";

contract MockOwnableByNomination is OwnableByNomination {
    bool public flag;

    function protected() public  onlyOwner {
        flag = !flag;
    }
}