// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {CertificateNFT} from "../src/CertificateNFT.sol";
import "forge-std/console.sol";

contract DeployCertificateScript is Script {
    function run() external {
        vm.startBroadcast();
        
        CertificateNFT nft = new CertificateNFT();
        
        console.log("CertificateNFT deployed at:", address(nft));
        
        vm.stopBroadcast();
    }
}