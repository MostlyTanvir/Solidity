// SPDX-License-Identifier: MIT
pragma solidity >0.8.1;

contract info{

    string name;
    uint age;

    constructor(){
        name = "Tanvir";
        age = 20;
    }

    function getName() view public returns (string memory){
        return name;
    }

    function getAge() view public returns (uint){
        return  age;
    }

    function setName(string memory n) public {
        name = n;
    }


}
