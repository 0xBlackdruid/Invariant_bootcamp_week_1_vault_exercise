// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

// Chimera deps
import {BaseSetup} from "@chimera/BaseSetup.sol";
import {vm} from "@chimera/Hevm.sol";

// Managers
import {ActorManager} from "@recon/ActorManager.sol";
import {AssetManager} from "@recon/AssetManager.sol";

// Helpers
import {Utils} from "@recon/Utils.sol";

// Canaries
import "./CanaryStorage.sol";

// Your deps
import "src/utils/TheVault.sol";

abstract contract Setup is BaseSetup, ActorManager, AssetManager, Utils, CanaryStorage {
    TheVault erc4626;

    /// === Setup === ///
    /// This contains all calls to be performed in the tester constructor, both for Echidna and Foundry
    function setup() internal virtual override {
        address token = _newAsset(18); 
        erc4626 = new TheVault(ERC20(token), "shares", "shares");

        address[] memory approvals = new address[](1);
        approvals[0] = address(erc4626);

        _addActor(address(0x1));
        _addActor(address(0x2));

        _finalizeAssetDeployment(_getActors(), approvals, 100000e18);
    }

    /// === MODIFIERS === ///
    /// Prank admin and actor

    modifier asAdmin {
        vm.startPrank(address(this));
        _;
        vm.stopPrank();
    }

    modifier asActor {
        vm.startPrank(address(_getActor()));
        _;
        vm.stopPrank();
    }
}
