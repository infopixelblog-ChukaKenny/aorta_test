const helperFunctions = require("../pageobjects/helperFunctions")
const fixtures = require("../../utils/fixtures")
const transferPage = require("../pageobjects/transferPage")
const transactionHistoryPage = require("../pageobjects/transactionHistoryPage")


describe("Aorta - Flutter",()=>{ 
    
helperFunctions.testHooks()

it("Happy Path",async ()=>{

    //Get the user's account balance
    await transferPage.getUsersCurrentAccountBalance()

    //Set Send Type
    await transferPage.sendType(fixtures.data.sendType_random)

    //Input recepient's account details
    await transferPage.transferFundsToRecepient()

    //Assert transaction state and success
    await transferPage.assertTransactionWasSuccessful()

})   

it("Queue & Sync",async ()=>{

    //Toggle off network connection
    await helperFunctions.toggleOffNetworkConnection()

    //Set Send Type
    await transferPage.sendType(fixtures.data.sendType_random)

    //Make a transfer to the recepient
    await transferPage.makeATransfer()

    //verify that the transaction was queued
    await transferPage.verifyThatTheTransactionWasQueued()

    //Toggle on network connection
    await helperFunctions.toggleOnNetworkConnection()

    //Assert that the pending transaction got completed upon switching to a wifi source
    await transferPage.assertThatThePendingTransactionGotCompleted()

}) 

it("Anti-Fraud Guard",async ()=>{

    //Queue a transaction
    await transferPage.queueATransaction(fixtures.data.sendType_random)

    //Attempt an overdraft
    await transferPage.attemptAnOverdraft()

    //Assert that the user was not overdrafted
    await transferPage.assertThatAnOverDraftWasNotAllowed()

}) 

it("App Restart Persistence", async () => {

    // Queue a transaction 
    await transferPage.queueATransaction(fixtures.data.sendType_persist)

    // Restart the application 
    await transferPage.restartApplication()

    // Fetch the most recent transaction from history 
    await transactionHistoryPage.fetchMostRecentParsedTransaction()

    // Assert that the queued transaction persisted
    await transferPage.assertQueuedTransactionPersisted()

})


})
