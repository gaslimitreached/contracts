// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../../src/access/Ward.sol";

contract MockWard is Ward {
    bool public flag;

    function protected() public  onlyWards {
        flag = !flag;
    }
}