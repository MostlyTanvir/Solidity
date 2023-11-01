// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC721 {
    function transferFrom(
        address _from,
        address _to,
        uint nftId
    )external ;
}


contract EnglishAuction{

    event Start();
    event Bid(address indexed sender, uint value);
    event Withdraw(address indexed bidder, uint value);
    event End(address highestBidder, uint value);

    IERC721 public immutable nft;
    address payable  public immutable seller;
    uint public immutable nftId;
    uint32 public endAt;
    bool public started;
    bool public ended;

    address public highestBidder;
    uint public highestBid;
    mapping(address=>uint) public bids;

    constructor(
        address _nft,
        uint _nftId,
        uint startingBid

    ){
        nft = IERC721(_nft);
        seller = payable (msg.sender);
        nftId = _nftId;
        highestBid = startingBid;

    }

    function start() external {
        require(msg.sender == seller, "Not the seller");
        require(!started, "Already Started");

        started = true;

        endAt = uint32( block.timestamp + 300 );
        nft.transferFrom(msg.sender, address(this), nftId);

        emit Start();
    }

    function bid() payable external {
        require(started,"Not started yet");
        require(block.timestamp<=endAt, "Times up");
        require(msg.value > highestBid, "Not Highest Bid");

        if(highestBidder != address(0)){
            bids[highestBidder] += highestBid;
        }

        highestBid = msg.value;
        highestBidder = msg.sender;

        emit Bid(msg.sender, msg.value);
   }

   function withdraw() external {
        uint bal = bids[msg.sender];
        bids[msg.sender] = 0;
        payable(msg.sender).transfer(bal);
        emit Withdraw(msg.sender, bal);
   }
   function end() external {
        require(started, "not started");
        require(!ended, "ended");
        require(block.timestamp >= endAt, "not ended");
        ended = true;

        if(address(0)!=highestBidder){
            nft.transferFrom(address(this), highestBidder, nftId);
            seller.transfer(highestBid);
        } else{
            nft.transferFrom(address(this), seller, nftId);
        }

        emit End(highestBidder, highestBid);
   }

}
