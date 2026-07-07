// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract FavoriteNumber {
uint public yesVotes;
uint public noVotes;
uint public choice;
mapping(address => bool) public hasVoted;
function voteYes() public {
    yesVotes +=1;
    require (hasVoted[msg.sender] == false, "You have already voted");
    hasVoted[msg.sender] = true;
}
function voteNo() public {
    noVotes +=1;
    require(hasVoted[msg.sender] == false, "Already voted");
    hasVoted[msg.sender] = true;
}
function totalVotes() public view returns(uint , uint) {
    return (yesVotes, noVotes);
    }
function checkIfVoted(address user) public view returns(bool) {
    return hasVoted[user];
}
function getTotalVotes() public view returns(uint) {
    return yesVotes + noVotes;
}
function vote() public {
    require(hasVoted[msg.sender] == false, "Already voted");
    require(choice == 1 || choice == 2, "Invalid vote");

    if(choice == 1){
        yesVotes += 1;
    } else {
        noVotes += 1;
    }

    hasVoted[msg.sender] = true;
}
}