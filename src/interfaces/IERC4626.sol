// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title ERC4626 - Tokenized Vault Standard
/// @dev https://eips.ethereum.org/EIPS/eip-4626
interface IERC4626 {
    /// @notice Address of the underlying token.
    /// @return assetTokenAddress Underlying token address.
    function asset() external view returns (address assetTokenAddress);
    /// @notice Amount of underlying assets "managed" by the vault.
    /// @return totalManagedAssets Amount of managed assets.
    function totalAssets() external view returns(uint256 totalManagedAssets);
    /// @notice Amount of shares the Vault would exchange for the amount of assets provided.
    /// @param assets Amount of assets to convert.
    /// @return shares Amount of shares provided, in an ideal scenario.
    function convertToShares(uint256 assets) external view returns (uint256 shares);
    /// @notice Amount of assets that vault would exchange for amount of shares provided.
    /// @param shares Amount of shares to convert.
    /// @return assets Amount of assets provided, in a n ideal scenario.
    function convertToAssets(uint256 shares) external view returns (uint256 assets);
    /// @notice Maximum amount of underlying asset that can be deposited into the vault.
    /// @param receiver Target of deposited assets.
    /// @return Maximum amount of deposit.
    function maxDeposit(address receiver) external view returns (uint256);
    /// @notice Simulates the effects of deposit at the current block, given current on-chain conditions.
    /// @param assets Amount of underlying tokens to deposit.
    /// @return As close to and no more than the exact amount of shares that would be minted in a `deposit` call in the same transaction.
    function previewDeposit(uint256 assets) external view returns (uint256);
    /// @notice Mints `shares` to `receiver` by depositing underlying tokens.
    /// @param assets Amount of underlying to deposit.
    /// @param receiver Recipient of underlying.
    /// @return shares Amount of vault shares. 
    function deposit(uint256 assets, address receiver) external returns (uint256 shares);
    /// @notice Maximum amount of `shares` that `receiver` can mint.
    /// @param receiver Recipient of underlying.
    /// @return Maximum shares.
    function maxMint(address receiver) external view returns (uint256);
    /// @notice Simulates mint at the current block, given current on-chain conditions.
    /// @param  shares Amount of shares to simulate.
    /// @return As close to and no more than the exact amount of shares that would be minted in a call in the same transaction.
    function previewMint(uint256 shares) external view returns (uint256);
    /// @notice Mints exactly `shares` to `receiver` by depositing amount of underlying.
    /// @param receiver Recipient of underlying.
    /// @return assets Amount of assets for shares.
    function mint(uint256 shares, address receiver) external returns (uint256 assets);
    /// @notice Maximum amount of the underlying asset that can be withdrawn from the vault.
    /// @param owner Target of the call.
    /// @return Maximum amount of assets that can be withdrawn.
    function maxWithdraw(address owner) external view returns (uint256);
    /// @notice Simulets withdraw at the current block, given current on-chain conditions.
    /// @param assets Amount for simulating withdraw.
    /// @return Amount of shares that would be withdrawn.
    function previewWithdraw(uint256 assets) external view returns (uint256);
    /// @notice Burns `shares` from `owner` and sends exactly `assets` of underlying tokens to `receiver`.
    /// @param assets Amount of underlying `assets` to withdraw from vault.
    /// @param receiver Recipient of withdrawn assets.
    /// @param owner Owner of the underlying assets to witdraw from.
    /// @return Amount withdrawn and sent to `receiver`
    function withdraw(uint256 assets, address receiver, address owner) external returns (uint256);
    /// @notice Maximum amount of shares that can be redeemed from the `owner` balance in the vaulth, through a `redeem` call.
    /// @param owner Owner of the underlying assets to witdraw from.
    /// @return Maximum amount redeemable by `owner`
    function maxRedeem(address owner) external view returns (uint256);
    /// @notice Simulate user redemption at the current block, given current on-chain conditions.
    /// @param shares Amount to burn and send.
    /// @return Amount redeemable by `owner`
    function previewRedeem(uint256 shares) external view returns (uint256);
    /// @notice Burns exactly `shares` from `owner` and sends `assets` of underlying token to `receiver`.
    /// @param shares Amount to burn and send.
    /// @param receiver Recipient of assets.
    /// @param owner Account to burn from.
    /// @return Amount of underlying assets sent to `receiver`
    function redeem(uint256 shares, address receiver, address owner) external returns (uint256);
    /// @notice Emitted when `caller` has exchanged `assets` for `shares` and transfered thoses `shares` to `owner`.
    event Deposit(address indexed caller, address indexed owner, uint256 assets, uint256 shares);
    /// @notice Emitted when `caller` has exchanges `shares`, owned by `owner`, for `assets` and transfered those `assets` to `receiver`.
    event Withdraw(address indexed caller, address indexed owner, address indexed receiver, uint256 assets, uint256 shares);
}