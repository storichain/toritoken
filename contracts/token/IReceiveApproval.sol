pragma solidity ^0.4.24;

contract IReceiveApproval {
    function receiveApproval(address _from, uint256 _value, address _token, bytes _data) public;
}