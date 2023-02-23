// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface IFlashloanUser {
    function flashloanCallback(uint256 amount, address token, bytes memory data) external;
}
