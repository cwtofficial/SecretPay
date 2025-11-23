// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import { SecretPay } from "../src/SecretPay.sol";


contract SecretPayTest is Test{
    SecretPay public secretPay;
    address public alice = makeAddr("alice"); // sender
    address public bob = makeAddr("bob"); // recipeint
    address public charles = makeAddr("charles"); // attacker

    string constant PASSWORD = "secret123";
    string constant WRONG_PASSWORD = "secret13";
    uint256 constant TRANSFER_AMOUNT = 1 ether;
    uint256 constant DURATION =  1 days;  


    event TransferCreated(
        uint256 indexed transferId,
        address indexed sender,
        address indexed recipient,
        uint256 amount,
        uint256 deadline 
    );

    event TransferClaimed(
        uint256 indexed transferId,
        address indexed recipient,
        uint256 amount
    );

    event TransferRefunded(
        uint256 indexed transferId,
        address indexed sender,
        uint256 amount
    );

    function setUp() public{
        secretPay = new SecretPay(); 
        vm.deal(alice, 10 ether);
        vm.deal(bob, 10 ether);
        vm.deal(charles, 10 ether);
    }

    function testCreateTransferFunction() public{
        uint256 initialCount = secretPay.transferCount();
        uint256 expectedDeadline = block.timestamp + DURATION;

        vm.prank(alice);

        secretPay.createTransfer{value: TRANSFER_AMOUNT }(bob, PASSWORD, DURATION);
        assertEq(secretPay.transferCount(), 1, "Transfer should be incremented to 1");
        (address sender, address recipient, uint256 amount, bytes32 passwordHash, uint256 deadline, bool claimed )= secretPay.transfers(0);
        assertEq(sender, alice, "Sender should be alice");
        assertEq(recipient, bob, "Recipient should be bob");
        assertEq(amount, TRANSFER_AMOUNT, "Amount should match");

        bytes32 expectedHash = keccak256(abi.encodePacked(PASSWORD));
        assertEq(passwordHash, expectedHash, "Password hash should match");
    }

    function testCreateTransferEmitsEvent() public{
        uint256 transferId = secretPay.transferCount();
        uint256 expectedDeadline = block.timestamp + DURATION;

        vm.expectEmit(true, true, true, true); // this takes 4 and not 5 (because the first 3 are the index event and the last (4th true) represents all  Non-indexed parameters)
        emit TransferCreated(transferId, alice, bob, TRANSFER_AMOUNT, expectedDeadline);
    
        vm.prank(alice);
        secretPay.createTransfer{value: TRANSFER_AMOUNT }(bob, PASSWORD, DURATION);
    }

    function testCreateTransferFailsWithZeroAmount() public{
        vm.prank(alice);
        vm.expectRevert("You must send ETH");
        secretPay.createTransfer{value: 0}(bob, PASSWORD, DURATION);
    }

      function testCreateTransferWithZeroAddress() public {
         vm.prank(alice);
         vm.expectRevert("Invalid Recipient Address");
         secretPay.createTransfer{value: TRANSFER_AMOUNT}(address(0), PASSWORD, DURATION);
      }

    // AAA -> Patttern (Arrange, Act, Assert)

}