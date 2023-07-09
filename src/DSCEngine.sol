// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {DecentralizedStableCoin} from "./DecentralizedStableCoin.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/security/ReentrancyGuard.sol";

/** 
* @title DSCEngine
* @author Pandit Dhamdhere
*
* The system is designed to be as minimal as passible, and have the tokens maintain a 1 token == $1 peg.
* This stablecoin has the properties: 
* -Exogenous Collateral 
* -Doller pegged
* -Algorithmically Stable

* It is similar to DAI if DAI had no governance , no fees, and was only backed by only wETH and wBTC.
* Our DSC system should always be "overcollateralized". At no point, should the value of all collateral <= the $ backed value of all the DSC .
*
* @notice This contract is the core of the DSC System. It handles all the logic for minting and redeeming DSC, as well as depositing and withdrawing collateral.
* @notice This contract is VERY loosly based on the makerDAO DSS(DAI) system.

*/

contract DSCEngine is ReentrancyGuard {
    ///////////////
    // errors    //
    ////////////////
    error DSCEngine__NeedsMoreThanZero();
    error DSCEngine__TokenAddressesAndPriceFeedAddressesMustBeSameLength();
    error DSCEngine__NotAllowedToken();

    /////////////// ////////
    // State variables    //
    //////////////// ///////

    mapping(address token => address priceFeeds) private s_priceFeeds; //tokenToPriceFeeds;

    DecentralizedStableCoin private immutable i_dsc;
    ////////////////
    // modifiers  //
    ////////////////
    modifier moreThanZero(uint256 amount) {
        if (amount == 0) {
            revert DSCEngine__NeedsMoreThanZero();
        }
        _;
    }

    modifier isAllowedToken(address token) {
        if (s_priceFeeds[token] == address(0)) {
            revert DSCEngine__NotAllowedToken();
        }
        _;
    }

    ////////////////
    // functions  //
    ////////////////

    constructor(
        address[] memory tokenAddresses,
        address[] memory priceFeedAddresses,
        address dscAddress
    ) {
        if (tokenAddresses.length != priceFeedAddresses.length) {
            revert DSCEngine__TokenAddressesAndPriceFeedAddressesMustBeSameLength();
        }
        for (uint256 i = 0; i < tokenAddresses.length; i++) {
            s_priceFeeds[tokenAddresses[i]] = priceFeedAddresses[i];
        }
        i_dsc = DecentralizedStableCoin(dscAddress);
    }

    /////////////////////////
    //  external functions  //
    //////////////////////////

    function depositCollateralAndMintDsc() external {}

    /*
     * @param tokenCollateralAddress The Adress of the token to deposit as collateral
     * @param amountCollateral The amount of collateral to deposit
     */

    function depositCollateral(
        address tokenCollateralAddress,
        uint256 amountCollateral
    )
        external
        moreThanZero(amountCollateral)
        isAllowedToken(tokenCollateralAddress)
        nonReentrant
    {}

    function redeemCollateralForDsc() external {}

    function redeemCollteral() external {}

    function mintDsc() external {}

    function burnDsc() external {}

    function liquidate() external {}

    function getHealthFactor() external view {}
}
