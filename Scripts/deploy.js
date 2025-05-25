lconst hre = require("hardhat");

async function main() {
  // Deploy ICO contract (replace with your MZLx token address)
  const MZLx = await hre.ethers.getContractFactory("MZLx");
  const token = await MZLx.deploy();
  await token.waitForDeployment();

  const TruYanICO = await hre.ethers.getContractFactory("TruYanICO");
  const ico = await TruYanICO.deploy(token.target);
  console.log("ICO deployed to:", ico.target);

  // Deploy Mining contract
  const TruYanMining = await hre.ethers.getContractFactory("TruYanMining");
  const mining = await TruYanMining.deploy(token.target);
  console.log("Mining deployed to:", mining.target);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
