// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    string[] playlists;
    mapping(address => uint) public uploads;

    constructor() {
        console.log("Pepe is hereeeeee!");
    }

    function uploadPlaylist(string calldata  _url) public {
        console.log("%s has uploaded an awesome playlist!", msg.sender);
        uploads[msg.sender] = uploads[msg.sender]++;
        _savePlaylist(_url);
    }
    function _savePlaylist(string memory _url) private {
        playlists.push(_url);
    }

    function getTotalUploads() public view returns (uint256) {
        console.log("We have %d total playlists uploaded!", playlists.length);
        return playlists.length;
    }

    function getPlaylists() public view returns (string[] memory) {
        // console.log();
        return playlists;
    }

}