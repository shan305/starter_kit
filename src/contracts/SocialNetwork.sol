pragma solidity >=0.5.0;

contract SocialNetwork {
string public  name;
uint public postCount=0;
mapping(uint =>Post) public posts;

struct Post{
    uint id;
    string content;
    uint tipAmount;
    address payable author;
}

event PostCreated(
    uint id,
    string content,
    uint tipAmount,
    address payable author
);
event PostTipped(
    uint id,
    string content,
    uint tipAmount,
    address payable author
);

constructor() public {
    name= "SocialNetwork";
}

 function createPost(string memory _content) public {
 //Require valid content
 require(bytes(_content).length> 0);
 
 //increament the post
   postCount++;
  //create the post
   posts[postCount] = Post(postCount,_content,0,msg.sender);
// trigger the event
emit PostCreated(postCount, _content, 0, msg.sender);
}

function tipPost(uint _id) public payable{
//make sure the id is valid
require(_id>0 && _id <=postCount);

//fetch the post
Post memory _post= posts[_id];
//fetch the author
address payable _author = _post.author;
//pay the author by sending ether
address(_author).transfer(msg.value);
//increment the tip amount
_post.tipAmount=_post.tipAmount + msg.value;
// update the post
posts[_id] =_post;
// Trigger the event 
emit PostTipped(postCount, _post.content, _post.tipAmount, _author);
}
}

//truffle compile
//truffle migrate
//truffle migrate -- reset
//truffle console
// class.deployed()
//class.deployed().then((c)=> {contact=c})
// contract
// contract = await Class.deployed()
// contract
//contract.address
