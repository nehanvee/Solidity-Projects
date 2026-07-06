//SPDX-Lisence-Identifier: UNLISENCED 
pragma solidity ^0.8.0;
contract Mini_Bank{ 
event Withdrawn(address user, uint amount); 
event Deposited(address user, uint amount); 
mapping(address => uint) public balances; 
function deposit() public payable{ 
require(msg.value>0, "Send more eth"); 
balances[msg.sender] += msg.value; 
emit Deposited(msg.sender, msg.value); } 
function withdraw() public{ 
emit Withdrawn(msg.sender, balances[msg.sender]); } 
function getBalance() public view returns(uint){
return balances[msg.sender]; } }
