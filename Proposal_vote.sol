//SPDX-Lisence-Identifier: UNLISENCED
pragma solidity ^0.8.0;
contract Pro_vote{
    struct Proposal{
        string name;
        uint voteCount;
    }
    Proposal[] public proposals;
    mapping(address => bool) public hasVoted;
    function addProposal(string memory _name) public{
        proposals.push(Proposal(_name,0));
        require(bytes(_name).length > 0, "Name required");

    }
    function vote( uint proposalIndex) public {
        require(!hasVoted[msg.sender], "Already Voted");
        require(proposalIndex < proposals.length, "Invalid");
        hasVoted[msg.sender] = true;
        proposals[proposalIndex].voteCount++;

    }
        function getWinner() public view returns (string memory) {

    uint winningVoteCount = 0;
    uint winningIndex = 0;

    for(uint i = 0; i < proposals.length; i++){

        if(proposals[i].voteCount > winningVoteCount){
            winningVoteCount = proposals[i].voteCount;
            winningIndex = i;
        }

    }

    return proposals[winningIndex].name;
}
    }