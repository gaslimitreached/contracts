// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../ERC20.sol";
import "./IERC2612.sol";

abstract contract ERC20Permit is ERC20, IERC2612 {
    // solhint-disable var-name-mixedcase
    uint256 internal immutable INITIAL_CHAIN_ID = block.chainid;
    bytes32 internal immutable INITIAL_DOMAIN_SEPARATOR = computeDomainSeperator();
    // solhint-enable var-name-mixedcase
    mapping(address => uint256) public nonces;

    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) public virtual {
        require(block.timestamp <= deadline, "ERC2612: Permit Deadline");
        unchecked {
            address recovered = ecrecover(
                keccak256(
                    abi.encodePacked(
                        hex"1901",
                        DOMAIN_SEPERATOR(),
                        keccak256(
                            abi.encode(
                                keccak256(
                                    "Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"
                                ),
                                owner,
                                spender,
                                value,
                                nonces[owner]++,
                                deadline
                            )
                        )
                    )
                ),
                v,
                r,
                s
            );

            require(
                recovered != address(0)
                && recovered == owner,
                "ERC2612: Invalid signer"
            );

            allowances[recovered][spender] = value;
        }

        emit Approval(owner, spender, value);
    }

    // solhint-disable-next-line func-name-mixedcase
    function DOMAIN_SEPERATOR() public view virtual returns (bytes32) {
        return block.chainid == INITIAL_CHAIN_ID
            ? INITIAL_DOMAIN_SEPARATOR
            : computeDomainSeperator()
            ;
    }

    function computeDomainSeperator() internal view virtual returns (bytes32) {
        return
            keccak256(
                abi.encode(
                    keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"),
                    keccak256(bytes(name)),
                    keccak256("1"),
                    block.chainid,
                    address(this)
                )
            );
    }
}