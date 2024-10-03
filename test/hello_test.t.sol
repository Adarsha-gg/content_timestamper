// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "../lib/forge-std/src/Test.sol";
import {Timestamper} from "../src/timestamper.sol";
import {Content} from "../src/timestamper.sol";

contract Timestamp_test is Test{
    Timestamper timestamper;
    
    address USER = makeAddr("hyalo"); 

    function test_stamp() public {
        timestamper = new Timestamper();

        vm.startBroadcast();
        timestamper.stamp("Hello.");
        timestamper.stamp("yay") ;
        vm.stopBroadcast();
        
        (address owner,) = timestamper.contents(uint256(keccak256(abi.encodePacked("Practice this technique right now. Literally take some time to practice it at this very moment. Pick a complex concept you that you want to refine. Pretend youre talking to someone and try to teach it to them in your own words, out loud. Use analogies, explain it from first principles, etc, whatever helps you teach it better in a more compressed form. Then repeat this over and over, compressing the concept more and more down to what matters after each rep."))));
        assert(owner == msg.sender);
    }

}
