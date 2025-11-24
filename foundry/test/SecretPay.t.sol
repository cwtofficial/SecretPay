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

     // i created an helper function here (reduces code duplication noticed how it starts with a _)
        function _createTransfer(
        address sender,
        address recipient,
        string memory password,
        uint256 amount,
        uint256 duration
    ) internal returns (uint256) {
        uint256 transferId = secretPay.transferCount();
        
        vm.prank(sender);
        secretPay.createTransfer{value: amount}(
            recipient,
            password,
            duration
        );
        
        return transferId; // it returns the transferId
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

        vm.expectEmit(true, true, true, true); // this takes 4 and not 5 (because the first 3 are the index event and the last (4th true) represents all  Non-indexed parameters (amount and deadline))
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

    function testCreateMultipleTransfers() public {
        // Arrange & Act
        uint256 transferId1 = _createTransfer(alice, bob, PASSWORD, 1 ether, DURATION);
        uint256 transferId2 = _createTransfer(alice, charles, "password2", 2 ether, DURATION);
        uint256 transferId3 = _createTransfer(bob, alice, "password3", 0.5 ether, DURATION);
        
        // Assert
        assertEq(transferId1, 0, "First transfer should have ID 0");
        assertEq(transferId2, 1, "Second transfer should have ID 1");
        assertEq(transferId3, 2, "Third transfer should have ID 2");
        assertEq(secretPay.transferCount(), 3, "Should have 3 transfers");
     }
    

    function testClaimTransfer() public{
        // ARRANGE 
        // (this is setup, not what we're testing)
        uint256 transferId = _createTransfer(alice, bob, PASSWORD, TRANSFER_AMOUNT, DURATION);
        uint256 bobBalanceBefore = bob.balance;

        // Act        
        vm.prank(bob);
        secretPay.claimTransfer(transferId, PASSWORD);
        uint256 bobBalanceAfter = bob.balance;

        //Assert
        // Check Bob received the correct amount
        assertEq(bobBalanceAfter, bobBalanceBefore + TRANSFER_AMOUNT, "Bob should receive the transfer amount");
        (, , , , , bool claimed) = secretPay.transfers(transferId);
        // Check transfer is marked as claimed
        assertTrue(claimed, "Transfer should be marked as claimed");
    }

    function testClaimTransferEmitsEvent() public {
        // Arrange
        uint256 transferId = _createTransfer(alice, bob, PASSWORD, TRANSFER_AMOUNT, DURATION);
        
        // Expect the event
        vm.expectEmit(true, true, false, true);
        emit TransferClaimed(transferId, bob, TRANSFER_AMOUNT);
        
        // Act
        vm.prank(bob);
        secretPay.claimTransfer(transferId, PASSWORD);
    }

    function testClaimTransferFailsWithWrongPassword() public {
        // Arrange
        uint256 transferId = _createTransfer(alice, bob, PASSWORD, TRANSFER_AMOUNT, DURATION);
        
        // Act & Assert
        vm.prank(bob);
        vm.expectRevert("Incorrect password");
        secretPay.claimTransfer(transferId, WRONG_PASSWORD);
    }

    // This test would fail because we didn't handle the revertion completely (permit my english)😂 
    // if you check our contract (the claimTransfer function) we handled it but didn't add the error message
    // so make sure you effect it on your end.
    function testClaimTransferFailsIfNotRecipient() public {
        // Arrange
        uint256 transferId = _createTransfer(alice, bob, PASSWORD, TRANSFER_AMOUNT, DURATION);
        
        // Act & Assert
        vm.prank(charles);  // Charlie tries to claim Bob's transfer
        vm.expectRevert("Not the recipient"); 
        secretPay.claimTransfer(transferId, PASSWORD);
    }
    
    function testClaimTransferFailsAfterDeadline() public {
        // Arrange
        uint256 transferId = _createTransfer(alice, bob, PASSWORD, TRANSFER_AMOUNT, DURATION);
        
        // Time travel past deadline
        vm.warp(block.timestamp + DURATION + 1);
        
        // Act & Assert
        vm.prank(bob);
        vm.expectRevert("Deadline passed");
        secretPay.claimTransfer(transferId, PASSWORD);
    }

    function testClaimTransferFailsIfNotExists() public {
        // Act & Assert
        vm.prank(bob);
        vm.expectRevert("Transfer does not exist.");
        secretPay.claimTransfer(999, PASSWORD);
    }
    
    function testClaimTransferFailsIfAlreadyClaimed() public {
        // Arrange
        uint256 transferId = _createTransfer(alice, bob, PASSWORD, TRANSFER_AMOUNT, DURATION);
        
        // Claim once
        vm.prank(bob);
        secretPay.claimTransfer(transferId, PASSWORD);
        
        // Try to claim again
        vm.prank(bob);
        vm.expectRevert("Already Claimed"); // it must match (just in case -> Already Claimed is not the same as Already claimed (C !== c). )
        secretPay.claimTransfer(transferId, PASSWORD);
    }

    function testClaimTransferAtExactDeadline() public {
        // Arrange
        uint256 transferId = _createTransfer(alice, bob, PASSWORD, TRANSFER_AMOUNT, DURATION);
        
        // Time travel to exact deadline (should still work)
        vm.warp(block.timestamp + DURATION);
        
        // Act & Assert - Should work (< deadline, not >=)
        vm.prank(bob);
        vm.expectRevert("Deadline passed");  // Actually it should fail because block.timestamp < deadline fails at exact time
        secretPay.claimTransfer(transferId, PASSWORD);
    }
    
    // Now i want to leave the refund transfer tests to you.... WHY?
    // When Recording the tutorial.. i made a mistake...
    // The mistake was firstly making the refundTransfer function payable
    // It should not be payable, since sender shouldn’t send ETH to claim a refund.
    // Also, we did not refund the transfer amount stored in the contract.
    // But instead we  incorrectly used msg.value, which is the ETH the sender sends during the refund call. 
    // But msg.value will always be 0, because the sender is not supposed to send ETH when requesting a refund.

    // So writing the refund tests will be a waste of time.
    // I want you to fix the refund function in our SecretPay contract, then come back and write the test..

    // Quick sample of how the testRefundTransfet would look like (it would fail if you don't fix the issues in SecretPay.sol)
    // function testRefundTransfer() public {
    //     // Arrange
    //     uint256 transferId = _createTransfer(alice, bob, PASSWORD, TRANSFER_AMOUNT, DURATION);
    //     uint256 aliceBalanceBefore = alice.balance;
        
    //     // Time travel past deadline
    //     vm.warp(block.timestamp + DURATION + 1);
        
    //     // Act
    //     vm.prank(alice);
    //     secretPay.refundTransfer(transferId);
        
    //     // Assert
    //     uint256 aliceBalanceAfter = alice.balance;
    //     assertEq(aliceBalanceAfter, aliceBalanceBefore + TRANSFER_AMOUNT, "Alice should receive refund");
        
    //     // Check transfer is marked as claimed (refunded)
    //     (, , , , , bool claimed) = secretPay.transfers(transferId);
    //     assertTrue(claimed, "Transfer should be marked as claimed");
    // }
    

    //CONGRATULATIONS AND WELCOME TO THE WORLD OF BLOCKCHAIN DEVELOPMENT. LOTS OF LOVE FROM HERE💕 

    // AAA -> Patttern (Arrange, Act, Assert)

    // If you run foundry coverage and you have errors or a test not passing you wont see the detailed table.

}