// SPDX-Lisence-Identifier: UNLISENCED
pragma solidity ^0.8.0;
contract Propfirm{
    address public owner;
    uint public firmBalance;
    uint public maxLoss = 1000;
    uint public scalingTarget = 10000;
    uint public topTraderReward = 1000;
    constructor(){
        owner = msg.sender;
    }
    struct TradeRecord {
    string action;
    uint amount;
}
enum ChallengeStage {
    Phase1,
    Phase2,
    Funded
}
event ProfitRecorded(
    address trader,
    uint amount
);
event LossRecorded(
    address trader,
    uint amount
);
    mapping(address => bool) public approvedTrader;
    mapping(address => uint) public profitTarget;
    mapping(address => bool) public targetReached;
    mapping(address => uint) public accountSize;
    mapping(address => uint) public traderBalance;
    mapping(address => uint) public reputationScore;
    mapping(address => uint) public traderLoss;
    mapping(address => uint) public totalProfitGenerated;
    mapping(address => uint) public maxLosses;
    mapping(address => string) public achievement;
    mapping(address => ChallengeStage) public traderStage;
    mapping(address => bool) public suspendedTrader;
    mapping(address => string) public traderLevel;
    mapping(address => string) public traderStatus;
    mapping(address => bool) public achievementRewardClaimed;
    mapping(address => uint) public dailyLoss;
    mapping(address => uint) public winStreak;
    mapping(address => uint) public dailyLossLimit;
    mapping(address => uint) public violations;
    mapping(address => TradeRecord[]) public history;
    mapping(address => bool) public bannedTrader;
    mapping(address => uint) public performanceScore;
    address[] public traders;
    modifier onlyOwner(){
        require(msg.sender == owner, "not the owner");
        _;
    }
    function approveTrders(address _trader) public onlyOwner(){
        approvedTrader[_trader] = true;
        traders.push(_trader);
    }
    modifier onlyTrader(){
        require(approvedTrader[msg.sender], "not approved");
        _;
    }
    function recordProfit(uint amount) public onlyTrader(){
        require(amount <= accountSize[msg.sender], "Profit exceeds account size");
        require(!suspendedTrader[msg.sender], "Trader suspended");

        uint traderShare = (amount *80)/ 100;
        uint firmShare = (amount *20)/ 100;
        firmBalance += firmShare;
        traderBalance[msg.sender]+= traderShare;
        totalProfitGenerated[msg.sender] += amount;
        updateLevel(msg.sender);
        scaleTrader(msg.sender);
        updatePerformance(msg.sender);
        updateReputation(msg.sender);
        winStreak[msg.sender] += 1;
        emit ProfitRecorded(
    msg.sender,
    amount
);
        if(winStreak[msg.sender] >= 5){
    traderBalance[msg.sender] += 500;
}
        history[msg.sender].push(
    TradeRecord("Profit", amount)
);
    }
    function upgradeAccount(
    address _trader
) public onlyOwner {

    require(
        targetReached[_trader],
        "Target not reached"
    );

    accountSize[_trader] *= 2;
}
    function withdrawProfit() public onlyTrader(){
        uint amount = traderBalance[msg.sender];
        require(!bannedTrader[msg.sender], "Trader banned");
        require(amount > 0, "no profits to withdraw");
        traderBalance[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }
    function setMaxLoss(address _trader, uint _amount) public onlyOwner(){
        maxLosses[_trader] = _amount;
    }
    function claimAchievementReward() public onlyTrader {

    require(
        !achievementRewardClaimed[msg.sender],
        "Reward already claimed"
    );

    require(
        keccak256(bytes(achievement[msg.sender]))
        != keccak256(bytes("Beginner")),
        "No achievement unlocked"
    );

    traderBalance[msg.sender] += 500;

    achievementRewardClaimed[msg.sender] = true;
}
function promoteTrader(address _trader) public onlyOwner(){
    if( traderStage[_trader] == ChallengeStage.Phase1){
        traderStage[_trader] == ChallengeStage.Phase2;
    }
    else if (traderStage[_trader]== ChallengeStage.Phase2){
        traderStage[_trader] == ChallengeStage.Funded;
    }
    }

        function updateReputation(address _trader) internal {

    reputationScore[_trader] =
        performanceScore[_trader]
        + (winStreak[_trader] * 100);
}
    function recordLoss(uint amount) public onlyTrader(){
        traderLoss[msg.sender] += amount;
       require(!suspendedTrader[msg.sender], "Trader suspended");
        require(traderLoss[msg.sender] < maxLosses[msg.sender], "max drawdown reached");
        if (traderLoss[msg.sender] > maxLosses[msg.sender]){
            approvedTrader[msg.sender] = false;
            updateStatus(msg.sender);
           dailyLoss[msg.sender] += amount;
           require(
    dailyLoss[msg.sender] <= dailyLossLimit[msg.sender],
    "Daily loss limit exceeded");
    if(traderLoss[msg.sender] > maxLosses[msg.sender]){
        violations[msg.sender] += 1;
        if(violations[msg.sender] >= 3){
    bannedTrader[msg.sender] = true;
    updateReputation(msg.sender);
    updatePerformance(msg.sender);
    winStreak[msg.sender] = 0;
    emit LossRecorded(
    msg.sender,
    amount
);
    history[msg.sender].push(
    TradeRecord("Loss", amount)
);
}
    }
        }

        }
    }
        function withdrawFirmProfit() public onlyOwner(){
          uint amount = firmBalance;
          require(amount > 0, "no profits");
          firmBalance = 0;
          payable(owner).transfer(amount);
        }
        function claimProfit() public onlyTrader(){
            uint amount = traderBalance[msg.sender];
            require(amount > 0, "no profit available");
            traderBalance[msg.sender] = 0;
            payable(msg.sender).transfer(amount);
        }
        function setAccountSize(address _trader, uint _amount) public onlyOwner(){
            accountSize[_trader] = _amount;
        }
        function suspendTrader(address _trader) public onlyOwner {
    suspendedTrader[_trader] = true;
}
function updateLevel(address _trader) internal{
    uint profit = totalProfitGenerated[_trader];
    if(profit >= 10000){
        traderLevel[_trader] = "Elite";
    }
    else if(profit >= 5000){
        traderLevel[_trader] = "Gold";
    }
    else if(profit >= 2000){
        traderLevel[_trader] = "Silver";
    }
    else{
        traderLevel[_trader] = "Bronze";
    }
    }
    function updateStatus(address _trader) internal {

    uint loss = traderLoss[_trader];
    uint maxLoss = maxLosses[_trader];

    if(loss >= maxLoss){
        traderStatus[_trader] = "Violated";
    }

    else if(loss >= (maxLoss * 80) / 100){
        traderStatus[_trader] = "Danger";
    }

    else if(loss >= (maxLoss * 50) / 100){
        traderStatus[_trader] = "Warning";
    }

    else{
        traderStatus[_trader] = "Safe";
    }
}
function scaleTrader(address _trader) internal{
    if(totalProfitGenerated[_trader] >= scalingTarget){
        accountSize[_trader] += 10000;
        scalingTarget += 10000;
    }
}
function setDailyLossLimit(address _trader, uint _amount) public onlyOwner {
    dailyLossLimit[_trader] = _amount;
}
function setProfitTarget(
    address _trader,
    uint _target
) public onlyOwner {

    profitTarget[_trader] = _target;
}
function updatePerformance(address _trader) internal{
    uint profit = totalProfitGenerated[_trader];
    uint loss = traderLoss[_trader];
    if(profit > loss) {
        performanceScore[_trader] = profit - loss;
    }
    else{
        performanceScore[_trader] = 0;
    }
}
function rewardTopTrader() public onlyOwner {

    address trader = getTopTrader();

    traderBalance[trader] += topTraderReward;
}

        function getTopTrader() public view returns(address){
            address bestTrader;
            uint highestProfit = 0;
            for(uint i = 0; i < traders.length; i++){
                address trader = traders[i];
                if(totalProfitGenerated[trader] > highestProfit){
                    highestProfit = totalProfitGenerated[trader];
                    bestTrader = trader;
                }
            }
            return bestTrader;
        }
        }