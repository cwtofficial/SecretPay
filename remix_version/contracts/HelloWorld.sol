// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


contract HelloWorld{
    string public message; // "a", "b"
    uint256 public age = 25; //- 1, 2, 3
    bool  public isActive = true; //- true , false
    address public owner = 0x4838B106FCe9647Bdf1E7877BF73cE8B0BAD5f97; //- 0x 

    constructor(){
        message = "Hello World";
    }

    function setMessage(string memory newMessage) public{
            message = newMessage;
    }

    function getMessage() public view returns(string memory) {
        return message;
    }

}