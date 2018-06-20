pragma solidity ^0.4.2;

import "./DappToken.sol";
/**
 * The DappTokenSale contract does this and that...
 */
contract DappTokenSale {
    address admin;
    DappToken public tokenContract;
    uint256 public tokenPrice;
    uint256 public tokenSold;

    event Sell(address _buyer, uint256 _amount);
    

    constructor(DappToken _tokenContract, uint256 _tokenPrice) public {
        admin = msg.sender;
        tokenContract = _tokenContract;
        tokenPrice = _tokenPrice;
    }    

    // multiply
    function  multiply(uint x, uint y) internal pure returns(uint z) {
        require(y == 0 || (z = x * y) / y == x );
    }
    

    // Buy Tokens
    function buyTokens(uint256 _numberOfTokens) public payable {
        require (msg.value == multiply(_numberOfTokens, tokenPrice));
        require(tokenContract.balanceOf(this) >= _numberOfTokens);        
        require(tokenContract.transfer(msg.sender, _numberOfTokens));        
        tokenSold += _numberOfTokens;

        emit Sell(msg.sender, _numberOfTokens);
    }

    // Ending of DappTokenSale
    function endSale() public {
        // Require admin
        require (msg.sender == admin);
        require(tokenContract.transfer(admin, tokenContract.balanceOf(this)));
        selfdestruct(admin);
    }
}
