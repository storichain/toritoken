pragma solidity ^0.5.2;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "contracts/utils/Ownable.sol";

/**
 * @title TORI Token - Scowork
 * @author cuma - <morris@storicha.in>
 */
contract Tori is ERC20, Ownable {
    using SafeMath for uint256;
    string public constant name = "Tori";
    string public constant symbol = "TORI";
    uint256 public constant decimals = 18;

    constructor(uint256 initSupply) public {
        _mint(msg.sender, initSupply);
    }

    function transfer(address _to, uint256 _value) public returns (bool) {
        return super.transfer(_to, _value);
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        return super.transferFrom(_from, _to, _value);
    }

    function isContract(address _addr) private view returns (bool) {
        uint256 length;
        assembly {
            //retrieve the size of the code on target address, this needs assembly
            length := extcodesize(_addr)
        }
        return (length > 0);
    }

    function() external payable {
        revert();
    }
}
