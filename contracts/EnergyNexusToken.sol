// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title EnergyNexusToken ($ENEX)
 * @dev Token de infrastructură energetică RWA condus de Gemini AI Core Oracles.
 */
contract EnergyNexusToken {
    string public name = "Energy Nexus Token";
    string public symbol = "ENEX";
    uint8 public decimals = 18;
    uint256 public totalSupply = 500000000 * 10**18; // 500 M Tokens

    address public geminiOracleAdmin;
    bool public energyFlowActive = true;

    mapping(address => uint256) public balanceOf;

    event EnergyStatusUpdated(bool statusActive);

    modifier onlyOracle() {
        require(msg.sender == geminiOracleAdmin, "Doar Gemini AI Oracle poate executa");
        _;
    }

    constructor(address _oracle) {
        geminiOracleAdmin = _oracle;
        balanceOf[msg.sender] = totalSupply;
    }

    // Gemini AI oprește sau pornește fluxul de energie pe baza condițiilor de securitate
    function setEnergyFlowStatus(bool _status) external onlyOracle {
        energyFlowActive = _status;
        emit EnergyStatusUpdated(_status);
    }
}
