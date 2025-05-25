
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./MZLx.sol";

contract TruYanMining is Ownable {
    MZLx public token;
    uint256 public dailyReward = 1.2 * 10**18; // 1.2 MZLx/day
    mapping(address => uint256) public lastMined;

    constructor(address _token) {
        token = MZLx(_token);
    }

    function mine() external {
        require(block.timestamp >= lastMined[msg.sender] + 1 days, "Wait 24h");
        lastMined[msg.sender] = block.timestamp;
        token.mint(msg.sender, dailyReward);
    }

    function setDailyReward(uint256 _newReward) external onlyOwner {
        dailyReward = _newReward;
    }
}
