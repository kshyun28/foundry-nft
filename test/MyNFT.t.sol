// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/MyNFT.sol";

contract MyNFTTest is Test {
    MyNFT public myNFT;

    uint256 public mintPrice;
    uint256 public maxSupply;
    address public deployer = address(0x1234);
    address public minter = address(this);

    function setUp() public {
        vm.prank(deployer);
        myNFT = new MyNFT();
        mintPrice = myNFT.PRICE();
        maxSupply = myNFT.MAX_SUPPLY();
    }

    function testDeployer() public {
        assertEq(
            myNFT.owner(),
            deployer,
            "deployer should be the owner of contract"
        );
    }

    function testSuccessfulMint() public {
        vm.startPrank(minter);
        myNFT.mint{value: 0.0001 ether}();
        assertEq(myNFT.ownerOf(0), minter, "NFT owner not the same as minter");
        assertEq(
            myNFT.balanceOf(minter),
            1,
            "NFT owner balance not the same as expected"
        );
        assertEq(
            myNFT.viewBalance(),
            0.0001 ether,
            "Contract balance did not increment as expected"
        );
        vm.stopPrank();
    }

    function testMintMaxSupply() public {
        vm.startPrank(minter);
        // Mint until MAX_SUPPLY
        for (uint256 i = 0; i < maxSupply; i++) {
            myNFT.mint{value: 0.0001 ether}();
        }
        assertEq(
            myNFT.tokenSupply(),
            maxSupply,
            "token supply is not equal to max supply"
        );
        // Mint after max supply has been minted
        vm.expectRevert();
        myNFT.mint{value: 0.0001 ether}();
        vm.stopPrank();
    }

    function testWrongMintPrice() public {
        vm.startPrank(minter);
        // lower value
        vm.expectRevert();
        myNFT.mint{value: mintPrice - 1}();
        // higher value
        vm.expectRevert();
        myNFT.mint{value: mintPrice + 1}();
        vm.stopPrank();
    }

    function testOwnerWithdraw() public {
        // Mint NFT
        vm.startPrank(minter);
        myNFT.mint{value: 0.0001 ether}();
        vm.stopPrank();

        // Withdraw NFT Contract Ether Balance
        vm.startPrank(deployer);
        myNFT.withdraw();
        assertEq(
            address(deployer).balance,
            0.0001 ether,
            "Withdraw wallet balance did not increase"
        );
        vm.stopPrank();
    }

    function testNotOwnerWithdraw() public {
        // Mint NFT
        vm.startPrank(minter);
        myNFT.mint{value: 0.0001 ether}();
        vm.stopPrank();

        // Withdraw NFT Contract Ether Balance
        vm.startPrank(minter);
        vm.expectRevert();
        myNFT.withdraw();
        vm.stopPrank();
    }

    function testIpfsUri() public {
        vm.startPrank(minter);
        myNFT.mint{value: 0.0001 ether}();
        assertEq(
            myNFT.tokenURI(0),
            string.concat(myNFT.IPFS_URI(), "0"),
            "token URI does not match base IPFS URI"
        );
        vm.stopPrank();
    }

    function testTransferOwnership() public {
        vm.startPrank(deployer);
        vm.expectRevert();
        myNFT.transferOwnership(minter);
        vm.stopPrank();
    }

    function testRenounceOwnership() public {
        vm.startPrank(deployer);
        vm.expectRevert();
        myNFT.renounceOwnership();
        vm.stopPrank();
    }
}
