// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SecretPay{
    // STRUCTS => 
    // struct Product{
    //     string name;
    //     uint256 price;
    //     uint256 quantity;
    //     address seller;
    //     bool available;
    // }

    // Product public item1;
    // Product public item2;

    // function createProduct(string memory _name, uint256 _price, uint256 _quantity) public{
    //         item1 = Product({
    //             name: _name,
    //             price: _price,
    //             quantity: _quantity,
    //             seller: msg.sender,
    //             available: true
    //         });
    // }

       // 0 : bob -> alice -> 100ETH

    //To get the transfer sender at id 0
    // address transferSender = transfers[0].sender;

    // To get the transfer amount at id 1
    // uint256 amountSent = transfers[1].amount;

    // alice -> bob
    // john -> jason

    // Transfer public transfer1;
    // Transfer public transfer2; ... 100

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

    struct Transfer{
        address sender; // who sent the ETH
        address recipient; // who can claim it
        uint256 amount; // amount in WEI
        bytes32 passwordHash; // hashed password
        uint256 deadline; // when sender can get refund
        bool claimed; // has it been claimed
    }

    uint256 public transferCount;
    mapping(uint256 => Transfer) public transfers;

 
    // function recieveETH() public payable  {
    //    // msg.value => the amout of eth sent (in wei)
    //    uint256 amountSent = msg.value;

    //    require(amountSent > 0, "You must send ETH"); // to enforce operations
    //    block.timestamp; // current time (in seconds since 1970)

    // }

    constructor(){
        transferCount = 0;
    }

    function createTransfer(address _recipient, string memory _password, uint256 _duration) public payable{
         // VALIDATION
          require(msg.value > 0, "You must send ETH"); 
          require(_recipient != address(0), "Invalid Recipient Address");
          require(bytes(_password).length > 0, "Password cannot be empty");
          require(_duration > 0, "Duration must be positive");
         // HASH THE PASSWORD
          bytes32 passwordHash = keccak256(abi.encodePacked(_password)); //secret123  => 0x2344d
        // CREATE A DEADLINE
          uint256 deadline = block.timestamp + _duration; //=> 1763569676 + 86400 (24 hrs)
        // STORED THE TRANSFER IN A MAPPING
        transfers[transferCount] = Transfer({
            sender: msg.sender,
            recipient:_recipient,
            amount: msg.value,
            passwordHash: passwordHash,
            deadline: deadline,
            claimed: false
        });
        // EMITTED AN EVENT
        emit TransferCreated(
            transferCount,
            msg.sender,
            _recipient,
            msg.value,
            deadline
        );
        // transferCount = transferCount + 1 
        transferCount++;
    }

  function claimTransfer(uint256 _transferId, string memory _password) public{
    // GET THE TRANSFER
    Transfer storage transfer = transfers[_transferId];
    // if the transfer exist
    require(transfer.amount > 0, "Transfer does not exist.");
    //if it has not been claimed
    require(!transfer.claimed, "Already Claimed");
    // if the caller (msg.sender) is the intended recipient
    require(msg.sender == transfer.recipient);
  // if the duration is stil valid
    require(block.timestamp < transfer.deadline, "Deadline passed");
  // if the password matches (is correct)
    bytes32 inputHash = keccak256(abi.encodePacked(_password));
    require(inputHash == transfer.passwordHash, "Incorrect password");
    // update state before transfer

     transfer.claimed = true;
    uint256 amount = transfer.amount;
    payable(transfer.recipient).transfer(amount); // => 2100 gas // how we transfer eth
   

    emit TransferClaimed(_transferId, transfer.recipient, amount);

  }

    // Our refundTransfer function has a critical issue (the one we used in the tutorial, i have attached the corrected one below (the last function) in comments).
    // Refund function should not be payable, since sender shouldn’t send ETH to claim a refund. 
    // We did not refund the transfer amount stored in the contract, but instead we  incorrectly used msg.value, which is the ETH the sender sends during the refund call.
    // But msg.value will always be 0, because the sender is not supposed to send ETH when requesting a refund.
   function refundTransfer(uint256 _transferId) public payable {
        Transfer storage transfer = transfers[_transferId];

        require(transfer.amount > 0, "Transfer does not exist.");
        require(!transfer.claimed, "Already Claimed");
        require(msg.sender == transfer.sender, "Not the sender");
        require(block.timestamp >=transfer.deadline, "Deadline has not passed yet."); 

        transfer.claimed = true;
        uint256 amount = msg.value; 
        
        payable(transfer.sender).transfer(amount);

        emit TransferRefunded(_transferId, transfer.sender, amount);

  }
  
    // Correct Refund Transfer Function (Have you seen the differences between the two refund transfer function.. If No.. look more closely (once you have seen it - replace it with the one at the top))
    // function refundTransfer(uint256 _transferId) public {
    //     Transfer storage transfer = transfers[_transferId];

    //     require(transfer.amount > 0, "Transfer does not exist.");
    //     require(!transfer.claimed, "Already Claimed");
    //     require(msg.sender == transfer.sender, "Not the sender");
    //     require(block.timestamp >= transfer.deadline, "Deadline has not passed yet."); 

    //     transfer.claimed = true;   
    //     uint256 amount = transfer.amount;
    //     transfer.amount = 0; 

    //     payable(transfer.sender).transfer(amount);

    //     emit TransferRefunded(_transferId, transfer.sender, amount);
    // }

}