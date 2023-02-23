// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract GovernanceToken is ERC20, Ownable {
    constructor() ERC20("Governance Token", "GTK") Ownable() {}

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }
}
