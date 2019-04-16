pragma solidity ^0.5.2;

contract IReceiveApproval {
    function receiveApproval(address _from, uint256 _value, address _token, bytes memory _data) public;
}