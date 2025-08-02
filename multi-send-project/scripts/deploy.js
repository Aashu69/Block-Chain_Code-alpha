const hre = require("hardhat");

async function main() {
  const MultiSender = await hre.ethers.getContractFactory("MultiSender");
  const contract = await MultiSender.deploy();
  await contract.deployed();
  console.log("MultiSender deployed to:", contract.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
