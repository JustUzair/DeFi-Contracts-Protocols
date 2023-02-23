# DeFi Contracts

## This repo consists of various DeFi protocols and contracts, which are a part of my personal project

## Frame work used : Hardhat

- Collateral Backed Token (CBT) - [0xC550b626615b95605ef83DF4E3b5E75424169409](https://goerli.etherscan.io/address/0xC550b626615b95605ef83DF4E3b5E75424169409#code)

  - This contract swaps a compatible ERC20 token passed as collateral, with the contract's CBT token.

- Custom Price Feed Oracle - [0x04fB4D72356aE8f797ADE2dc3715Dc9d325957e0](https://goerli.etherscan.io/address/0x04fb4d72356ae8f797ade2dc3715dc9d325957e0#code)

  - Reads the bitcoin price from the coingecko package and updates the price once on deployment.
  - To get price of the bitcoin from the contract use the following bytes32 string [0xee62665949c883f9e0f6f002eac32e00bd59dfe6c34e92a91c37d6a8322d6489](https://goerli.etherscan.io/address/0x04fb4d72356ae8f797ade2dc3715dc9d325957e0#readContract)

- Simple Liquidity Pool - [0x27911598608Eb92e61f9223a4cAc226d0E1fAdcE](https://goerli.etherscan.io/address/0x27911598608Eb92e61f9223a4cAc226d0E1fAdcE#code)
  - Investors invest the underlying tokens in the liquidity pool (underlying tokens a.k.a utility token)
  - They get LPToken in return (Liquidity Pool Token)
  - They also get rewarded for investing, the reward is fixed at 1 reward per investor per block
  - The beneficiary gets rewarded with the governance token.
- Flashloan
  - Flashloan Provider - [0x31F4f241EAf0e684D87C9500B814A04a0604df61](https://goerli.etherscan.io/address/0x31F4f241EAf0e684D87C9500B814A04a0604df61#code)
    - provides the flashloan to the flashloan user for the required amount
  - Flashloan User/Consumer - [0x2E2FBaF6cd9Def956179fda6e2AABd890CdCd099](https://goerli.etherscan.io/address/0x2E2FBaF6cd9Def956179fda6e2AABd890CdCd099#code)
    - consumes the flashloan provided by the flashloan provider
    - simple implementation where, user gets and immediately returns the flashloans
- DAO - [0x814854974ECb0F432b0131619a832f0Acb838a27](https://goerli.etherscan.io/address/0x814854974ECb0F432b0131619a832f0Acb838a27#code)
  - DAO for accepting/rejecting the proposals through the votes from the stakeholders
