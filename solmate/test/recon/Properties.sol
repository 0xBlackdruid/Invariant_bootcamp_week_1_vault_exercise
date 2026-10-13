// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {Asserts} from "@chimera/Asserts.sol";
import {BeforeAfter} from "./BeforeAfter.sol";

// Your deps
import "src/tokens/ERC4626.sol";

abstract contract Properties is BeforeAfter, Asserts {

    /// CUSTOM PROPERTIES - Add your own properties functions here ///

// totalAssets() >= convertToAssets(totalSupply())
function property_totalAssetsCoversSupply() public {
    uint256 totalAssets = erc4626.totalAssets();
    uint256 totalClaims =
        erc4626.convertToAssets(erc4626.totalSupply());

    gte(
        totalAssets,
        totalClaims,
        "converted supply exceeds total assets"
    );
}

// deposit(x) increases totalAssets() by at most x

function _depositIncreasesTotalAssetsByX(uint256 x) internal {
    address actor = _getActor();

    uint256 totalAssetsBefore = erc4626.totalAssets();

    erc4626.deposit(x, actor);

    uint256 totalAssetsAfter = erc4626.totalAssets();

    lte(
        totalAssetsAfter,
        totalAssetsBefore + x,
        "deposit increased totalAssets by more than x"
    );
}


// previewDeposit(x) > 0 for x > 0
// @audit note: Inflation attack

function property_previewDepositPositive(uint256 x) public {
    precondition(x > 0);

    gt(
        erc4626.previewDeposit(x),
        0,
        "positive deposit previews zero shares"
    );
}

    /// AUTO GENERATED CANARIES FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

}