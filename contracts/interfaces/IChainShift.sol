// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

interface IChainShift {
  event InputShift(address indexed owner, address indexed to, uint256 indexed count, uint256[] tokenIds);
	event OutputShift(address indexed to, uint256[] tokenIds);
}