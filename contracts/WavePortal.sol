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

    Playlist[] playlists;
    mapping(address => uint256) public uploads;

    constructor() {
        console.log("Pepe is hereeeeee!");
    }

    function uploadPlaylist(string calldata _url) public {
        console.log("%s has uploaded an awesome playlist!", msg.sender);
        _savePlaylist(_url);
    }

    function _savePlaylist(string memory _url) private {
        playlists.push(Playlist(msg.sender,_url, block.timestamp));

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
