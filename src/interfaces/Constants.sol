// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./IERC165.sol";
import "./IERC4626.sol";

bytes4 constant _INTERFACE_ID_ERC165  = type(IERC165).interfaceId;  // 0x01ffc9a7;
bytes4 constant _INTERFACE_ID_ERC4626 = type(IERC4626).interfaceId; // 0x87dfe5a0;
