//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

contract Maintainer {
    address private admin;
    mapping(address => bool) private _maintainers;

    constructor() {
        admin = msg.sender;
        _maintainers[admin] = true;
    }

    modifier onlyMaintainer() {
        require(_maintainers[msg.sender], "Maintainer: caller is not a maintainer");
        _;
    }

    function addMaintainer(address user) external onlyMaintainer {
        _maintainers[user] = true;
    }

    function removeMaintainer(address user) external onlyMaintainer {
        require(user != admin, "Maintainer: admin cannot be removed");
        _maintainers[user] = false;
    }
}