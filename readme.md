# DeFi Contracts

## This repo consists of various DeFi protocols and contracts, which are a part of my personal project

## Frame work used : Hardhat

- Collateral Backed Token (CBT) - [0x40b14e05dF9704D66D1759F12e320BbCDb0b6223 ](https://sepolia.etherscan.io/address/0x40b14e05dF9704D66D1759F12e320BbCDb0b6223#code)

  - This contract swaps a compatible ERC20 token passed as collateral, with the contract's CBT token.

- Custom Price Feed Oracle - [0xb6391e169846a995103b828366d50ea6efcf2173](https://sepolia.etherscan.io/address/0xb6391e169846a995103b828366d50ea6efcf2173#code)

  - Reads the bitcoin price from the coingecko package and updates the price once on deployment.
  - To get price of the bitcoin from the contract use the following bytes32 string [0xee62665949c883f9e0f6f002eac32e00bd59dfe6c34e92a91c37d6a8322d6489](https://sepolia.etherscan.io/address/0xb6391e169846a995103b828366d50ea6efcf2173#readContract)

- Simple Liquidity Pool - [0x59b40d9A91De3687EB5D7C67c58cAca89a3CCd57](https://sepolia.etherscan.io/address/0x59b40d9A91De3687EB5D7C67c58cAca89a3CCd57#code)
  - Investors invest the underlying tokens in the liquidity pool (underlying tokens a.k.a utility token)
  - They get LPToken in return (Liquidity Pool Token)
  - They also get rewarded for investing, the reward is fixed at 1 reward per investor per block
  - The beneficiary gets rewarded with the governance token.
- Flashloan
  - Flashloan Provider - [0x952532b7C33b462b684DeedC9182D0dAf24a095a](https://sepolia.etherscan.io/address/0x952532b7C33b462b684DeedC9182D0dAf24a095a#code)
    - provides the flashloan to the flashloan user for the required amount
  - Flashloan User/Consumer - [0xee31f2188c33772703606c3b81441615c9a34B1b](https://sepolia.etherscan.io/address/0xee31f2188c33772703606c3b81441615c9a34B1b#code)
    - consumes the flashloan provided by the flashloan provider
    - simple implementation where, user gets and immediately returns the flashloans
- DAO - [0x7d0b40d484A05FAA3f977dcBe1681b25B5c18E85](https://sepolia.etherscan.io/address/0x7d0b40d484A05FAA3f977dcBe1681b25B5c18E85#code)
  - DAO for accepting/rejecting the proposals through the votes from the stakeholders
