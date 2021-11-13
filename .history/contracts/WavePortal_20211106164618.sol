// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 public totalWaves;
    mapping(address => uint256) public addressOfWaves;
    address[] public wavers;

    constructor() {
        console.log("Switched to Hardhat so I can say I know it!");
    }

    function wave() public {
        totalWaves += 1;
        console.log("%s has waved", msg.sender);
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }
}
