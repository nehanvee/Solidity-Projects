//SPDX-Lisence-Identifier: UNLISENCED 
pragma solidity ^0.8.0; 
contract Escrow{ 
address public buyer; 
address public seller; 
uint public amount; 
bool public isCompleted; 
constructor(address _seller){ 
buyer = msg.sender; 
seller = _seller; } 
function deposit() public payable{ 
require(msg.sender == buyer, "Only Buyer can deposit"); 
require(!isCompleted, "transction already completed"); 
amount += msg.value; } 
function releasePayment() public { 
require(msg.sender == buyer, "not the buyer"); 
payable(seller).transfer(amount); 
amount = 0; 
isCompleted = true; } 
function refundPayment() public{ 
require(msg.sender == seller, "only seller can refund"); 
payable(buyer).transfer(amount); 
amount = 0; 
isCompleted = true; } }