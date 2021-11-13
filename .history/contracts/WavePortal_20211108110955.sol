// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 public totalWaves;
    address[] public hasWaved;

    event NewWave(address indexed from, uint256 timestamp, uint256 message);

    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
    }

    Wave[] public waves;

    constructor() {
        console.log("Switched to Hardhat so I can say I know it!");
    }

    function wave(string memory _message) public {
        totalWaves += 1;
        console.log("%s has waved", msg.sender);

        waves.push(Wave(msg.address, _message, block.timestamp));
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }
}
