pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

contract Board {
    struct Contribution {
        address payable contributer;
        uint value;
    }
    
    string[] sentences;
    Contribution[] Contributions;
    
    mapping(string => Contribution) sentence_to_contribution;
    
    address owner;
    
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    constructor() public {
        owner = msg.sender;
    }
    
    function contribute(string memory _sentence) public {
        sentences.push(_sentence);
        Contribution memory new_contribution = Contribution(msg.sender, 0);
        Contributions.push(new_contribution);
        sentence_to_contribution[_sentence] = new_contribution;
    }
    
    function getSentence() public view  returns(string[] memory) {
        return sentences;
    }
    
    function donate(string memory _sentence) public payable {
        sentence_to_contribution[_sentence].contributer.transfer(msg.value);
        sentence_to_contribution[_sentence].value += msg.value;
    }
    
    function getValue(string memory _sentence) public view returns(uint) {
        return sentence_to_contribution[_sentence].value;
    }
    
    function getDetail(string memory _sentence) public view returns(Contribution memory) {
        return sentence_to_contribution[_sentence];
    }
}