// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MonaiToken {
    string public name;
    string public symbol;
    uint8 public decimals = 18;
    uint256 public totalSupply;
    bool public paused;

    address public owner;
    mapping(address => uint256) public balance;
    mapping(address => mapping(address => uint256)) public allowance;
    mapping(address => bool) public minters;
    mapping(address => bool) public admins;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Paused(bool status);

    modifier onlyOwner() {
        require(msg.sender == owner, "not owner");
        _;
    }

    modifier onlyAdmin() {
        require(admins[msg.sender], "not admin");
        _;
    }

    modifier onlyMinter() {
        require(minters[msg.sender], "not minter");
        _;
    }

    modifier whenNotPaused() {
        require(!paused, "paused");
        _;
    }

    constructor(string memory _n, string memory _s, uint256 _supply) {
        name = _n;
        symbol = _s;
        owner = msg.sender;
        admins[msg.sender] = true;
        minters[msg.sender] = true;
        _mint(msg.sender, _supply);
    }

    function _mint(address to, uint256 amt) internal {
        totalSupply += amt;
        balance[to] += amt;
        emit Transfer(address(0), to, amt);
    }

    function mint(address to, uint256 amt) external onlyMinter whenNotPaused {
        _mint(to, amt);
    }

    function transfer(address to, uint256 amt) external whenNotPaused returns (bool) {
        require(balance[msg.sender] >= amt, "no balance");
        balance[msg.sender] -= amt;
        balance[to] += amt;
        emit Transfer(msg.sender, to, amt);
        return true;
    }

    function approve(address spender, uint256 amt) external returns (bool) {
        allowance[msg.sender][spender] = amt;
        emit Approval(msg.sender, spender, amt);
        return true;
    }

    function transferFrom(address from, address to, uint256 amt) external whenNotPaused returns (bool) {
        require(balance[from] >= amt, "no balance");
        require(allowance[from][msg.sender] >= amt, "no allowance");
        allowance[from][msg.sender] -= amt;
        balance[from] -= amt;
        balance[to] += amt;
        emit Transfer(from, to, amt);
        return true;
    }

    function pause() external onlyAdmin { paused = true; emit Paused(true); }
    function unpause() external onlyAdmin { paused = false; emit Paused(false); }

    function addMinter(address a) external onlyOwner { minters[a] = true; }
    function removeMinter(address a) external onlyOwner { minters[a] = false; }

    function addAdmin(address a) external onlyOwner { admins[a] = true; }
    function removeAdmin(address a) external onlyOwner { admins[a] = false; }

    function changeOwner(address n) external onlyOwner { owner = n; }
}
