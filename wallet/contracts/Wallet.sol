//SPDX-License-Identifier: MIT
pragma solidity >=0.4.16 <0.9.0;

import "@openzeppelin/contracts/utils/Strings.sol";

contract wallet {
    address public owner;
    Transaction[] history;
    mapping(address => uint256) balance_at;

    struct Transaction {
        address sender;
        address receiver;
        uint256 amount;
        uint256 timestamp;
        string message;
    }

    constructor() public payable {
        owner = msg.sender;
        balance_at[owner] = msg.value;
    }

    // modifier onlyOwner(){
    //     require(msg.sender == owner, "error: only the owner is allowed to call this function");
    //     _;
    // }

    function getHistory(uint256 i) public view returns (string memory) {
        return history[i].message;
    }

    function sendMoney(address receiver, uint256 amt) public payable {
        require(
            amt <= balance_at[msg.sender],
            "error: insufficient funds in account"
        );

        balance_at[msg.sender] -= amt;
        balance_at[receiver] += amt;

        //adding to logs
        uint256 time = block.timestamp;
        string memory sender_addr = Strings.toHexString(
            uint256(uint160(msg.sender)),
            20
        );
        string memory receiver_addr = Strings.toHexString(
            uint256(uint160(receiver)),
            20
        );
        string memory message = string(
            abi.encodePacked(
                sender_addr,
                " sent an amount of ",
                Strings.toString(amt),
                " to ",
                receiver_addr,
                " at ",
                Strings.toString(time * 1000),
                " seconds"
            )
        );
        Transaction memory tr = Transaction(
            msg.sender,
            receiver,
            amt,
            time,
            message
        );
        history.push(tr);
    }

    function checkBalance() public view returns (uint256) {
        return balance_at[msg.sender];
    }
}