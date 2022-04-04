// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import "forge-std/Vm.sol";

contract BaseTest is DSTest {
    Vm public vm = Vm(HEVM_ADDRESS);
}