// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleLending {

    struct Position {
        uint collateral;
        uint debt;
    }

    mapping(address => Position) public positions;

    uint public constant COLLATERAL_FACTOR = 2; // 50% borrow power
    uint public constant LIQUIDATION_THRESHOLD = 150; // 150%

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // Deposit collateral (ETH)
    function depositCollateral() external payable {
        positions[msg.sender].collateral += msg.value;
    }

    // Borrow ETH (simplified lending)
    function borrow(uint amount) external {
        Position storage user = positions[msg.sender];

        uint maxBorrow = user.collateral / COLLATERAL_FACTOR;

        require(user.debt + amount <= maxBorrow, "Too much debt");

        user.debt += amount;

        payable(msg.sender).transfer(amount);
    }

    // Repay debt
    function repay() external payable {
        Position storage user = positions[msg.sender];

        require(msg.value <= user.debt, "Too much repay");

        user.debt -= msg.value;
    }

    // Check health factor
    function healthFactor(address userAddr) public view returns (uint) {
        Position memory user = positions[userAddr];

        if (user.debt == 0) return type(uint).max;

        return (user.collateral * 100) / user.debt;
    }

    // Liquidation
    function liquidate(address userAddr) external {
        Position storage user = positions[userAddr];

        uint hf = healthFactor(userAddr);

        require(hf < LIQUIDATION_THRESHOLD, "Position is healthy");

        uint collateral = user.collateral;
        uint debt = user.debt;

        user.collateral = 0;
        user.debt = 0;

        // liquidator gets collateral (simplified)
        payable(msg.sender).transfer(collateral);
    }

    receive() external payable {}
}