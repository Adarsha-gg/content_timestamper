// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

struct Content{
        address owner;
        uint256 timestamp;
    }

contract Timestamper {
    address payable contract_owner;
    
    constructor(){
        contract_owner = payable(msg.sender);
    }

    mapping(uint256 => Content) public contents; // returns the contents of the owner[Stores the hash]
    mapping(uint256 => bool) public already_hashed;

    function hash_content(string memory _content) public pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(_content))); // hashes the thing
    }

    function stamp(string memory _content) public {
        uint256 hashed = hash_content(_content);
        if (already_hashed[hashed] == true){ // checks if the content has already been stamped
            revert("Content already stamped");
        }
        else{
            Content memory a = Content(msg.sender, block.timestamp);
            contents[hashed] = a;
        }        
    }

    function verify_owner(uint256 _hash) public view returns (Content memory) {
        if (already_hashed[_hash] == true){
                return contents[_hash];
        }
        else{
            revert("Content not stamped");
        }
    }

    function pay_owner(uint _hash) public payable {
        if (already_hashed[_hash] == true){
            address payable receiver = payable(0x13E5de1dD7F313feD582288acd4a38C7d716150c); // my address
            (bool sent,) = receiver.call{value: msg.value}("");
            require(sent, "Failed to send Ether");
        }
        else{
            revert("Content not stamped");
        }
    }

    function pay_contract() external payable{}
    function withdraw_contract() public {
        if (msg.sender == contract_owner){
            address payable receiver = payable(contract_owner);
            (bool sent,) = receiver.call{value: address(this).balance}("");
            require(sent, "Failed to send Ether");
        }
        else{
            revert("You are not the owner");
        }
    }
}