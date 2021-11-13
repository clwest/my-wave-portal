const main = async () => {
  const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
  const waveContract = await waveContractFactory.deploy();
  await waveContract.deployed();
  console.log(`Deployed WavePortal at ${waveContract.address}`);
};

const runMain = async () => {
  await hre.ethers.getContractFactory("WavePortal").deploy();
  console.log("Deployed WavePortal at " + waveContract.address);
};
