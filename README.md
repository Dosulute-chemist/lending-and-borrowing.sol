# Simple Proxy Smart Contract

A simple upgradeable proxy contract built with Solidity.  
This project demonstrates the Proxy Pattern, where a proxy contract delegates calls to an implementation contract while keeping the same storage.

## Overview

The Simple Proxy allows you to upgrade the logic of a smart contract without changing the contract address.

Instead of deploying a new contract every time you update your code:

- Users interact with the Proxy contract
- Proxy forwards calls to the current implementation
- New logic can be added by changing the implementation address

This is the basic idea behind upgradeable smart contracts used in many Web3 applications.

##  Technologies Used

- Solidity
- Remix IDE
- Ethereum Virtual Machine (EVM)
- Delegatecall

##  Project Structure
