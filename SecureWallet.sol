//SPDX-Lisence-Identifier: UNLISENCED
pragma solidity ^0.8.0;
contract SecureWallet{
    address public owner;
    constructor(){
        owner= msg.sender;
    }
   function deposit() public payable{
   }
   function getBalance() public view returns(uint256){
    return address(this).balance;
   }
   function withdraw(uint256 amount) public{
    require(msg.sender == owner, "not the owner");
    require(address(this).balance >= amount, "not enough balance");
    payable(owner).transfer(amount);
   }
}