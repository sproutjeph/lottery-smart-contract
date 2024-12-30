// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title Raffle
 * @author Jephthah Mbah
 * @notice This contract is a simple raffle contract that allows users to buy tickets and win prizes
 * @dev This contract is a simple raffle contract that allows users to buy tickets and win prizes
 */

contract Raffle {
    // Errors
    error Raffle__NotEnoughEthSent();

    uint256 private immutable i_entranceFee;
    // @dev This is the interval at which the raffle will be picked in seconds
    uint256 private immutable i_interval;
    address payable[] private s_players;
    uint256 private s_lastTimeStamp;

    // Events
    event RaffleEntered(address indexed player, uint256 amount);

    constructor(uint256 entranceFee, uint256 interval) {
        i_entranceFee = entranceFee;
        i_interval = interval;
        s_lastTimeStamp = block.timestamp;
    }

    function enterRaffle() external payable {
        if (msg.value < i_entranceFee) {
            revert Raffle__NotEnoughEthSent();
        }
        s_players.push(payable(msg.sender));
        emit RaffleEntered(msg.sender, msg.value);
    }

    function pickWinner() external view {
        if ((block.timestamp - s_lastTimeStamp) < i_interval) {
            revert();
        }
    }

    /**
     * getter functions
     */
    function getEntranceFee() external view returns (uint256) {
        return i_entranceFee;
    }
}
