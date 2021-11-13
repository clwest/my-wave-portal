const main = async () => {
  // const [owner, randomPerson] = await hre.ethers.getSigners();
  const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
  const waveContract = await waveContractFactory.deploy({
    value: her.ethers.utils.parseEther("0.1"),
  });
  await waveContract.deployed();
  console.log(`Deployed WavePortal at ${waveContract.address}`);

  let contractBalance = await hre.ethers.provider.getBalance(
    waveContract.address
  );
  console.log(
    `Contract balance: ${her.ethers.utils.formatEther(contractBalance)}`
  );

  let waveCount;
  waveCount = await waveContract.getTotalWaves();
  console.log(waveCount.toNumber());

  // Testing the waves
  let waveTxn = await waveContract.wave("Test Message!");
  await waveTxn.wait();

  const [_, randomPerson] = await hre.ethers.getSigners();
  waveTxn = await waveContract.connect(randomPerson).wave("Random message");
  await waveTxn.wait();

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
