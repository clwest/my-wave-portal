// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 public totalWaves;
    uint256 private seed;

    event NewWave(
        address indexed from,
        uint256 timestamp,
        string message,
        uint256 totalWaves
    );

    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
        uint256 totalWaves;
    }

    Wave[] public waves;

    mapping(address => uint256) public lastWavedAt;

    constructor() payable {
        console.log("We have been contructed!");
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function wave(string memory _message) public {
        require(
            lastWavedAt[msg.sender] + 45 seconds < block.timestamp,
            "wait 45 seconds before waving again"
        );
        lastWavedAt[msg.sender] = block.timestamp;

        totalWaves += 1;
        console.log("%s has waved", msg.sender);

        waves.push(Wave(msg.sender, _message, block.timestamp, totalWaves));

        seed = (block.timestamp + block.difficulty + seed) % 100;
        if (seed <= 50) {
            console.log("%s won!", msg.sender);

            uint256 prizeAmount = 1 ether;
            require(
                prizeAmount <= address(this).balance,
                "trying to withdraw more than the contract balance"
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "failed to withdraw money from contract");
        }
        emit NewWave(msg.sender, block.timestamp, _message, totalWaves);
    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }
}
