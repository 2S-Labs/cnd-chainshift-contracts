// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "../openzeppelin/contracts/token/ERC721/IERC721.sol";

contract OutputChainShift {
	IERC721 public nft;

	function output(address owner, uint256[] memory tokenIds) public {
		for (uint256 i = 0; i < tokenIds.length; i++) {
			nft.transferFrom(msg.sender, owner, tokenIds[i]);
		}
	}
}
