// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./IERC721.sol";
import "./IERC721TokenReceiver.sol";
import "./extensions/IERC721Metadata.sol";
import "../../utils/introspection/IERC165.sol";
import "../../utils/Strings.sol";

contract ERC721 is IERC165, IERC721, IERC721Metadata {
    using Strings for uint256;

    string public name;
    string public symbol;
 
    mapping (address => uint256) public balanceOf;
    mapping (uint256 => address) public ownerOf;
    mapping (uint256 => address) public getApproved;
    mapping (address => mapping(address => bool)) public isApprovedForAll;

    function _baseURI()
        internal view virtual
        returns(string memory)
    {
        return "";
    }

    constructor(string memory name_, string memory symbol_) {
        name = name_;
        symbol = symbol_;
    }

    function tokenURI(uint256 tokenId) public view virtual returns (string memory) {
        require(ownerOf[tokenId] != address(0), "ERC721Metadata: nonexistent token");
        string memory baseURI = _baseURI();
        return bytes(baseURI).length > 0
            ? string(abi.encodePacked(baseURI, tokenId.toString()))
            : ""
            ;
    }

    function approve(address approved, uint256 tokenId)
        external payable 
    {
        address owner = ownerOf[tokenId];
        require(
            msg.sender == owner
            || isApprovedForAll[owner][msg.sender],
            "Not Approved"
        );

        getApproved[tokenId] = approved;
        emit Approval(owner, approved, tokenId);
    }

    function setApproveForAll(address operator, bool approved)
        external
    {
        isApprovedForAll[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);
    }

    function safeTransferFrom(address from, address to, uint256 tokenId)
        external payable
    {
        this.transferFrom(from, to, tokenId);
        require(
            to.code.length == 0
            || ERC721Receiver(to).onERC721Received(msg.sender, from, tokenId, "") ==
                ERC721Receiver.onERC721Received.selector,
            "Transfer to non ERC271Receiver"    
        );
    }

    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data)
        external payable
    {
        this.transferFrom(from, to, tokenId);
        require(
            to.code.length == 0
            || ERC721Receiver(to).onERC721Received(msg.sender, from, tokenId, data) ==
                ERC721Receiver.onERC721Received.selector,
            "Transfer to non ERC271Receiver"    
        );
    }

    function transferFrom(address from, address to, uint256 tokenId)
        external payable
    {
        require(from == ownerOf[tokenId], "Invalid from");
        require(to != address(0), "Invalid to");
        require(
            msg.sender == from
            || isApprovedForAll[from][msg.sender]
            || msg.sender == getApproved[tokenId],
            "Not authorized to transfer"
        );

        balanceOf[from]--;
        balanceOf[to]++;

        ownerOf[tokenId] = to;
        delete getApproved[tokenId];
        emit Transfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public view virtual
        returns (bool)
    {
        return interfaceId == type(IERC165).interfaceId
            || interfaceId == type(IERC721).interfaceId
            || interfaceId == type(IERC721Metadata).interfaceId
            ;
    }

    function _mint(address to, uint256 tokenId)
        internal virtual
    {
        require(to != address(0), "Invalid Recipient");
        require(ownerOf[tokenId] == address(0), "Token minted");
        balanceOf[to]++;
        ownerOf[tokenId] = to;
        emit Transfer(address(0), to, tokenId);
    }

    function _burn(uint256 tokenId)
        internal virtual 
    {
        address owner = ownerOf[tokenId];
        require(owner != address(0), "Not minted");
        balanceOf[owner]--;
        delete ownerOf[tokenId];
        delete getApproved[tokenId];
        emit Transfer(owner, address(0), tokenId);
    }

    function _safeMint(address to, uint256 tokenId)
        internal virtual
    {
        _mint(to, tokenId);
        require(
            to.code.length == 0
            || ERC721Receiver(to).onERC721Received(msg.sender, address(0), tokenId, "") ==
                ERC721Receiver.onERC721Received.selector,
            "Unsafe transfer"    
        ); 
    }

    function _safeMint(address to, uint256 tokenId, bytes memory data)
        internal virtual
    {
        _mint(to, tokenId);
        require(
            to.code.length == 0
            || ERC721Receiver(to).onERC721Received(msg.sender, address(0), tokenId, data) ==
                ERC721Receiver.onERC721Received.selector,
            "Unsafe transfer"    
        ); 
    }
}
