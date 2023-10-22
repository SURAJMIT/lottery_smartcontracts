// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract lotterycontract{
    address public manager;
    address payable[] public candidates;
    address payable public winner;

    constructor(){
        manager= msg.sender;
    }

    receive() external payable { 
        require(msg.value==0.000001 ether);
        candidates.push(payable (msg.sender));
    }
    function getbalance() public view returns(uint ){
        require(msg.sender== manager);
        return address(this).balance;
    }
    function getRandom() public view returns(uint){
       return uint( keccak256( abi.encodePacked(block.difficulty,block.timestamp,candidates.length)));

    }
function pickwinner() public {
    require(msg.sender== manager);
    require(candidates.length>=2);
    uint r = getRandom();
    uint index = r % candidates.length;
    winner = candidates[index];
    winner.transfer(getbalance());
    candidates=new address payable[](0);


    }}