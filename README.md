# foundry-nft

A sample ERC-721 implementation for EVM-compatible chains using [Solidity](https://soliditylang.org/) and [Foundry](https://book.getfoundry.sh/).

Sample assets used are my own [Reddit Collectible Avatars](https://opensea.io/collection/future-realities-dreamingcolors-x-reddit-collectib) personally signed by [Jas](https://www.jascolors.com/) herself. :)

## Quick Start
1. Configure `.env`
   - Generate [Etherscan](https://etherscan.io/) API key for verifying contracts.
   - Get deployer wallet `private key`. A **burner wallet** should be used for this. 
2. Deploy ERC-721 contract
    ```bash
    source .env
    ```
    Then,
    ```bash
    forge create --rpc-url https://rpc2.sepolia.org --private-key $PRIVATE_KEY --etherscan-api-key $ETHERSCAN_KEY --verify src/MyNFT.sol:MyNFT
    ```

## Running Tests
1. Run tests: `forge test`
2. Get test coverage: `forge coverage`

## Resources
For learning how to do this, I followed these tutorials:
- [RareSkills: Learn Solidity](https://www.rareskills.io/learn-solidity)
- [RareSkills: ERC721 Tutorial. How ERC721 works, Integrate with OpenSea, use IPFS](https://www.youtube.com/watch?v=LIoFbudNVZs&t=3025s&ab_channel=RareSkills)
- [RareSkills: Foundry Unit Tests](https://www.rareskills.io/post/foundry-testing-solidity)