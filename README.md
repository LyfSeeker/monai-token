# Monai Token (ERC20 with Roles)

### Overview
A simple ERC20-compatible token deployed on the **Monad Testnet**.  
It includes two roles:
- **Admin**: Can pause/unpause the token, add/remove minters/admins, and change ownership.
- **Minter**: Can mint new tokens.

### Smart Contract Details
- **Name:** Monai
- **Symbol:** MONAI
- **Decimals:** 18
- **Initial Supply:** 1000 MONAI
- **Network:** Monad Testnet (Chain ID 10143)

### Roles
| Role | Permissions |
|------|--------------|
| **Owner/Admin** | Pause/unpause transfers, add or remove roles, change ownership |
| **Minter** | Mint new tokens |

### Deployment Steps
1. Open [Remix IDE](https://remix.ethereum.org/)
2. Paste the code into `contracts/MyToken.sol`
3. Compile using Solidity `0.8.20`
4. Deploy with parameters:  
   - `"Monai"`  
   - `"MONAI"`  
   - `1000000000000000000000`
5. Confirm transaction in MetaMask (Monad Testnet)

### Verification
1. Visit [Monadscan.io](https://monadscan.io/)
2. Search for your contract address
3. Click “Verify Contract”
4. Paste the Solidity code and match compiler settings
5. Submit — wait for the verified badge ✅

### Submission
- **GitHub Repo:** [your_repo_link_here]
- **Verified Contract:** [your_monadscan_link_here]
