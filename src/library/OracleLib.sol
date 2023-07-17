// SPDX-License-Identifier: SEE LICENSE IN LICENSE

pragma solidity ^0.8.19;

/*
 * @title OracleLib
 * @author Pandit Dhamdhere
 * @notice This library is used to check the chainLinkOracle for stale Date
 * If a price is stale, the function will revert, and render the DSCEngine unusable - this is by design.
 *  We want the DSCEngine to freeze if prices become stale.
 *
 * So the if the chainlink network explodes and you have a lot of money locked in the protocol ... too bad...!
 */

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library OracleLib {
    error OracleLib__StablePrice();
    uint256 private constant TIMEOUT = 3 hours;

    function staleCheckLatestRoundData(
        AggregatorV3Interface priceFeed
    ) public view returns (uint80, int256, uint256, uint256, uint80) {
        (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        ) = priceFeed.latestRoundData();

        uint256 secondsSince = block.timestamp - updatedAt;
        if (secondsSince > TIMEOUT) revert OracleLib__StablePrice();
        return (roundId, answer, startedAt, updatedAt, answeredInRound);
    }
}
