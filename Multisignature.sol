//SPDX-Lisence-Identifier: UNLISENCED
pragma solidity ^0.8.0;
contract multisignature{
    address[] public owners;

    struct Transaction {
    address to;
    uint amount;
    uint approvalCount;
    bool executed;
}
mapping(uint=>mapping(address => bool)) public approved;
mapping(address => bool) public isOwner;
Transaction[] public transactions;
constructor(address[] memory _owners) {
    owners = _owners;

    for (uint i = 0; i < _owners.length; i++) {
        isOwner[_owners[i]] = true;
    }
}
event TransactionCreated(
    uint transactionId,
    address creator,
    address recipient,
    uint amount
);
modifier onlyOwner() {
    require(isOwner[msg.sender], "Not an owner");
    _;
}
function createTransaction(address _to, uint _amount)
    public
    onlyOwner
{
    require(_to != address(0), "Invalid recipient");
    require(_amount > 0, "Amount must be greater than zero");

    transactions.push(
        Transaction({
            to: _to,
            amount: _amount,
            approvalCount: 0,
            executed: false
        })
    );

    emit TransactionCreated(
        transactions.length - 1,
        msg.sender,
        _to,
        _amount
    );
}

}