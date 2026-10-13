// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {FoundryAsserts} from "@chimera/FoundryAsserts.sol";

import "forge-std/console2.sol";

import {Test} from "forge-std/Test.sol";
import {TargetFunctions} from "./TargetFunctions.sol";


// forge test --match-contract CryticToFoundry -vv
contract CryticToFoundry is Test, TargetFunctions, FoundryAsserts {
    function setUp() public {
        setup();

        targetContract(address(this));
    }

    // forge test --match-test test_crytic -vvv
    function test_crytic() public {
        // TODO: add failing property tests here for debugging
    }

    // forge test --match-test test_Reason: ErrorRevert_0pet -vvv
    function test_Reason: ErrorRevert_0pet() public {
    
        asset_mint(0x2e234DAe75C793f67A35089C9d99245E1C58470b,1);
    
        check_depositIncreasesTotalAssetsByAtMostX(0);
    
        property_previewDepositPositive(1);
    
    }
}