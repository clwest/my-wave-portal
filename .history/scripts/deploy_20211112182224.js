const main = async () => {
  // const [deployer] = await hre.ethers.getSigners();
  // const accountBalance = await deployer.getBalance();

  // console.log(`Deploying contracts with account ${deployer.address}`);
  // console.log(`Account balance: ${accountBalance.toString()}`);

  // const Token = await hre.ethers.getContractFactory("WavePortal");
  // const portal = await Token.deploy();
  // await portal.deployed();

  const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
  const waveContract = await waveContractFactory.deploy({
    value: hre.ethers.utils.parseEther("0.1"),
  });

  await waveContract.deployed();

  console.log(`Deployed WavePortal at ${waveContract.address}`);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (e) {
    console.error(e);
    process.exit(1);
  }
};

runMain();
