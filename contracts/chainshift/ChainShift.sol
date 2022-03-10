// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "../openzeppelin/contracts/token/ERC721/IERC721.sol";

contract ChainShift {
	IERC721 public nft;
	address public devAddress;

	event InputShift(address indexed owner, address indexed to, uint256 indexed count, uint256[] tokenIds);
	event OutputShift(address indexed to, uint256[] tokenIds);

	mapping(address => uint256) public shiftCount;
	mapping(address => mapping(uint256 => uint256[])) public shiftTokenList;

	modifier onlyDev() {
		require(msg.sender == devAddress);
		_;
	}

	constructor(address ca) {
		devAddress = msg.sender;
		setNftCA(ca);
	}

	function input(uint256[] memory tokenIds, address to) public {
		shiftCount[msg.sender] += 1;
		uint256 count = shiftCount[msg.sender];
		for (uint256 i = 0; i < tokenIds.length; i++) {
			nft.transferFrom(msg.sender, address(this), tokenIds[i]);
		}
		emit InputShift(msg.sender, to, count, tokenIds);
	}

	function output(address to, uint256[] memory tokenIds) public onlyDev {
		for (uint256 i = 0; i < tokenIds.length; i++) {
			nft.transferFrom(address(this), to, tokenIds[i]);
		}
		emit OutputShift(to, tokenIds);
	}

	function setNftCA(address ca) public onlyDev {
		nft = IERC721(ca);
	}

	function setDevAddress(address dev) public onlyDev {
		devAddress = dev;
	}
}
