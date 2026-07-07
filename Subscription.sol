//SPDX-Lisence-Identifier: UNLISENCED
pragma solidity ^0.8.0;
contract Subscription{
address public owner;
constructor() {
 owner = msg.sender;
}

uint public subscriptionPrice;

uint public subscriptionDuration;

mapping(address => uint) public expiryTime;
mapping(address => bool) public isActive;

function subscribe() public payable{
require(msg.value == subscriptionPrice, "Incorrect payment");

require(!isActive[msg.sender], "Already subscribed");

require( block.timestamp >= expiryTime[msg.sender],"Subscription still active");
}
event SubscriptionRenewed(address user, uint newExpiry);

function renewSubscription() public payable {
    require(msg.value == subscriptionPrice, "Incorrect payment");

    require(
        expiryTime[msg.sender] > 0,
        "No previous subscription found"
    );

    if (block.timestamp < expiryTime[msg.sender]) {
        expiryTime[msg.sender] =
            expiryTime[msg.sender] + subscriptionDuration;
    } else {
        expiryTime[msg.sender] =
            block.timestamp + subscriptionDuration;
    }

    isActive[msg.sender] = true;

    emit SubscriptionRenewed(
        msg.sender,
        expiryTime[msg.sender]
    );
}
function withdraw() public {
    require(address(this).balance > 0, "No funds available");
    require(msg.sender == owner, "not the owner");
    payable(owner).transfer(address(this).balance);
}

}