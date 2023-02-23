// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./IFlashloanUser.sol";
import "./FlashloanProvider.sol";

contract FlashloanUser is IFlashloanUser {
    function startFlashloan(
        address flashloanProviderAddress,
        uint256 amount,
        address token
    ) external {
        FlashloanProvider(flashloanProviderAddress).executeFlashloan(
            address(this),
            amount,
            token,
            bytes("")
        );
    }

    function flashloanCallback(uint256 amount, address token, bytes memory data) external override {
        // do some arbitration, liquidation...
        // Reimburse borrowed tokens

        IERC20(token).transfer(msg.sender, amount); // send the token back to the flashloan provider
    }
}
