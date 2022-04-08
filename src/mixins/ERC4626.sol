// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../interfaces/IERC4626.sol";
import "../tokens/ERC20/ERC20.sol";
import "../utils/FixedPointMath.sol";

abstract contract ERC4626 is ERC20, IERC4626 {
    using FixedPointMath for uint256;
    ERC20 internal immutable underlying;

    constructor(
        ERC20 asset_,
        string memory name,
        string memory symbol
    ) ERC20(name, symbol, asset_.decimals()) {
        underlying = asset_;
    }

    function asset()
       external view
       returns (address)
    {
        return address(underlying);
    }

    function deposit(uint256 assets, address receiver)
        public virtual
        returns (uint256 shares)
    {
        require((shares = previewDeposit(assets)) != 0, "No Shares");

        // not safe
        underlying.transferFrom(msg.sender, address(this), assets);

        _mint(receiver, shares);

        emit Deposit(msg.sender, receiver, assets, shares);

        afterDeposit(assets, shares);
    }

    function withdraw(uint256 assets, address receiver, address owner)
        public virtual
        returns (uint256 shares)
    {
        shares = previewWithdraw(assets);

        if (msg.sender != owner) {
            uint256 allowed = allowances[owner][msg.sender];

            if (allowed != type(uint256).max) allowances[owner][msg.sender] = allowed - shares;
        }

        beforeWithdraw(assets, shares);

        _burn(owner, shares);

        emit Withdraw(msg.sender, owner, receiver, assets, shares);

        // not safe
        underlying.transfer(receiver, assets);
    }

    function mint(uint256 shares, address receiver)
        public virtual
        returns (uint256 assets)
    {
        assets = previewMint(shares);

        underlying.transferFrom(msg.sender, address(this), assets);

        emit Deposit(msg.sender, receiver, assets, shares);

        afterDeposit(assets, shares);
    }

    function redeem(uint256 shares, address receiver, address owner)
        public virtual
        returns (uint256 assets)
    {
        if (msg.sender != owner) {
            uint256 allowed = allowances[owner][msg.sender];
        
            if (allowed != type(uint256).max) allowances[owner][msg.sender] = allowed - shares;
        }

        require((assets = previewRedeem(shares)) != 0, "No Shares");

        beforeWithdraw(assets, shares);

        _burn(owner, shares);

        emit Withdraw(msg.sender, receiver, owner, assets, shares);

        // not safe
        underlying.transfer(receiver, assets);
    }

    function totalAssets() public view virtual returns (uint256);

    function convertToShares(uint256 assets)
        public view virtual 
        returns (uint256)
    {
        uint256 value = supply;
        return value == 0
            ? assets 
            : assets.mulDivDown(value, totalAssets())
            ; 
    }

    function convertToAssets(uint256 shares)
        public view virtual
        returns (uint256)
    {
        uint256 value = supply;
        return value == 0
            ? shares 
            : shares.mulDivDown(value, totalAssets())
            ; 
    }

    function previewDeposit(uint256 assets)
        public view virtual
        returns (uint256)
    {
        return convertToShares(assets);
    }

    function previewMint(uint256 shares)
        public view virtual
        returns (uint256)
    {
        uint256 value = supply;
        return value == 0
            ? shares
            : shares.mulDivUp(totalAssets(), value)
            ;
    }

    function previewWithdraw(uint256 assets)
        public view virtual
        returns (uint256)
    {
        uint256 value = supply;
        return value == 0
            ? assets 
            : assets.mulDivUp(value, totalAssets())
            ;
    }

    function previewRedeem(uint256 shares)
        public view virtual
        returns (uint256)
    {
        return convertToAssets(shares);
    }

    function maxDeposit(address)
        public view virtual
        returns (uint256)
    {
        return type(uint256).max;
    }

    function maxMint(address)
        public view virtual
        returns (uint256)
    {
        return type(uint256).max;
    }

    function maxWithdraw(address owner)
        public view virtual
        returns (uint256) 
    {
        return convertToAssets(balances[owner]);
    }

    function maxRedeem(address owner)
        public view virtual
        returns (uint256)
    {
        return balances[owner];
    }

    function beforeWithdraw(uint256 assets, uint256 shares) internal virtual {}
    function afterDeposit(uint256 assets, uint256 shares) internal virtual {}
}
