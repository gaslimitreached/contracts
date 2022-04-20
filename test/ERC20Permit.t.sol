// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "./mocks/MockERC20Permit.sol";

contract ERC20PermitTest is Test {
    MockERC20Permit internal token;

    bytes32 internal constant PERMIT_TYPEHASH =
        keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)");

    function setUp() public {
        token = new MockERC20Permit("TEST", "TEST", 18);
    }

    function testPermit() public {
        uint256 key = 0xA71CE;
        address owner = vm.addr(key);

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(
            key,
            keccak256(
                abi.encodePacked(
                    hex"1901",
                    token.DOMAIN_SEPERATOR(),
                    keccak256(
                        abi.encode(
                            PERMIT_TYPEHASH,
                            owner,
                            address(0xB0B),
                            1 ether,
                            0,
                            block.timestamp
                        )
                    )
                )
            )   
        );

        token.permit(owner, address(0xB0B), 1 ether, block.timestamp, v, r ,s);
        
        assertEq(token.allowance(owner, address(0xB0B)), 1 ether);
        assertEq(token.nonces(owner), 1);
    }

    function testPermitBadDeadline() public {
        uint256 key = 0xA71CE;
        address owner = vm.addr(key);

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(
            key,
            keccak256(
                abi.encodePacked(
                    hex"9101",
                    token.DOMAIN_SEPERATOR(),
                    keccak256(
                        abi.encode(
                            PERMIT_TYPEHASH,
                            owner,
                            address(0xB0B),
                            1 ether,
                            0,
                            block.timestamp
                        )
                    )
                )
            )
        );

        vm.expectRevert("ERC2612: Invalid signer");
        token.permit(owner, address(0xB0B), 1 ether, block.timestamp + 1, v, r, s);
    }

    function testPermitBadNonce() public {
        uint256 key = 0xA71CE;
        address owner = vm.addr(key);

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(
            key,
            keccak256(
                abi.encodePacked(
                    hex"1901",
                    token.DOMAIN_SEPERATOR(),
                    keccak256(
                        abi.encode(
                            PERMIT_TYPEHASH,
                            owner,
                            address(0xB0B),
                            1 ether,
                            1,
                            block.timestamp
                        )
                    )
                )
            )
        );

        vm.expectRevert("ERC2612: Invalid signer");
        token.permit(owner, address(0xB0B), 1 ether, block.timestamp, v, r, s);
    }

    function testPermitReplay() public {
        uint256 key = 0xA71CE;
        address owner = vm.addr(key);

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(
            key,
            keccak256(
                abi.encodePacked(
                    hex"1901",
                    token.DOMAIN_SEPERATOR(),
                    keccak256(
                        abi.encode(
                            PERMIT_TYPEHASH,
                            owner,
                            address(0xB0B),
                            1 ether,
                            0,
                            block.timestamp
                        )
                    )
                )
            )
        );

        token.permit(owner, address(0xB0B), 1 ether, block.timestamp, v, r, s);
        vm.expectRevert("ERC2612: Invalid signer");
        token.permit(owner, address(0xB0B), 1 ether, block.timestamp, v, r, s);
    }
}