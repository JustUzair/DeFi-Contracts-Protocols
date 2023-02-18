/*
 * This script is intended to update the price feed for our Oracle contract
 */
const CoinGecko = require("coingecko-api")
const { network, ethers, getNamedAccounts, deployments } = require("hardhat")

const POLL_INTERVAL = 5000
const CoinGeckoClient = new CoinGecko()

async function updateData() {
    const { deploy, log } = deployments
    const { deployer, reporter } = await getNamedAccounts()
    const oracle = await ethers.getContract("Oracle")
    console.log(oracle)
}

updateData()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
    })
