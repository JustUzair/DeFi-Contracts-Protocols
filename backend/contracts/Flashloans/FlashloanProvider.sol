// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "./IFlashloanUser.sol";

contract FlashloanProvider is ReentrancyGuard {
    mapping(address => IERC20) public tokens;

    constructor(address[] memory _tokens) {
        // Pass list of addresses of supported tokens while deploying the contract
        for (uint i = 0; i < _tokens.length; i++) {
            tokens[_tokens[i]] = IERC20(_tokens[i]);
        }
    }

    function executeFlashloan(
        address callback,
        uint256 amount,
        address _token,
        bytes memory data
    ) external nonReentrant {
        IERC20 token = tokens[_token];
        uint256 originalBalance = token.balanceOf(address(this));
        require(address(token) != address(0), "Token not supported");
        require(originalBalance >= amount, "Not enough tokens to lend...");
        token.transfer(callback, amount);
        IFlashloanUser(callback).flashloanCallback(amount, _token, data);
        require(token.balanceOf(address(this)) == originalBalance, "Flashloan not reimbursed");
    }
}
