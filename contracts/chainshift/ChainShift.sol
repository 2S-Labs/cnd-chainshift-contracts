// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "../openzeppelin/contracts/token/ERC721/IERC721.sol";

contract ChainShift {
	IERC721 public nft;
	address public devAddress;
	address public storeAddress;

	event InputShift(address indexed owner, address indexed to, uint256 indexed count, uint256[] tokenIds);
	event OutputShift(address indexed to, uint256[] tokenIds);

	mapping(address => uint256) public shiftCount;
	mapping(address => mapping(uint256 => uint256[])) public shiftTokenList;

	modifier onlyDev() {
		require(msg.sender == devAddress);
		_;
	}

	modifier onlyStore() {
		require(msg.sender == storeAddress);
		_;
	}

	constructor(address ca, address addr) {
		devAddress = msg.sender;
		setNftCA(ca);
		setStoreAddress(addr);
	}

	function input(uint256[] memory tokenIds, address to) public {
		shiftCount[msg.sender] += 1;
		uint256 count = shiftCount[msg.sender];
		for (uint256 i = 0; i < tokenIds.length; i++) {
			nft.transferFrom(msg.sender, storeAddress, tokenIds[i]);
		}
		emit InputShift(msg.sender, to, count, tokenIds);
	}

	function output(address to, uint256[] memory tokenIds) public onlyStore {
		for (uint256 i = 0; i < tokenIds.length; i++) {
			nft.transferFrom(storeAddress, to, tokenIds[i]);
		}
		emit OutputShift(to, tokenIds);
	}

	function setNftCA(address ca) public onlyDev {
		nft = IERC721(ca);
	}

	function setDevAddress(address addr) public onlyDev {
		devAddress = addr;
	}

	function setStoreAddress(address addr) public onlyDev {
		storeAddress = addr;
	}
}
