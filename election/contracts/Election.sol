// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Election {
    // Model for a candidate
    struct Candidate {
        uint256 id;
        string name;
        uint256 voteCount;
    }

    // Read/Write mapping for candidates
    mapping(uint256 => Candidate) public candidates;

    // store number of candidates
    uint256 public candidatesCount;

    function addCandidate(string memory _name) private {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    constructor() public {
        addCandidate("Kashish");
        addCandidate("Mukul");
    }

    //mapping for accounts that have voted
    mapping(address => bool) public voters;

    function vote(uint256 _candidateID) public {
        // require that a voter hasn't voted before
        require(!voters[msg.sender]); // doubt 

        //require a valid candidate
        require(_candidateID > 0 && _candidateID <= candidatesCount);

        // mark that the voter has voted
        voters[msg.sender] = true;

        //update candidate vote count
        candidates[_candidateID].voteCount++;

        //trigger voted event
        emit votedEvent(_candidateID);
    }

    event votedEvent(uint256 indexed _candidateID);
}