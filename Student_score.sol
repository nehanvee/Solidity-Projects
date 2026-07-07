// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract StudentScore {
 struct Student {
    string name;
    uint score;
 }
 mapping (address => Student) public students;

function addStudent(string memory _name, uint _score) public {
    students[msg.sender] = Student(_name, _score);

}
function updateScore(uint _newscore) public {
    students[msg.sender].score = _newscore;
}
function getScore() public view returns(uint) {
    return students[msg.sender].score;
}
}