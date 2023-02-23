// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface PriceOracleInterface {
    function getUnderlyingPrice(address cTokenAddress) external view returns (uint);
}
