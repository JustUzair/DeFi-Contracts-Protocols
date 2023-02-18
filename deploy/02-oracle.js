const { network, ethers } = require("hardhat")
const { developmentChains } = require("../helper-hardhat-config")
const { verify } = require("../utils/verify")
const CoinGecko = require("coingecko-api")
const CoinGeckoClient = new CoinGecko()

module.exports = async function ({ getNamedAccounts, deployments }) {
    const { deploy, log } = deployments
    const { deployer, reporter } = await getNamedAccounts()
    log("--------------------------")
    const oracle = await deploy("Oracle", {
        from: deployer,
        args: [deployer],
        log: true,
        waitConfirmations: network.config.blockConfirmations || 1,
    })

    log("--------------------------")
    const oracleContract = await ethers.getContract("Oracle")
    const consumer = await deploy("Consumer", {
        from: deployer,
        args: [oracleContract.address],
        log: true,
        waitConfirmations: network.config.blockConfirmations || 1,
    })

    log("--------------------------")

    if (!developmentChains.includes(network.name) && process.env.ETHERSCAN_API_KEY) {
        log("Verifying Oracle Contract................................")
        await verify(oracle.address, [deployer])
        log("Verifying Consumer Contract................................")
        await verify(consumer.address, [oracleContract.address])
    }
    log("--------------------------")
    log("Updating Oracle reporters and granting them access...")

    await oracleContract.updateReporter(deployer, true)

    await oracleContract.updateReporter(reporter, true)

    log("--------------------------")
    /* The section below is to update the oracle price feed for bitcoin */
    log("--------------------------")
    const res = await CoinGeckoClient.coins.fetch("bitcoin", {})
    let currentPrice = parseFloat(res.data.market_data.current_price.usd)
    currentPrice = parseInt(currentPrice * 100) // get data upto 2 decimal places
    console.log("--------------------------")
    console.log("Updating Oracle Data on-chain...")
    const key = ethers.utils.keccak256(ethers.utils.toUtf8Bytes("BTC/USD"))
    console.log(`Byte32 key for Bitcoin data: ${key}`)
    await oracleContract.updateData(key, currentPrice)
    console.log(`New price for BTC/USD ${currentPrice}, updated on-chain`)
    console.log("--------------------------")
}

module.exports.tags = ["all", "oracle", "main"]
