// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MultiSender {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // This function receives Ether and sends equal portions to all recipients
    function multiSend(address[] calldata recipients) external payable {
        uint count = recipients.length;
        require(count > 0, "No recipients provided");
        require(msg.value > 0, "No Ether sent");
        require(msg.value % count == 0, "Ether must divide evenly");

        uint share = msg.value / count;

        for (uint i = 0; i < count; i++) {
            (bool success, ) = recipients[i].call{value: share}("");
            require(success, "Transfer failed");
        }
    }

    // Allow contract to receive Ether
    receive() external payable {}

    // Withdraw any stuck funds (only by owner)
    function withdraw() external {
        require(msg.sender == owner, "Not the owner");
        payable(owner).transfer(address(this).balance);
    }
}
