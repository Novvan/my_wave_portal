// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    struct Playlist {
        address sender;
        string url;
        uint256 timestamp;
    }

    event NewPlaylist(address indexed from, uint256 timestamp, string url);

    uint256 private seed;

    Playlist[] playlists;
    mapping(address => uint256) public lastUpload;

    constructor() payable {
        console.log("Pepe is hereeeeee!");
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function uploadPlaylist(string calldata _url) public {
        require(
            lastUpload[msg.sender] + 15 minutes < block.timestamp,
            "Wait 15m before uploading again"
        );
        lastUpload[msg.sender] = block.timestamp;

        console.log("%s has uploaded an awesome playlist!", msg.sender);
        _savePlaylist(_url);
    }

    function _savePlaylist(string memory _url) private {
        playlists.push(Playlist(msg.sender, _url, block.timestamp));

        seed = (block.difficulty + block.timestamp + seed) % 100;

        if (seed <= 50) {
            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }

        emit NewPlaylist(msg.sender, block.timestamp, _url);
    }

    function getTotalUploads() public view returns (uint256) {
        // console.log("We have %d total playlists uploaded!", playlists.length);
        return playlists.length;
    }

    function getPlaylists() public view returns (Playlist[] memory) {
        return playlists;
    }
}
