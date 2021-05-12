pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract WETH is ERC20 {
    
    address owner;
    
    constructor()  ERC20("Wrapped Ethereum Token","WETH")  {
        owner = msg.sender;
    }
    
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    function mint(address _reciever, uint _amount) external onlyOwner{
         _mint(_reciever,_amount);
    }
    
    function decimals() public pure override returns (uint8) {
        return 2;
    }
  
    
    function burn(uint _amount) external onlyOwner {
        _burn(msg.sender,_amount);
    }
}