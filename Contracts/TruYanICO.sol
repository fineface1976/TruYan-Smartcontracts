
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./MZLx.sol";

contract TruYanICO is Ownable {
    MZLx public token;
    uint256 public startTime;
    uint256 public endTime;
    uint256 public basePrice = 0.001 ether; // $0.001
    uint256 public dailyIncrement = (0.1 ether - 0.001 ether) / 90 days;

    struct User {
        address upline;
        uint256 totalPurchased;
        uint256 referralRewards;
    }

    mapping(address => User) public users;

    constructor(address _token) {
        token = MZLx(_token);
        startTime = block.timestamp;
        endTime = startTime + 90 days;
    }

    function buyTokens(address _upline) external payable {
        require(block.timestamp <= endTime, "ICO ended");
        uint256 currentPrice = basePrice + (dailyIncrement * (block.timestamp - startTime) / 1 days);
        uint256 tokensBought = msg.value / currentPrice;

        // MLM rewards (6 levels, 2.5% each)
        address upline = _upline;
        for (uint i = 0; i < 6; i++) {
            if (upline == address(0)) break;
            uint256 reward = tokensBought * 25 / 1000; // 2.5%
            users[upline].referralRewards += reward;
            upline = users[upline].upline;
        }

        token.transfer(msg.sender, tokensBought);
    }

    function withdrawFunds() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }
}
