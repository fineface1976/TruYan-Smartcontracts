
require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

module.exports = {
  solidity: "0.8.24",
  networks: {
    bscmainnet: {
      url: process.env.BSC_MAINNET_RPC,
      accounts: [process.env.PRIVATE_KEY]
    },
    bsctestnet: {
      url: process.env.BSC_TESTNET_RPC,
      accounts: [process.env.PRIVATE_KEY]
    }
  }
};
