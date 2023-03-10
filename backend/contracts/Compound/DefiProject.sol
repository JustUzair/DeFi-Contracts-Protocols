// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./CTokenInterface.sol";
import "./ComptrollerInterface.sol";
import "./PriceOracleInterface.sol";

contract DefiProject {
    ComptrollerInterface public comptroller;
    PriceOracleInterface public priceOracle;

    constructor(address _comptroller, address _priceOracle) {
        comptroller = ComptrollerInterface(_comptroller);
        priceOracle = PriceOracleInterface(_priceOracle);
    }

    function supply(address cTokenAddress, uint underlyingAmount) external {
        CTokenInterface cToken = CTokenInterface(cTokenAddress);
        address underlyingAddress = cToken.underlying();
        IERC20(underlyingAddress).approve(cTokenAddress, underlyingAmount);
        uint result = cToken.mint(underlyingAmount);
        require(result == 0, "cToken mint failed, see Compound ErrorReporter.sol for more details");
    }

    function redeem(address cTokenAddress, uint cTokenAmount) external {
        CTokenInterface cToken = CTokenInterface(cTokenAddress);
        uint result = cToken.redeem(cTokenAmount);
        require(
            result == 0,
            "cToken redeem failed, see Compound ErrorReporter.sol for more details"
        );
    }

    function enterMarket(address cTokenAddress) external {
        address[] memory markets = new address[](1);
        markets[0] = cTokenAddress;
        uint[] memory results = comptroller.enterMarkets(markets);
        require(
            results[0] == 0,
            "comptroller enterMarket failed, see Compound ErrorReporter.sol for more details"
        );
    }

    function borrow(address cTokenAddress, uint borrowAmount) external {
        CTokenInterface cToken = CTokenInterface(cTokenAddress);
        address underlyingAddress = cToken.underlying();
        uint result = cToken.borrow(borrowAmount);
        require(
            result == 0,
            "cToken borrow failed, see Compound ErrorReporter.sol for more details"
        );
    }

    function repayBorrow(address cTokenAddress, uint underlyingAmount) external {
        CTokenInterface cToken = CTokenInterface(cTokenAddress);
        address underlyingAddress = cToken.underlying();
        IERC20(underlyingAddress).approve(cTokenAddress, underlyingAmount);
        uint result = cToken.repayBorrow(underlyingAmount);
        require(
            result == 0,
            "cToken repayBorrow failed, see Compound ErrorReporter.sol for more details"
        );
    }

    function getMaxBorrow(address cTokenAddress) external view returns (uint) {
        (uint result, uint liquidity, uint shortfall) = comptroller.getAccountLiquidity(
            address(this)
        );
        require(
            result == 0,
            "copmtroller getAccountLiquidity failed, see Compound ErrorReporter.sol for more details"
        );
        require(shortfall == 0, "Account underwater...");
        require(liquidity != 0, "Account doesn't have any collateral");
        uint underlyingPrice = priceOracle.getUnderlyingPrice(cTokenAddress);
        return liquidity / underlyingPrice;
    }
}
