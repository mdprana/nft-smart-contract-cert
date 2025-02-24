// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {CertificateNFT} from "../src/CertificateNFT.sol";

contract CertificateNFTTest is Test {
    CertificateNFT public certificateNFT;
    address public owner = address(1);
    address public user2 = address(2);

    function setUp() public {
        vm.prank(owner);
        certificateNFT = new CertificateNFT();
    }

    function testMintNFT() public {
        vm.prank(owner);
        uint256 tokenId =
            certificateNFT.mintNFT("https://ipfs.io/ipfs/bafkreigxnhhmoeyg5vjfcrlr4yluostuxuivpehn77i5uzt4uc4e5zdp2i");

        assertEq(tokenId, 1);
        assertEq(certificateNFT.ownerOf(1), owner);
    }

    function testRevertNonOwnerMint() public {
        vm.expectRevert("Ownable: caller is not the owner");
        vm.prank(user2);
        certificateNFT.mintNFT("https://ipfs.io/ipfs/bafkreigxnhhmoeyg5vjfcrlr4yluostuxuivpehn77i5uzt4uc4e5zdp2i");
    }

    function testRevertTransfer() public {
        vm.prank(owner);
        uint256 tokenId =
            certificateNFT.mintNFT("https://ipfs.io/ipfs/bafkreigxnhhmoeyg5vjfcrlr4yluostuxuivpehn77i5uzt4uc4e5zdp2i");

        vm.expectRevert(CertificateNFT.CannotTransfer.selector);
        vm.prank(owner);
        certificateNFT.transferFrom(owner, user2, tokenId);
    }

    function testRevertApprove() public {
        vm.prank(owner);
        uint256 tokenId =
            certificateNFT.mintNFT("https://ipfs.io/ipfs/bafkreigxnhhmoeyg5vjfcrlr4yluostuxuivpehn77i5uzt4uc4e5zdp2i");

        vm.expectRevert(CertificateNFT.CannotApprove.selector);
        vm.prank(owner);
        certificateNFT.approve(user2, tokenId);
    }

    function testRevertApproveForAll() public {
        vm.prank(owner);
        certificateNFT.mintNFT("https://ipfs.io/ipfs/bafkreigxnhhmoeyg5vjfcrlr4yluostuxuivpehn77i5uzt4uc4e5zdp2i");

        vm.expectRevert(CertificateNFT.CannotApproveForAll.selector);
        vm.prank(owner);
        certificateNFT.setApprovalForAll(user2, true);
    }
}
