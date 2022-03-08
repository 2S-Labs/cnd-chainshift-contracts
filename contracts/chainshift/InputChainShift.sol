// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "../interfaces/IInputChainShift.sol";
import "../openzeppelin/contracts/token/ERC721/IERC721.sol";

contract InputChainShift is IInputChainShift {
	IERC721 public nft;

	mapping(address => uint256) public shiftCount;
	mapping(address => mapping(uint256 => uint256[])) public shiftTokenList;

	function input(uint256[] memory tokenIds) public {
		shiftCount[msg.sender] += 1;
		uint256 count = shiftCount[msg.sender];
		for (uint256 i = 0; i < tokenIds.length; i++) {
			nft.transferFrom(msg.sender, address(this), tokenIds[i]);
		}
		emit InputShift(msg.sender, count, tokenIds);
	}
}