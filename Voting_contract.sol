// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    struct Proposal{
        string name;
        uint voteCount;
    }
    Proposal[] public proposals;
    mapping(address => bool) public hasVoted;
    function createProposal(string memory _name) public {
        proposals.push(Proposal(_name, 0));
    }
   function vote(uint proposalIndex) public {
    require(!hasVoted[msg.sender], "you have already voted");
    proposals[proposalIndex].voteCount++;
    hasVoted[msg.sender] = true;
   }
   function getWinner() public view returns(string memory) {
    uint Winningvotecount=0;
    uint WinningIndex=0;
    for(uint i = 0; i< proposals.length; i++){
        if(proposals[i].voteCount > Winningvotecount){
            Winningvotecount = proposals[i].voteCount;
            WinningIndex = i;
        }
    }
    return proposals[WinningIndex].name;
   }
}