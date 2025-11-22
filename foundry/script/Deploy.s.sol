// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import { SecretPay } from "../src/SecretPay.sol";

contract DeployScript is Script{
    function run() external{
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(privateKey);
        SecretPay secretPay = new SecretPay();
        vm.stopBroadcast();
        console.log("Secret Pay Address:", address(secretPay));
    }
}

// sepolia