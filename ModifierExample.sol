//SPDX-Lisence-Identifier: UNLISENCED 
pragma solidity ^0.8.0; 
contract ModifierExample{ 
address public owner; 
constructor() { 
owner = msg.sender; } 
modifier onlyOwner() { 
require(msg.sender == owner, "not the owner"); 
_; } 
uint public number; 
function ChnageNum(uint _num) public { 
number = _num; } }
