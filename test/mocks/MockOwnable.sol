// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../../src/access/Ownable.sol";

contract MockOwnable is Ownable {
    bool public flag;

    function protected() public  onlyOwner {
        flag = !flag;
    }
}