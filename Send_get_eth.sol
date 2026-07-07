//SPDX-Lisence-Identifier: UNLISENCED
pragma solidity ^0.8.0;
contract myToken{
  address public owner;
  uint public totalSupply;
  uint public tokenPrice = 1 ether;
  event TokensTransferred(address from, address to, uint amount);
  event TokensPurchased(address buyer, uint amount);
  event Withdrawal(address owner, uint amount);
  mapping(address=> uint) public balances;

  constructor(){
    owner = msg.sender;
  }
  modifier onlyOwner() {
    require(msg.sender == owner, "not the owner");
    _;
  }
  function mint( address to, uint amount) public onlyOwner() {
    balances[to] += amount;
    totalSupply += amount;
  }
  function buyTokens() public payable {

    require(msg.value>= tokenPrice, "not enough eth");
    uint tokensToBuy = msg.value / tokenPrice;
    require(msg.value > 0, "Send ETH to buy tokens");
    require(tokensToBuy > 0, "Send more eth");
    balances[msg.sender] += tokensToBuy;
    totalSupply += tokensToBuy;
    emit TokensPurchased(msg.sender, tokensToBuy);
  }
  function transfer(address to, uint amount) public onlyOwner{
    require(balances[msg.sender] >= amount, "no sufficient eth");
    require(to != address(0), "inavlid user");
    balances[msg.sender] -= amount;
    balances[to] += amount;
    emit TokensTransferred(msg.sender, to, amount);
  }
  function withdraw() public onlyOwner() {
    payable(owner).transfer(address(this).balance);
    emit Withdrawal(owner, address(this).balance);

  }

}