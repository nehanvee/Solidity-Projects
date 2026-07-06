//SPDX-License-Identifier: UNLICENSED 
pragma solidity ^0.8.0;
contract NFT{ 
enum Tier{ 
Silver, 
Gold, 
Diamond } 
event MembershipMinted(uint tokenId, address member, Tier tier); 
event TierUpgraded(uint tokenId, Tier newTier); 
event MembershipRevoked(uint tokenId); 
address public owner; 
constructor(){ 
owner = msg.sender; } 
modifier onlyOwner(){ 
require(msg.sender == owner, "Not the owner"); 
_;
}
uint public nextTokenId = 1;
mapping(uint => address) public ownerOf;
mapping(uint => Tier) public membershipTier;
mapping(uint => bool) public isActive;
function mintMembership( address member , Tier tier ) public onlyOwner{
    uint tokenId = nextTokenId;
    ownerOf[tokenId] = member;
    membershipTier[tokenId] = tier;
    isActive[tokenId] = true;
    nextTokenId++;
    emit MembershipMinted(tokenId, member, tier);
}
function verifyMembership(uint tokenId)public view returns (address, Tier, bool){
require(ownerOf[tokenId] != address(0), "Token does not exist");

return (ownerOf[tokenId],membershipTier[tokenId], isActive[tokenId] );
} 
function upgradeTier(uint tokenId, Tier newTier) public onlyOwner { 
require(ownerOf[tokenId] != address(0), "Token does not exist"); 
require(isActive[tokenId], "Membership inactive");
if (membershipTier[tokenId] == Tier.Silver) {
    membershipTier[tokenId] = Tier.Gold;
}
else if (membershipTier[tokenId] == Tier.Giamond) {
    membershipTier[tokenId] = Tier.Diamond;
}
else {
    revert("Already highest tier");
}
emit TierUpgraded(tokenId, newTier);
} function revokeMembership(uint tokenId) public onlyOwner { 
require(ownerOf[tokenId] != address(0), "Token does not exist"); 
require(isActive[tokenId], "Membership already inactive");
isActive[tokenId] = false;
emit MembershipRevoked(tokenId); } }
