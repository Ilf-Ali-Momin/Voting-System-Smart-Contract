// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract Create {
    using Counters for Counters.Counter;

    Counters.Counter private _voterId;
    Counters.Counter private _candidateId;

    address public votingOrganizer;

    struct Candidate {
        uint256 candidateId;
        string age;
        string name;
        string image;
        uint256 voteCount;
        address _address;
        string ipfs;
    }

    struct Voter {
        uint256 voterId;
        string name;
        string image;
        address voterAddress;
        uint256 allowed;
        bool hasVoted;
        uint256 votedFor;
        string ipfs;
    }

    mapping(address => Candidate) public candidates;
    mapping(address => Voter) public voters;

    address[] public candidateAddress;
    address[] public votersAddress;

    event CandidateCreate(
        uint256 candidateId,
        string age,
        string name,
        string image,
        uint256 voteCount,
        address indexed _address,
        string ipfs
    );

    event VoterCreate(
        uint256 voterId,
        string name,
        string image,
        address indexed voterAddress,
        uint256 allowed,
        bool hasVoted,
        uint256 votedFor,
        string ipfs
    );

    constructor() {
        votingOrganizer = msg.sender;
    }

    function setCandidates(
        address _address,
        string memory _age,
        string memory _name,
        string memory _image,
        string memory _ipfs
    ) public {
        require(
            votingOrganizer == msg.sender,
            "Only organizer can authorize candidates"
        );

      
        _candidateId.increment();

        uint256 idNumber = _candidateId.current();

    
        candidates[_address] = Candidate({
            candidateId: idNumber,
            age: _age,
            name: _name,
            image: _image,
            voteCount: 0,
            _address: _address,
            ipfs: _ipfs
        });

        candidateAddress.push(_address);

    
        emit CandidateCreate(
            idNumber,
            _age,
            _name,
            _image,
            0,
            _address,
            _ipfs
        );
    }

    function setVoter(
        address _address,
        string memory _name,
        string memory _image,
        string memory _ipfs
    ) public {
        require(
            voters[_address].voterAddress == address(0),
            "Voter is already registered"
        );

      
        _voterId.increment();

        uint256 idNumber = _voterId.current();

      
        voters[_address] = Voter({
            voterId: idNumber,
            name: _name,
            image: _image,
            voterAddress: _address,
            allowed: 1,
            hasVoted: false,
            votedFor: 0,
            ipfs: _ipfs
        });

        votersAddress.push(_address);

       
        emit VoterCreate(
            idNumber,
            _name,
            _image,
            _address,
            1,
            false,
            0,
            _ipfs
        );
    }
}
