//SPDX-License-Identifier: UNLICENSED 
pragma solidity ^0.8.0;
contract FavoriteNumber { 
uint public favoritenumber; 
function setNumber(uint _favoritenumber) public { 
favoritenumber = _favoritenumber; } 
function doubleNum(uint _favoritenumber) public { 
favoritenumber = _favoritenumber * 2; } 
function getNum() public view returns(uint) { 
return favoritenumber; } }