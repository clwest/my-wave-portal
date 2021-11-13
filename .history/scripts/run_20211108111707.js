const main = async () => {
  const [owner, randomPerson] = await hre.ethers.getSigners();
  const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
  const waveContract = await waveContractFactory.deploy();
  await waveContract.deployed();
  console.log(`Deployed WavePortal at ${waveContract.address}`);
  console.log(`Contract deployed by ${owner.address}`);

  let waveCount;
  waveCount = await waveContract.getTotalWaves();
  console.log(waveCount.toNumber());

  // Testing the waves
  let waveTxn = await waveContract.wave("Test Message!");
  await waveTxn.wait();

  // waveCount = await waveContract.getTotalWaves();

  const [_, randomPerson] = await hre.ethers.getSigners();
  waveTxn = await waveContract.connect(randomPerson).wave("Random message");
  await waveTxn.wait();

  // waveCount = await waveContract.getTotalWaves();
  let allWaves = await waveContract.getAllWaves();
  console.log(allWaves);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
