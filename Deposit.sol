//SPDX-Lisence-Identifier: MIT 
pragma solidity ^0.8.0; 
contract Deposit{ 
event Deposited(address user, uint amount); 
mapping(address => uint) public balances; 
function deposit() public payable { 
require(msg.value > 0, "send more eth"); 
balances[msg.sender] += msg.value; 
emit Deposited(msg.sender, msg.value);

}
function getBalance() public view returns(uint) {
    return balances[msg.sender];
}
function withdraw(uint amount) public {
require(balances[msg.sender] >= amount, "Not enough balance");

balances[msg.sender] -= amount;

payable(msg.sender).transfer(amount);
} }