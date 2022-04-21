// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @author Modified from OpenZeppelin (https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol)
abstract contract Ownable {
    address public owner;
    address public nominated;

    event OwnershipTransferred(address indexed predecessor, address indexed successor);
    event SuccessorNominated(address indexed nominator, address indexed nominee);

    constructor() {
        _transferOwnership(msg.sender);
    }

    /// @dev Throws if called by any account other than the owner.
    modifier onlyOwner() {
        require(owner == msg.sender, "Ownable: caller is not the owner");
        _;
    }
 
    function acceptNomination() public {
        require(msg.sender == nominated, "Ownable: not nominated");
        _transferOwnership(nominated);
        delete nominated;
    }

    /// @dev Nominate new owner
    /// @param nominee Successor's address
    function nominateSuccessor(address nominee) public onlyOwner {
        nominated = nominee;
        emit SuccessorNominated(owner, nominee);
    }

    /// @dev Renounce ownership by setting owner to zero address.
    function renounceOwnership()
        public
        virtual
        onlyOwner
    {
        _transferOwnership(address(0));
    }

    /// @dev Transfers ownership of the contract to a new account. 
    function transferOwnership(address successor)
        public
        virtual
        onlyOwner
    {
        require(successor != address(0), "Zero address");
        _transferOwnership(successor);
    }

    /// @dev Transfers ownership of the contract to a new account.
    function _transferOwnership(address successor)
        internal 
        virtual
    {
        address predecessor = owner;
        owner = successor;
        emit OwnershipTransferred(predecessor, successor);
    }
}