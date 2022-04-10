// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

abstract contract Expirable {
    uint256 public expiry;

    event Expiration(address indexed operator, uint256 expiry);

    modifier isActive() {
        require(block.timestamp < expiry, "Expired");
        _;
    }

    modifier isExpired() {
        require(block.timestamp >= expiry, "Not expired");
        _;
    }

    function expired() public view returns (bool) {
        return block.timestamp >= expiry;
    }

    function _setExpiry(uint256 period) internal {
        expiry = block.timestamp + period;
        emit Expiration(msg.sender, expiry);
    }
}