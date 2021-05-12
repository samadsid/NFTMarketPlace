pragma solidity ^0.8.0;
import './NFT.sol';
import './WETH.sol';

contract MarketPlace {
    
    NFT public nftToken;
    WETH public weth;
    
    constructor(address _nftToken, address _erc20Token) {
        nftToken = NFT(_nftToken);
        weth = WETH(_erc20Token);
    }
    
    function createNFT(string memory _tokenURI, uint _price) external {
        nftToken.createNFT(msg.sender, _tokenURI, _price);
    }
    
    function buyNFT(uint _tokenID) external {
        //checking if the user has required funds
        require(weth.balanceOf(msg.sender) >= nftToken.nftAskingPrice(_tokenID),"You  have insufficient balance ");
        //Getting NFT Owner
        address nftOwner = nftToken.ownerOf(_tokenID);
        // Transfering ERC20 Tokens (We need to approve it first)
        weth.transferFrom(msg.sender,nftOwner,nftToken.nftAskingPrice(_tokenID));
        // Transfering NFT token (We need to approve it first)
        nftToken.transferFrom(nftOwner,msg.sender,_tokenID);
    }
    
    
}
