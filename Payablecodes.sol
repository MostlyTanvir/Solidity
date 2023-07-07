// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract test007{

    address payable receiver = payable(0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db); 

    function __block() public view returns(uint BlockNumber, uint TimeStamp, address SenderAdd){
        return (block.number, block.timestamp, msg.sender);
    }
    function getbal() public view returns (uint ){
        return address(this).balance;
    }
    function payEth() public  payable {
        
    }
    function send1eth() public payable {
        receiver.transfer(1 ether);
    }
}
