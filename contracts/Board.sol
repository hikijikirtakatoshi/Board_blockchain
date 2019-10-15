pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

contract Board {
    struct Contribution {
        string sentence;
        address payable contributer;
        uint value;
        uint id;
    }
    
    Contribution[] Contributions;
    
    address owner;
    uint index;
    string[] sentences;
    
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    constructor() public {
        owner = msg.sender;
    }
    
    function contribute(string memory _sentence) public {
        Contribution memory new_contribution = Contribution(_sentence,msg.sender, 0, index);
        Contributions.push(new_contribution);
        index++;
    }
    
    function getSentence() public returns(string[] memory) {
        for(uint i = 0; i< Contributions.length; i++) {
            sentences.push(Contributions[i].sentence);
        }
        return sentences;
    }
    
    function donate(uint _index) public payable {
        Contributions[_index].contributer.transfer(msg.value);
        Contributions[_index].value += msg.value;
    }
    
    function getValue(uint _index) public view returns(uint) {
        return Contributions[_index].value;
    }
    
    function getAddress(uint _index) public view returns(address) {
        return Contributions[_index].contributer;
    }
    
    function getContributes() public view returns(Contribution[] memory) {
        return Contributions;
    }
}