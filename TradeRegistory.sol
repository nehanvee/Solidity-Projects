//SPDX-Lisence-Identifier: UNLISENCED
pragma solidity ^0.8.0;
contract TraderRegistery{
    address public owner;
    constructor(){
        owner = msg.sender;
    }
    struct Trader{
        string name;
        bool approved;
        uint profitshare;
    }
    mapping(address => Trader) public traders;
    function addTrader(string memory _name, uint _profitshare) public{
        traders[msg.sender] = Trader(_name, false, _profitshare);
    }
    modifier onlyOwner(){
        require(msg.sender == owner, " not the owner");
        _;
    }

    function approveTrader(address _trader) public onlyOwner() {
        traders[_trader].approved = true;
    }

    function isApproved(address _trader) public view returns(bool){
       return traders[_trader].approved;
    }
}