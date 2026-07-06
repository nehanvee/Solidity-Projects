//SPDX-License-Identifier: UNLISENCED 
pragma solidity ^0.8.0;
contract Minitoken{ 
address public owner; 
uint public totalsupply; 
mapping(address => uint) public balances; 
constructor() { owner = msg.sender; } 
modifier onlyOwner() { 
require(msg.sender == owner, "Not the owner"); 
_; } 
function mint(address to, uint amount) public onlyOwner() { 
require(to != address(0), "invalid user"); 
require(balances[msg.sender] >= amount, "insufficient balance"); 
balances[to] += amount; 
balances[msg.sender] -= amount; 
totalsupply += amount; } 
function balanceOf(address user) public view returns(uint) { 
return balances[user]; } }
