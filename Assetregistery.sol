//SPDX-Lisence-Identifier: UNLISENCED
pragma solidity ^0.8.0;
contract AssetRegistery{
    struct Asset{
        string name;
        uint value;
        address owner;
        bool exists;
    }
    event AssetTransferred(
    uint assetId,
    address from,
    address to
);
address public registrar;
    address public owner;
    constructor(){
      owner = msg.sender;
      registrar = msg.sender;
    }
    event assetRegistered(uint assetId, address owner);
    modifier onlyRegistrar(){
      require(registrar == msg.sender,"not the registrar");
      _;
    }
    mapping(uint => Asset) public assets;
    uint public assetCount;

    function registerAsset(string memory _name, uint _value) public onlyRegistrar() {
        assetCount++;
        require(msg.sender == owner, "not the owner");
        assets[assetCount] = Asset( _name , _value,msg.sender, true );
        emit assetRegistered(assetCount, msg.sender);
    }
    function transferAsset(uint _id, address _newOwner, address _oldOwner) public {
    require(assets[_id].owner == msg.sender, "Not the owner");
    assets[_id].owner = _oldOwner;
    assets[_id].owner = _newOwner;
   require(_newOwner != address(0), "Invalid address");
   emit AssetTransferred(_id, msg.sender, _newOwner);
}
function updateAssetValue(uint _id, uint _newValue) public {
    require(assets[_id].owner == msg.sender, "not the owner");
    assets[_id].value = _newValue;
}
    function getAsset(uint _id) public view returns(string memory, address, uint){

    Asset memory a = assets[_id];
    return (a.name, a.owner, a.value);
}
}