// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.7;

contract Oracle {
    struct Data {
        // Structure of data to be read to and from oracle
        uint256 timestamp;
        uint256 payload;
    }
    address public admin;
    mapping(address => bool) public reporters; // check if the user is allowed to report the data to the oracle
    mapping(bytes32 => Data) public data;

    constructor(address _admin) {
        admin = _admin;
    }

    function updateReporter(address reporter, bool isReporter) external {
        require(msg.sender == admin, "Only admin can change the reporter");
        reporters[reporter] = isReporter;
    }

    function updateData(bytes32 key, uint256 payload) external {
        require(reporters[msg.sender] == true, "Only reporters can report the data to the oracles");
        data[key] = Data(block.timestamp, payload);
    }

    function getData(
        bytes32 key
    ) external view returns (bool result, uint256 timestamp, uint256 payload) {
        if (
            data[key].timestamp == 0
        ) // data for given key doesn't exist, therefore a default value 0 is returned
        {
            return (false, 0, 0);
        }
        return (true, data[key].timestamp, data[key].payload);
    }
}
