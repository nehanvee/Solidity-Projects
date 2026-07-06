//SPDX-License-Identifier: UNLICENSED 
pragma solidity ^0.8.0;
contract Counter { 
uint public number; 
function increment(uint _number) public { 
number = _number + 1; } 
function decrement(uint _number) public { 
number = _number - 1;
} 
function CurrentNum() public view returns(uint) { 
return number; } }
