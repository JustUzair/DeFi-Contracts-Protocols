// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/*
    This contract swaps the ERC20 token passed as collateral token with CBT token.
 */

contract CollateralBackedToken is ERC20 {
    IERC20 public collateral;
    uint256 public price = 1 * 1e18; // similar to wrapped ether, 1 ETH = 1 wETH

    constructor(address _collateral) ERC20("Collateral Backed Token", "CBT") {
        collateral = IERC20(_collateral);
    }

    function deposit(uint256 collateralAmount) external {
        collateral.transferFrom(msg.sender, address(this), collateralAmount); // Receive collateral token and store in contract
        _mint(msg.sender, collateralAmount * price); // Mint the new token based on price, for the received collateral
    }

    function withdraw(uint tokenAmount) external {
        require(balanceOf(msg.sender) >= tokenAmount, "Not enough balance");
        _burn(msg.sender, tokenAmount);
        collateral.transfer(msg.sender, (tokenAmount / price));
    }
}
