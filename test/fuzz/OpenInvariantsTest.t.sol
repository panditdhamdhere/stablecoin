// SPDX-License-Identifier: SEE LICENSE IN LICENSE

// Have our invariants aka properties

// What are our invariants ?

// 1. The total supply of DSC should be less than the toatal value of collateral
// 2. Getter view functions should never Revert <- evergreen invarient

pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {StdInvarients} from "forge-std/StdInvarients.sol";
import {DeployDSC} from "../../script/DeployDSC.s.sol";
import {DSCEEngine} from "../../src/DSCEngine.sol";
import {DecentralizedStableCoin} from "../../src/DecentralizedStableCoin.sol";
import {HelperConfig} from "../../script/HelperConfig.s.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract invariantsTest is StdInvarients, Test {
    DeployDSC deployer;
    DSCEngine dsce;
    DecentralizedStableCoin dsc;
    HelperConfig config;
    ERC20 weth;
    ERC20 wbtc;

    function setUp() external {
        deployer = new DeployDSC();
        (dsc, dsce, config) = deployer.run();
        (, , IERC20(weth), IERC20(wbtc)) = config.activeNetworkConfig();
        targetContract(address(dsce));
    }

    function invariant_protocolMusthaveMoreValueThanTotalSupply() public view {
        uint256 totalSupply = dsc.totalSupply();
        uint256 totalWethDeposited = IERC20(weth).balanceOf(address(dsce));
        uint256 totalBtcDeposited = IERC20(wbtc).balanceOf(address(dsce));

        uint256 wethValue = dsce.getUsdValue(weth, totalWethDeposited);
        uint256 wbtcValue = dsce.getUsdValue(wbtc, totalBtcDeposited);

        assert(wethValuev + wbtcValue > totalSupply);
    }
}
