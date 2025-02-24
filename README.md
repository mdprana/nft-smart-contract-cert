# Certificate NFT Smart Contract

## Overview
This project implements a Certificate NFT Smart Contract using Solidity and Foundry. It allows the contract owner to mint NFTs representing digital certificates, preventing unauthorized transfers or approvals.

## Features
* ERC721-based Soulbound Certificate NFTs
* OnlyOwner Minting: Only the contract owner can mint new certificates.
* Soulbound Mechanism: NFTs cannot be transferred, ensuring authenticity.
* Metadata Storage: Stores metadata in a Base64-encoded JSON format.
* Test Suite: Includes tests for minting and security constraints using Foundry.

## About Soulbound Tokens
Soulbound tokens are non-transferable NFTs that remain permanently bound to their recipients. Unlike regular NFTs, soulbound tokens cannot be transferred or sold once minted, making them ideal for certificates, credentials, and other forms of digital identity. This project implements soulbound tokens by overriding transfer and approval functions to prevent any movement of tokens between addresses.

## Dependencies
This project uses OpenZeppelin libraries and Foundry for development. Ensure you have:
* Foundry installed ([Installation Guide](https://book.getfoundry.sh/getting-started/installation))
* Solidity 0.8.13 or higher
* OpenZeppelin 4.9.6

## Installation

```bash
# Install Foundry
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

## Usage
### Build

```bash
forge build
```

### Run Tests

```bash
forge test
```

### Format Code

```bash
forge fmt
```

### Gas Snapshots

```bash
forge snapshot
```

### Local Blockchain Node

```bash
anvil
```

## Deployment & Execution
After setting up environment variables in `.env`, use the following commands to execute various operations:

```bash
# Build the smart contract
forge build

# Run tests
forge test

# Load environment variables
source .env

# Deploy contract
forge create --rpc-url $RPC_URL --private-key $PRIVATE_KEY src/CertificateNFT.sol:CertificateNFT \
  --gas-limit 10000000 --gas-price 1000000000 --broadcast --verify \
  --verifier blockscout --verifier-url https://niskala.mandalachain.io/api \
  --optimize --optimizer-runs 200

# Run minting script
forge script --rpc-url $RPC_URL --private-key $PRIVATE_KEY script/MintNFT.sol:MintNFTScript --broadcast
```

## Contract Details
### `CertificateNFT.sol`
The `CertificateNFT` contract:
* Uses ERC721URIStorage for storing metadata.
* Implements Ownable to restrict minting access.
* Implements Soulbound Mechanism by overriding `transferFrom`, `approve`, and `setApprovalForAll` to disable transfers.
* Generates Base64-encoded metadata dynamically.

### `MintNFT.sol`
* This script allows the contract owner to mint new NFTs using Foundry scripts.
* Calls the `mintingNFT` function from `CertificateNFT.sol`.

## Running Tests

```bash
forge test
```

Test Cases:
* `testMintNFT`: Verifies that the owner can mint an NFT and checks the token ID and ownership.
* `testRevertNonOwnerMint`: Confirms non-owners cannot mint NFTs (reverts with "Ownable: caller is not the owner").
* `testRevertTransfer`: Tests that NFTs cannot be transferred (reverts with CannotTransfer error).
* `testRevertApprove`: Verifies that the approve function reverts with CannotApprove error.
* `testRevertApproveForAll`: Ensures setApprovalForAll reverts with CannotApproveForAll error.

## License
This project is licensed under the **[MIT License](LICENSE)**.
