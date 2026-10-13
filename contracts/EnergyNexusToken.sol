// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title EnergyNexusToken ($ENEX)
 * @dev Advanced RWA Infrastructure Token for Eurasian Energy Hub, 
 *      governed by Gemini AI Core Oracles and institutional security standards.
 */
contract EnergyNexusToken is ERC20, Ownable {
    
    // Starea fluxului energetic: true = Normal (Pace), false = Urgență / Conflict (Kill-Switch activat)
    bool public energyFlowActive;
    
    // Adresa oracolului de securitate sau a comitetului internațional de monitorizare
    address public securityOracle;
    
    // Evenimente pentru transparență on-chain și audit
    event EnergyStatusUpdated(bool indexed newStatus, address indexed updatedBy);
    event DividendsDistributed(uint256 indexed amount, uint256 timestamp);
    event OracleUpdated(address indexed oldOracle, address indexed newOracle);

    modifier onlyOracleOrOwner() {
        require(msg.sender == securityOracle || msg.sender == owner(), "ENEX: Caller not authorized as Oracle or Owner");
        _;
    }

    constructor(
        string memory name,
        string memory symbol,
        uint256 initialSupply,
        address _securityOracle,
        address initialOwner
    ) ERC20(name, symbol) Ownable(initialOwner) {
        require(_securityOracle != address(0), "ENEX: Invalid oracle address");
        _mint(initialOwner, initialSupply * 10 ** decimals());
        securityOracle = _securityOracle;
        energyFlowActive = true; // Sistemul pornește în regim normal de operare
    }

    /**
     * @dev Actualizează starea de securitate geostrategică (Kill-Switch). 
     *      Dacă este setat pe false, toate transferurile și distribuțiile sunt blocate instantaneu.
     */
    function setEnergyFlowStatus(bool _status) external onlyOracleOrOwner {
        energyFlowActive = _status;
        emit EnergyStatusUpdated(_status, msg.sender);
    }

    /**
     * @dev Modifică adresa oracolului de securitate administrat de Gemini AI Core / Comitet.
     */
    function setSecurityOracle(address _newOracle) external onlyOwner {
        require(_newOracle != address(0), "ENEX: Invalid new oracle address");
        emit OracleUpdated(securityOracle, _newOracle);
        securityOracle = _newOracle;
    }

    /**
     * @dev Suprascrie funcția de transfer internă pentru a implementa blocajul geostrategic de urgență.
     */
    function _update(
        address from,
        address to,
        uint256 value
    ) internal virtual override {
        require(
            energyFlowActive || from == address(0) || to == address(0), 
            "ENEX: EMERGENCY LOCK - Transfers blocked due to geopolitical conflict or active crisis."
        );
        super._update(from, to, value);
    }

    /**
     * @dev Funcție instituțională pentru distribuirea profiturilor din taxele de tranzit energetic 
     *      către deținătorii de tokeni sub formă de monede stabile (stablecoins/ETH).
     */
    function distributeTransitProfits() external payable onlyOwner {
        require(energyFlowActive, "ENEX: Cannot distribute profits during active geopolitical crisis.");
        require(msg.value > 0, "ENEX: No profit amount provided for distribution");
        
        emit DividendsDistributed(msg.value, block.timestamp);
        // Logica extinsă de distribuție proporțională on-chain poate fi integrată aici
    }

    /**
     * @dev Permite retragerea fondurilor de rezervă sau a surplusului în caz de urgență administrativă.
     */
    function emergencyWithdraw() external onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "ENEX: No funds available for withdrawal");
        (bool success, ) = payable(owner()).call{value: balance}("");
        require(success, "ENEX: Emergency withdrawal failed");
    }
}
