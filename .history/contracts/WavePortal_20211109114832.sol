// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";

contract WavePortal is VRFConsumerBase {
    uint256 public totalWaves;
    bytes32 public keyHash;
    uint256 public fee;
    uint256 public randomWaver;

    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
    }

    Wave[] public waves;

    constructor(
        address _VRFCoordinator,
        address _linkToken,
        bytes32 _keyHash,
        uint256 _fee
    ) VRFConsumerBase(_VRFCoordinator, _linkToken) {
        fee = _fee;
        keyHash = _keyHash;
    }

    function wave(string memory _message)
        public
        payable
        returns (bytes32 requestId)
    {
        requestId = requestRandomness(keyHash, fee);
        totalWaves += 1;
        console.log("%s has waved", msg.sender);

        waves.push(Wave(msg.sender, _message, block.timestamp));

        emit NewWave(msg.sender, block.timestamp, _message);

        uint256 prizeAmount = 0.0001 ether;
        require(
            prizeAmount <= address(this).balance,
            "trying to withdraw more than the contract balance"
        );
        (bool success, ) = (msg.sender).call{value: prizeAmount}("");
        require(success, "failed to withdraw money from contract");
    }

    function fulfillRandomness(bytes32 requestId, uint256 randomness)
        internal
        override
    {
        randomWaver = randomness;
    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }
}
