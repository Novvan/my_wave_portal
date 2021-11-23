const main = async () => {
  const [owner, randomPerson] = await hre.ethers.getSigners();
  const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
  const waveContract = await waveContractFactory.deploy();
  await waveContract.deployed();

  console.log("Contract deployed to:", waveContract.address);
  console.log("Contract deployed by:", owner.address);

  let waveCount;
  waveCount = await waveContract.getTotalUploads();

  let waveTxn = await waveContract.uploadPlaylist("https://open.spotify.com/playlist/37i9dQZF1DXbbu94YBG7Ye?si=e02ebc4e03c14ae7");
  await waveTxn.wait();

  waveCount = await waveContract.getTotalUploads();

  waveTxn = await waveContract.connect(randomPerson).uploadPlaylist("https://open.spotify.com/playlist/37i9dQZF1DXbbu94YBG7Ye?si=e02ebc4e03c14ae7");
  await waveTxn.wait();

  waveCount = await waveContract.getTotalUploads();

  let playlists;
  playlists = await waveContract.getPlaylists();

  console.log(playlists);
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