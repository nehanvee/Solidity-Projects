//SPDX-Lisence-Identifier: UNLISENCED
pragma solidity ^ 0.8.0;
contract SimpleVoting{
    uint public yesVotes;
    uint public noVotes;
    mapping(address => bool) public hasVoted;
    function vote(bool _voteYes) public{
        require(!hasVoted[msg.sender], "You have already voted");
        hasVoted[msg.sender] = true;
        if(_voteYes){
          yesVotes++;
        }
        else{
            noVotes++;
        }
    }
    function getResult() public view returns (string memory ){
        if(yesVotes > noVotes){
            return "YES wins";
        }
        else if(yesVotes < noVotes){
            return "No wins";
        }
        else{
            return "a tie";
        }
    }
}