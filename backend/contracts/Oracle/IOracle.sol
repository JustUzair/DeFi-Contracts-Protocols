// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.7;

interface IOracle {
    function getData(
        bytes32 key
    ) external view returns (bool result, uint256 date, uint256 payload);
}
