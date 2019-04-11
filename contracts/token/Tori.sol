pragma solidity ^0.4.24;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "contracts/token/IApproveAndCall.sol";
import "contracts/token/IReceiveApproval.sol";
import "contracts/utils/Ownable.sol";

/**
 * @title TORI Token - Scowork
 * @author cuma - <morris@storicha.in>
 */
contract Tori is ERC20, IApproveAndCall, Ownable {
    using SafeMath for uint256;
    string public constant name = "Tori";
    string public constant symbol = "TORI";
    uint256 public constant decimals = 18;

    event Mint(address indexed _to, uint256 _amount);
    event Burn(address indexed _from, uint256 _amount);

    function transfer(address _to, uint256 _value) public returns (bool) {
        return super.transfer(_to, _value);
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        return super.transferFrom(_from, _to, _value);
    }

    function mint(uint256 _amount) onlyOwner external {
        super._mint(msg.sender, _amount);

        emit Mint(msg.sender, _amount);
    }

    function burn(uint256 _amount) onlyOwner external {
        super._burn(msg.sender, _amount);

        emit Burn(msg.sender, _amount);
    }

    function isContract(address _addr) private view returns (bool) {
        uint256 length;
        assembly {
            //retrieve the size of the code on target address, this needs assembly
            length := extcodesize(_addr)
        }
        return (length > 0);
    }

    function() public payable {
        revert();
    }

    /**
     * @dev eip-1438.md
     */
    function approveAndCall(address _to, uint _value, bytes _data) public returns (bool success) {
        require(_to != address(0) && _to != address(this));
        require(balanceOf(msg.sender) >= _value);

        if(approve(_to, _value) && isContract(_to)) {
            allowed[msg.sender][_to] = _value;
            IReceiveApproval(_to).receiveApproval(msg.sender, _value, this, _data);
            emit Approval(msg.sender, _to, _value);
            return true;
        }
    }
}
