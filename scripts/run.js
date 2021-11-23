const main = async () => {
  const [owner, randomPerson] = await hre.ethers.getSigners();
  const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
  const waveContract = await waveContractFactory.deploy({
    value: hre.ethers.utils.parseEther("0.1"),
  });
  await waveContract.deployed();

  console.log("Contract deployed to:", waveContract.address);
  console.log("Contract deployed by:", owner.address);

  let contractBalance = await hre.ethers.provider.getBalance(
    waveContract.address
  );
  console.log(
    "Contract balance:",
    hre.ethers.utils.formatEther(contractBalance)
  );

  let waveCount;
  waveCount = await waveContract.getTotalUploads();

  console.log("TotalUploads:", waveCount);

  for (let i = 0; i < 5; i++) {
    let waveTxn = await waveContract.uploadPlaylist(
      "https://open.spotify.com/playlist/37i9dQZF1DXbbu94YBG7Ye?si=e02ebc4e03c14ae7"
    );
    await waveTxn.wait();
    contractBalance = await hre.ethers.provider.getBalance(
      waveContract.address
    );
    console.log(
      "Contract balance:",
      hre.ethers.utils.formatEther(contractBalance)
    );
  }

  waveCount = await waveContract.getTotalUploads();

  console.log("TotalUploads:", waveCount);

  let playlists;
  playlists = await waveContract.getPlaylists();

  // console.log(playlists);
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
