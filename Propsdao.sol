// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DAOContract {

    // ---------------- ENUMS ----------------
    enum VoteChoice {
        None,
        Yes,
        No
    }
    event VoteCast(uint proposalId, address voter, VoteChoice choice);
    event ProposalExecuted(uint proposalId);
    event MemberAdded(address member);

    // ---------------- STRUCTS ----------------
    struct Proposal {
        string description;
        uint yesVotes;
        uint noVotes;
        uint deadline;
        bool executed;
        address proposer;
    }

    // ---------------- STATE VARIABLES ----------------
    address public owner;
    uint public quorum;
    uint public votingDuration;

    mapping(address => bool) public isMember;

    Proposal[] public proposals;

    // proposalId => voter address => vote choice
    mapping(uint => mapping(address => VoteChoice)) public votes;

    // ---------------- CONSTRUCTOR ----------------
    constructor() {
        owner = msg.sender;
        quorum = 3;
        votingDuration = 7 days;
    }

    // ---------------- MODIFIERS ----------------
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    // ---------------- FUNCTIONS ----------------

    function createProposal(string memory description) public {
        require(isMember[msg.sender], "Not a DAO member");
        require(bytes(description).length > 0, "Empty proposal");

        Proposal memory newProposal = Proposal({
            description: description,
            yesVotes: 0,
            noVotes: 0,
            deadline: block.timestamp + votingDuration,
            executed: false,
            proposer: msg.sender
        });

        proposals.push(newProposal);
    }
    function vote(uint proposalId, VoteChoice choice) public{
        require(isMember[msg.sender], "Not a DAO member");
        require(proposalId < proposals.length, "Proposal does not exist");
        require (votes[proposalId][msg.sender] == VoteChoice.None, "Already voted");
        require( block.timestamp < proposals[proposalId].deadline,  "Voting closed");
        require(choice != VoteChoice.None, "Invalid choice");

       votes[proposalId][msg.sender] = choice;
       votes[proposalId][msg.sender] == VoteChoice.None;

       if (choice == VoteChoice.Yes) {
    proposals[proposalId].yesVotes++;
}
else if (choice == VoteChoice.No) {
    proposals[proposalId].noVotes++;
}
emit VoteCast(proposalId, msg.sender, choice);
}
function executeProposal(uint proposalId) public onlyOwner {

    require(proposalId < proposals.length, "Proposal does not exist");

    require(
        block.timestamp >= proposals[proposalId].deadline,
        "Voting still open"
    );

    require(
        !proposals[proposalId].executed,
        "Proposal already executed"
    );

    require(
        proposals[proposalId].yesVotes +
        proposals[proposalId].noVotes >= quorum,
        "Quorum not reached"
    );

    require(
        proposals[proposalId].yesVotes >
        proposals[proposalId].noVotes,
        "Proposal rejected"
    );

    proposals[proposalId].executed = true;

    emit ProposalExecuted(proposalId);
}

function addMember(address member) public onlyOwner {
    require(member != address(0), "Invalid address");
    require(!isMember[member], "Already a member");

    isMember[member] = true;

    emit MemberAdded(member);

}