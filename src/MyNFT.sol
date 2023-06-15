// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/utils/Strings.sol";
import "@openzeppelin/token/ERC721/ERC721.sol";
import "@openzeppelin/access/Ownable.sol";

contract MyNFT is ERC721, Ownable {
    uint256 public tokenSupply;
    uint256 public constant MAX_SUPPLY = 6;
    uint256 public constant PRICE = 0.0001 ether;

    string public constant IPFS_URI =
        "ipfs://QmUsWe3d1JQMMj6gUva79xXTzqG6th9ycHVss1cEvevLAV/";

    address public immutable deployer;

    constructor() ERC721("MyNFT", "MN") {
        deployer = msg.sender;
    }

    function mint() external payable {
        require(tokenSupply < MAX_SUPPLY, "supply used");
        require(msg.value == PRICE, "wrong price");

        _mint(msg.sender, tokenSupply);
        tokenSupply++;
    }

    function viewBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function withdraw() external {
        require(msg.sender == deployer, "only owner can withdraw");
        payable(deployer).transfer(address(this).balance);
    }

    function _baseURI() internal pure override returns (string memory) {
        return IPFS_URI;
    }

    function renounceOwnership() public pure override {
        revert("cannot renounce");
    }

    function transferOwnership(address newOwner) public pure override {
        revert("cannot renounce");
    }
}
