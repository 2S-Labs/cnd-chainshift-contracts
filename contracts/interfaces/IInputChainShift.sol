// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

interface IInputChainShift {
  event InputShift(address indexed owner, uint256 indexed count, uint256[] tokenIds);
}