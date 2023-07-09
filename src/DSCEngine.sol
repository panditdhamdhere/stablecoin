// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

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

contract DSCEngine {

function depositCollateralAndMintDsc() external {}

function depositCollateral() external {}

function redeemCollateralForDsc() external {}

function redeemCollteral() external {}

function mintDsc() external {}

function burnDsc () external {}

function liquidate() external {}

function getHealthFactor() external view {}
}
