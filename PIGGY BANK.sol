// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract piggybank{

    address public owner = msg.sender;

    event Deposit(uint amount);
    event Withdraw(uint amount);

    // using receive because we dont want any message to reveive money
    // msg.data is empty
    receive() external payable {
        emit Deposit(msg.value);
     }

    function withdraw() external {
        require(msg.sender == owner, "Not the owner");
        // selfdestruct(payable(msg.sender)); // depricated
        (bool success,) = payable(owner).call{value: address(this).balance}("");
        if (!success) {
            revert("call{value} failed");
        }
        emit Withdraw(address(this).balance);
    }

}
