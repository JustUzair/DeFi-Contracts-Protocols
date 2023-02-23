// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract UnderlyingToken is ERC20 {
    constructor() ERC20("LP Token", "LPT") {}

    function faucet(address to, uint256 amount) external {
        _mint(to, amount);
    }
}
