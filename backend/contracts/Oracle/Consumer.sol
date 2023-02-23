// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.7;
import "./IOracle.sol";

contract Consumer {
    IOracle public oracle;

    constructor(address _oracle) {
        oracle = IOracle(_oracle);
    }

    function testOracle() external view {
        bytes32 key = keccak256(abi.encodePacked("BTC/USD"));

        (bool result, uint256 timestamp, uint256 payload) = oracle.getData(key);
        require(result == true, "Couldn't get data");
        require(timestamp >= block.timestamp - 2 minutes, "Price is too old");
        // use price
    }
}
