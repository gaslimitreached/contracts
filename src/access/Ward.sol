// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @author Modified from dss-snog (https://github.com/brianmcmichael/dss-snog/blob/master/src/DssSnog.sol)
abstract contract Ward {
    event WardAdded(address indexed ward);
    event WardRemoved(address indexed ward);
    event WardNominated(address indexed nominator, address indexed nominated);

    mapping(address => bool) public wards;
    mapping(address => bool) public nominations;

    function abolish(address ward) external onlyWards {
        delete wards[ward];
        emit WardRemoved(ward);
    }

    constructor() {
        wards[msg.sender] = true;
    }

    /// @dev Throws if called by any account that is not a ward.
    modifier onlyWards() {
        require(wards[msg.sender], "Ward: caller is not a ward");
        _;
    }
 
    function acceptNomination(address nominee)
        public
        virtual
        onlyWards
    {
        require(nominations[nominee], "Ward: not nominated");
        delete nominations[nominee];
        wards[nominee] = true;
        emit WardAdded(nominee);
    }

    /// @dev Nominate new warden
    /// @param nominee Warden's address
    function nominate(address nominee)
        public
        virtual
        onlyWards
    {
        nominations[nominee] = true;
        emit WardNominated(msg.sender, nominee);
    }

    function nominated(address nominee)
        public
        view
        returns (bool)
    {
        return nominations[nominee];
    }
}