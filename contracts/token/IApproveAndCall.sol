pragma solidity ^0.5.2;

contract IApproveAndCall {
    function approveAndCall(address _to, uint256 _value, bytes memory _data) public returns (bool);
    
    event ApproveAndCall(address indexed _from, address indexed _to, uint256 _value, bytes _data);
}
