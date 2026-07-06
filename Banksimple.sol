//SPDX-Lisence-Identifier: UNLISENCED 
pragma solidity ^0.8.0; 
contract Simple_bank{ 
mapping(address => uint) public balances; 

function deposit() public payable{ 
require(msg.value> 0, "send more eth"); 
balances[msg.sender] += msg.value;
}
function Withdraw(uint amount) public {
    require(balances[msg.sender] >= amount, "not enough balance");
    balances[msg.sender] -= amount;
    payable(msg.sender).transfer(amount);
}
function getContractBalance() public view returns(uint){
    return address(this).balance;
}