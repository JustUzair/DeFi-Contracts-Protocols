# DeFi Contracts

## This repo consists of various DeFi protocols and contracts, which are a part of my personal project

## Frame work used : Hardhat

-   Collateral Backed Token (CBT) - [0xC550b626615b95605ef83DF4E3b5E75424169409](https://goerli.etherscan.io/address/0xC550b626615b95605ef83DF4E3b5E75424169409#code)

    -   This contract swaps a compatible ERC20 token passed as collateral, with the contract's CBT token.

-   Custom Price Feed Oracle - [0x04fB4D72356aE8f797ADE2dc3715Dc9d325957e0](https://goerli.etherscan.io/address/0x04fb4d72356ae8f797ade2dc3715dc9d325957e0#code)
    -   Reads the bitcoin price from the coingecko package and updates the price once on deployment.
    -   To get price of the bitcoin from the contract use the following bytes32 string [0xee62665949c883f9e0f6f002eac32e00bd59dfe6c34e92a91c37d6a8322d6489](https://goerli.etherscan.io/address/0x04fb4d72356ae8f797ade2dc3715dc9d325957e0#readContract)
