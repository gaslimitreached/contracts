// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Ownable.sol";

abstract contract OwnableByNomination is Ownable {
    address public nominated;

    event SuccessorNominated(address indexed nominator, address indexed nominee);

    constructor() {
        nominated = address(0);
    }

    /// @dev Accept nomitaion to owner.
    function acceptNomination() public virtual {
        require(msg.sender == nominated, "Ownable: not nominated");
        _transferOwnership(nominated);
        delete nominated;
    }

    /// @dev Nominate new owner
    /// @param nominee Successor's address
    function nominateSuccessor(address nominee) public virtual onlyOwner {
        require(nominee != address(0));
        nominated = nominee;
        emit SuccessorNominated(owner, nominee);
    }
}