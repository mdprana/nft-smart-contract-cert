// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {CertificateNFT} from "../src/CertificateNFT.sol";

contract MintNFTScript is Script {
    function run() external {
        vm.startBroadcast();
        CertificateNFT nft = CertificateNFT(0xa1134A87548b239c542137eA228990722e2e835E); // smart contract address
        nft.mintNFT("https://ipfs.io/ipfs/bafkreigxnhhmoeyg5vjfcrlr4yluostuxuivpehn77i5uzt4uc4e5zdp2i");
        vm.stopBroadcast();
    }
}