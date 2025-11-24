// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MyName {
    string public name;
    uint256 public counter;

    constructor() {
        name = "Anonymous";
        counter = 0;
    }

    function updateName(string memory newName) public {
        name = newName;
        // counter = counter + 1;
        counter++;
    }
}
