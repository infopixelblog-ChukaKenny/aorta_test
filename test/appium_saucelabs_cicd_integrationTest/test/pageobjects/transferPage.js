const fixtures = require('../../utils/fixtures')
const helperFunctions = require("../pageobjects/helperFunctions")
const selectors = require('../../selectors/transactionSelectors')
const transactionHistoryPage = require('../pageobjects/transactionHistoryPage')


class transferPage {

    constructor(){

        this.phoneNumber = fixtures.data.phoneNumber
        this.transactionHistoryState_success = new RegExp(fixtures.data.transactionHistoryState_success,"i")
        this.transactionHistoryState_failure = new RegExp(fixtures.data.transactionHistoryState_failure,"i")
        this.transactionHistoryState_queued = new RegExp(fixtures.data.transactionHistoryState_queued,"i")
        this.pin = fixtures.data.pin
        this.availableBalanceData = null
        this.availableBalanceData_split = null
        this.availableBalanceData_convertToNumber = null
        this.wasTheTransactionSuccessful = null
        this.didTheTransactionFail = null
        this.isTheTransactionQueued = null
        this.currentBalanceData = null
        this.currentBalanceData_split = null
        this.currentBalanceData_convertToNumber = null
        this.desiredTransactionData = null
        this.transactionComponent = null
        this.accountNumberData = null
        this.transactionTimeData = null
        this.amountTransactedData = null
        this.transactionStatusData = null
        this.expectedTransactionTime = null
        this.receivedTransactionTime = null
        this.diffMs = null
        this.diffMinutes = null
        this.timeOfLiveTransaction = null
        this.amountSending = null
        this.transactionConvertedToSuccessful = null
        this.specificAmount = fixtures.data.specificAmount
        this.amountSendType = null
        this.addThisToTheAvailableBalance = fixtures.data.addThisToTheAvailableBalance
        this.overDraftErrorSeen = null
        this.isKeyboardDisplayed = null
        this.timezone = 'Europe/London'

    }

get availableBalanceLocator(){
    return $(selectors.selector.availableBalanceLocator)
}

get recepientsAccountNumberTextField(){
    return $(selectors.selector.recepientsAccountNumberTextField)
}

get amountToSendTextField(){
    return $(selectors.selector.amountToSendTextField)
}

get randomAmount_uncleaned(){
    return (Math.random() * 1.5) + 1;
}

get randomAmount_cleaned(){
    return this.randomAmount_uncleaned.toFixed(2)
}

get amountToSend(){
    return this.randomAmount_cleaned
}

get sendButton(){
    return $(selectors.selector.sendButton)
}

get enterPinBottomSheetTitle(){
    return $(selectors.selector.enterPinBottomSheetTitle)
}

get transactionPinTextField(){
    return $(selectors.selector.transactionPinTextField)
}

get transactionPin(){
    return this.pin
}

get confirmButton(){
    return $(selectors.selector.confirmButton)
}

get successfulTransactionHeader(){
    return $(selectors.selector.successfulTransactionHeader)
}

get successfulTransactionMessage(){
    return $(selectors.selector.successfulTransactionMessage)
}

get queuedTransactionHeader(){
    return $(selectors.selector.queuedTransactionHeader)
}

get queuedTransactionMessage(){
    return $(selectors.selector.queuedTransactionMessage)
}

get failedTransactionErrorHeader(){
    return $(selectors.selector.failedTransactionErrorHeader)
}

get okButton(){
    return $(selectors.selector.okButton)
}

get increaseSendAmountErrorMessage(){
    return $(selectors.selector.increaseSendAmountErrorMessage)
}

get transactionHistoryPageButton(){
    return  $(selectors.selector.transactionHistoryPageButton)
}

get transactionHistoryPageHeader(){
    return $(selectors.selector.transactionHistoryPageHeader)
}

get transactionHistoryListItems(){
    return $(selectors.selector.transactionHistoryListItems(this.phoneNumber))
}

get mostRecentTransactionDataForDesiredAccountNumber(){
    return $(selectors.selector.mostRecentTransactionDataForDesiredAccountNumber(this.phoneNumber))
}

get backButton(){
    return $(selectors.selector.backButton)
}

get processingTransactionLocator(){
    return $(selectors.selector.processingTransactionLocator)
}

get notEnoughBalanceLocator(){
    return $(selectors.selector.notEnoughBalanceLocator)
}

async getCurrentTime() { 
    const now = new Date();
    return `${now.getUTCHours() % 12 || 12}:${now.getUTCMinutes().toString().padStart(2, '0')} ${now.getUTCHours() >= 12 ? 'pm' : 'am'}`;
}
    
// async getCurrentTime(){

//     let currentTime = new Intl.DateTimeFormat('en-US', {
//             hour: 'numeric',
//             minute: 'numeric',
//             hour12: true
//         }).format(new Date()).toLowerCase()

//     return currentTime
// }

async getUsersCurrentAccountBalance(){

    //Get the users available balance data
    this.availableBalanceData = await this.availableBalanceLocator.getAttribute("content-desc")
    console.log(`This is the initial balance : ${this.availableBalanceData}`)

        //Clean up the available balance data and convert it to a number
        this.availableBalanceData_split = await this.availableBalanceData.split("€")
        console.log(this.availableBalanceData_split)
        this.availableBalanceData_convertToNumber = Number(this.availableBalanceData_split[1])
        console.log(`This is the number conversion ab-initio ${this.availableBalanceData_convertToNumber}`)

    //Statically wait
    await browser.pause(1000)

}

async inputRecepientsAccountDetails(){

    // Input recepient's phonenumber / acct number
    await this.recepientsAccountNumberTextField.click()
    await this.recepientsAccountNumberTextField.addValue(this.phoneNumber)
    console.log(`recepient's account number inputed`)

    //Assess if keyboard is shown
    this.isKeyboardDisplayed = await driver.isKeyboardShown()
    console.log(`is Keyboard Displayed?:${this.isKeyboardDisplayed}`)
    
    //If Keyboard is open 
    if( await this.isKeyboardDisplayed == true ){
    //Hide the keyboard
    await browser.pressKeyCode(4)
    console.log(`Keyboard Closed`)
    }    

    //Statically wait
    await browser.pause(1000)

}

async inputAmountToTransfer(){
  
    /**
     *  amount to be debited 
     */

    //  random amount
    if( this.amountSendType == "random" ){

        console.log(`The amount to be sent set to random \n Generating random amount..`)

        //Send a randomized amount
        this.amountSending = this.amountToSend
        await this.amountToSendTextField.click()
        await this.amountToSendTextField.addValue(this.amountSending);
        console.log(`Transaction amount ed: ${this.amountSending}`)
        console.log(`sent amount: ${this.amountSending}`)


       //Assess if keyboard is shown
       this.isKeyboardDisplayed = await driver.isKeyboardShown()
       console.log(`is Keyboard Displayed?:${this.isKeyboardDisplayed}`)
    
        //If Keyboard is open 
        if( await this.isKeyboardDisplayed == true ){
         //Hide the keyboard
         await browser.pressKeyCode(4)
         console.log(`Keyboard Closed`)
        }

    } 

    // specified amount
    else if( this.amountSendType == "specific" ){

        console.log(`The amount to be sent was specified.`)

        //Send specified amount
        await this.amountToSendTextField.click()
        await this.amountToSendTextField.addValue(this.specificAmount);
        console.log(`Transaction amount ed: ${this.specificAmount}`)
        console.log(`sent amount: ${this.specificAmount}`)

       //Assess if keyboard is shown
       this.isKeyboardDisplayed = await driver.isKeyboardShown()
       console.log(`is Keyboard Displayed?:${this.isKeyboardDisplayed}`)
    
        //If Keyboard is open 
        if( await this.isKeyboardDisplayed == true ){
         //Hide the keyboard
         await browser.pressKeyCode(4)
         console.log(`Keyboard Closed`)
        }    

    }

    // Overdraft amount
    else if( this.amountSendType == "overdraft" ){

        console.log(` An overdraft transaction is taking place ...`)

        this.overDraftAmount =  await (this.availableBalanceData_convertToNumber + this.addThisToTheAvailableBalance + 0.001 ).toFixed(2)

        //Send specified amount
        await this.amountToSendTextField.click()
        await this.amountToSendTextField.addValue(this.overDraftAmount);
        console.log(`Transaction amount ed: ${this.overDraftAmount}`)
        console.log(`sent amount: ${this.overDraftAmount}`)

       //Assess if keyboard is shown
       this.isKeyboardDisplayed = await driver.isKeyboardShown()
       console.log(`is Keyboard Displayed?:${this.isKeyboardDisplayed}`)
    
        //If Keyboard is open 
        if( await this.isKeyboardDisplayed == true ){
         //Hide the keyboard
         await browser.pressKeyCode(4)
         console.log(`Keyboard Closed`)
        }    

    }
     
}

async calculateExpectedBalanceIfTransactionIsSuccessful(){

    //Calculate Expected Balance if transaction is successful
    let expectedBalance = await (this.availableBalanceData_convertToNumber - Number(this.amountSending) )
    console.log(`Expected balance should be ${expectedBalance}`)

}

async clickSend(){

    //Click "Send"
    await this.sendButton.click()
    console.log(`User clicked on the send button`)

}

async recordTheTimeOfTheTransaction(){
    //Record the time of the transaction
    this.timeOfLiveTransaction = await this.getCurrentTime()
    console.log(`This was the time of the live transaction "${this.timeOfLiveTransaction}" `)    
}

async inputTransactionPin(){

    //Wait for the "Transaction Pin" bottom sheet to popup
    await this.enterPinBottomSheetTitle.waitForExist({timeout:5000,timeoutMsg:`The "Input Transaction Pin" bottom sheet did not popup`})
    console.log(`The "Input Transaction Pin" bottom sheet popped up`)

    //Input your transaction pin
    await this.transactionPinTextField.click()
    await this.transactionPinTextField.addValue(this.pin)
    console.log(`Transaction Pin has been inputed`)

   // //Assess if keyboard is shown
   // this.isKeyboardDisplayed = await driver.isKeyboardShown()
   // console.log(`is Keyboard Displayed?:${this.isKeyboardDisplayed}`)

   //  //If Keyboard is open 
   //  if( await this.isKeyboardDisplayed == true ){
   //   //Hide the keyboard
   //   await browser.pressKeyCode(4)
   //   console.log(`Keyboard Closed`)
   //  }   

}

async assertTransactionWasSuccessful(){

    //Wait for transaction state popup
    await this.scanForTransactionStatePopup()

        //If the transaction was successful
        if( await this.wasTheTransactionSuccessful == true ){

            console.log(`Following the "Transaction Successful" path...`)

            //click Ok
            await this.okButton.click()
            console.log("User clicked 'Ok' Button")

            //Evaluate the user's current Balance post-transaction
            await this.checkTheUsersBalancePostTransferAttempt()

            //Navigate to the "Transaction History" page
            await this.navigateToTheTransactionHistoryPage()

            //Get most recent transaction data
            await this.getTheMostRecentTransactionData()

            //Clean up the transaction data
            await this.cleanUpTheTransactionData()

                //Assert that transaction was successful
                if (
                    (await this.accountNumberData == this.phoneNumber) &&
                    (await this.diffMinutes <= 62) &&
                    (await this.amountTransactedData == (`€${this.amountSending}`)) &&
                    (await /completed/i.test(this.transactionHistoryState_success)) &&
                    (await this.wasTheTransactionSuccessful == true)
                ){
                    console.log(`Asserting...`)
                    await expect(this.transactionStatusData).toMatch(this.transactionHistoryState_success)
                }
                else {
                    throw new Error(`Transaction not found`)
                }


        }

        //If the transaction failed
        else if( await this.didTheTransactionFail == true ){

            throw new Error("Transaction Failed unexpectedly")

        }

        //If the transaction got queued
        else if( await this.isTheTransactionQueued == true ){

            throw new Error("Transaction was Queued unexpectedly. Check network strength")

        }

}

async transferFundsToRecepient(){

    //Input recepient's account details
    await this.inputTransactionDetails()

    //Input transaction pin
    await this.inputTransactionPin()

}
    
async inputTransactionDetails(){

    //Input recepient's account details
    await this.inputRecepientsAccountDetails()

    //Input amount to be transfered
    await this.inputAmountToTransfer()

    //Calculate Expected Balance If Transaction Is Successful
    await this.calculateExpectedBalanceIfTransactionIsSuccessful()

    //Click "Send"
    await this.clickSend()

    //Record the time of the transaction
    await this.recordTheTimeOfTheTransaction()
    
}


async makeATransfer(){

    //Get the user's account balance
    await this.getUsersCurrentAccountBalance()

    //Transfer amount to recepient
    await this.transferFundsToRecepient()  

}

async attemptAnOverdraft(){
    
    //Assess if keyboard is shown
    this.isKeyboardDisplayed = await driver.isKeyboardShown()
    console.log(`is Keyboard Displayed?:${this.isKeyboardDisplayed}`)
    
        //If Keyboard is open 
        if( await this.isKeyboardDisplayed == true ){
           //Hide the keyboard
           await browser.pressKeyCode(4)
           console.log(`Keyboard Closed`)
        }   
    
    //Get the user's account balance
    await this.getUsersCurrentAccountBalance()

    //Set Send Type
    await this.sendType(fixtures.data.sendType_overdraft)

    //Input recepient's account details
    await this.inputTransactionDetails()  

}

async navigateToTheTransactionHistoryPage(){

    //Navigate to the "Transaction History" page
    await this.transactionHistoryPageButton.click()
    console.log("User clicked on transaction history page button")

    //Wait for the "Transaction History" page to load
    await this.transactionHistoryPageHeader.waitForExist({timeout:5000,timeoutMsg:`The Transaction history page did not open`})
    console.log("User clicked on 'transaction history' page button")  

}

async getTheMostRecentTransactionData(){
    
    //Get most recent transaction data
    this.desiredTransactionData = await this.mostRecentTransactionDataForDesiredAccountNumber.getAttribute("content-desc")   

}

async cleanUpTheTransactionData(){

    //Clean up the transaction data
    this.transactionComponent = await this.desiredTransactionData.split("\n")

        this.accountNumberData = this.transactionComponent[0]
        this.transactionTimeData = this.transactionComponent[1]
        this.amountTransactedData = this.transactionComponent[2]
        this.transactionStatusData = this.transactionComponent[3]

    console.log(
        `This is the account Number Data in focus ${this.accountNumberData} \n  
         This is the transaction Time Data in focus ${this.transactionTimeData} \n  
         This is the amount Transacted Data in focus ${this.amountTransactedData} \n  
         This is the transaction Status Data in focus ${this.transactionStatusData}`
    )

    //Calculate the transaction time accuracy
    let expectedTransactionTime = await new Date(`1970-01-01 ${this.timeOfLiveTransaction}`) 
    let receivedTransactionTime = await new Date(`1970-01-01 ${this.transactionTimeData}`)
    this.diffMs = await Math.abs( receivedTransactionTime - expectedTransactionTime );
    this.diffMinutes = await this.diffMs / (1000 * 60);
    console.log(`expected Transaction Time object: ${expectedTransactionTime}`)
    console.log(`received Transaction Time object: ${receivedTransactionTime}`)
    console.log(`The difference in minutes is : ${this.diffMinutes}`)    

}

async checkTheUsersBalancePostTransferAttempt(){

   //Assess if keyboard is shown
   this.isKeyboardDisplayed = await driver.isKeyboardShown()
   console.log(`is Keyboard Displayed?:${this.isKeyboardDisplayed}`)

    //If Keyboard is open 
    if( await this.isKeyboardDisplayed == true ){
     //Hide the keyboard
     await browser.pressKeyCode(4)
     console.log(`Keyboard Closed`)
    }

    //Evaluate the user's current Balance post-transaction
    this.currentBalanceData = await this.availableBalanceLocator.getAttribute("content-desc")
    console.log(`This is the current balance post-transaction : ${this.currentBalanceData}`)

    //Clean up the available balance data and convert it to a number
    this.currentBalanceData_split = await this.currentBalanceData.split("€")
    console.log(this.currentBalanceData_split)
    this.currentBalanceData_convertToNumber = Number(this.currentBalanceData_split[1])
    console.log(`This is the number conversion post-transaction ${this.currentBalanceData_convertToNumber}`)

}

async scanForTransactionStatePopup(){

   // //Assess if keyboard is shown
   // this.isKeyboardDisplayed = await driver.isKeyboardShown()
   // console.log(`is Keyboard Displayed?:${this.isKeyboardDisplayed}`)

   //    //If Keyboard is open 
   //       if( await this.isKeyboardDisplayed == true ){
   //          //Hide the keyboard
   //          await browser.pressKeyCode(4)
   //          console.log(`Keyboard hidden`)
   //       }

    //Wait for transaction state popup
    await this.okButton.waitForExist({timeout:5000,timeoutMsg:"The transaction state dialogue did not popup"})

    //What is the state of the transaction?
    this.wasTheTransactionSuccessful = await this.successfulTransactionHeader.isDisplayed()
    this.didTheTransactionFail = await this.failedTransactionErrorHeader.isDisplayed()
    this.isTheTransactionQueued = await this.queuedTransactionHeader.isDisplayed() 
    console.log(`was the Transaction Successful?: ${this.wasTheTransactionSuccessful}`)
    console.log(`did the Transaction Fail?: ${this.didTheTransactionFail}`)
    console.log(`is the Transaction Queued?: ${this.isTheTransactionQueued}`) 

}

async verifyThatTheTransactionWasQueued(){

    //Wait for transaction state popup
    await this.scanForTransactionStatePopup()

    //If the transaction got queued   
    if( await this.isTheTransactionQueued == true ){

        console.log(`Transaction Queue popup appeared successfully`)

        //click Ok
        await this.okButton.click()
        console.log("User clicked 'Ok' Button")

        //Navigate to the "Transaction History" page
        await this.navigateToTheTransactionHistoryPage()

        //Get most recent transaction data
        await this.getTheMostRecentTransactionData()

        //Clean up the transaction data
        await this.cleanUpTheTransactionData()

        //Double verify that the transaction was successfully queued before proceeding
        if (
            (await this.accountNumberData == this.phoneNumber) &&
            (await this.diffMinutes <= 62) &&
            (await this.amountTransactedData == (`€${this.amountSending}`)) &&
            (await /pending/i.test(this.transactionHistoryState_queued)) &&
            (await this.isTheTransactionQueued == true)
        ){

            console.log(`The transaction was successfully queued \n  Continuing test..`);
            return;

        }
        else {

            throw new Error(`Transaction was not found`)

        }



    }
    //If the transaction failed
    else if( await this.didTheTransactionFail == true ){

        throw new Error("Transaction Failed unexpectedly")

    }
    //If the transaction was successful
    else if( await this.wasTheTransactionSuccessful == true ){

        throw new Error("Transaction Succeeded unexpectedly")

    }
    
}

async queueATransaction(sendType){

     console.log(`Queueing a transaction`)

    //Toggle off network connection
    await helperFunctions.toggleOffNetworkConnection()

    //Set Send Type
    await this.sendType(sendType)

    //Transfer amount to recepient
    await this.transferFundsToRecepient() 

    console.log(`Transaction Queued Successfully`)

    //Click ok button
    await this.okButton.click()

}

// Perform a transfer that is expected to be rejected by the server
async performServerRejectedTransfer(){

    // Get initial balance
    await this.getUsersCurrentAccountBalance()
    const preBalance = this.availableBalanceData_convertToNumber

    // Use specific send type and amount that should trigger rejection
    await this.sendType(fixtures.data.sendType_specific)
    this.specificAmount = fixtures.data.specificAmount_serverRejection || this.specificAmount

    // Input and send
    await this.inputTransactionDetails()
    await this.inputTransactionPin()

    // Wait for popup and capture state
    await this.scanForTransactionStatePopup()
    const didFail = this.didTheTransactionFail

    // Dismiss popup
    await this.okButton.click()

    // Read balance after the failed attempt
    await this.checkTheUsersBalancePostTransferAttempt()
    const postBalance = this.currentBalanceData_convertToNumber

    return { preBalance, postBalance, didFail }

}

// Restart the application and wait for primary UI to appear
async restartApplication(){
    await helperFunctions.restartApp()
    await this.availableBalanceLocator.waitForExist({ timeout: 10000 })
}

// Assert that a parsed transaction object represents a persisted queued tx
async assertQueuedTransactionPersisted()
{
    console.log(`Asserting..`)
    await expect(transactionHistoryPage.accountNumberData).toBe(this.phoneNumber)
    await expect(transactionHistoryPage.amountTransactedData).toBe(`€${this.amountSending}`)
    await expect(/pending/i.test(transactionHistoryPage.transactionStatusData)).toBeTruthy()
}

// Assert server rejection rolled back the balance
async assertServerRejectionRolledBack(result){
    if(!result.didFail){
        throw new Error('Expected server to reject the transaction (didFail=false)')
    }
    await expect(result.postBalance).toBe(result.preBalance)
}


async checkTransactionStatus_queueTest() {
    if (
        ( this.accountNumberData == this.phoneNumber ) &&
        ( this.diffMinutes <= 62 ) &&
        ( this.amountTransactedData == `€${this.amountSending}` ) &&
        ( /completed/i.test(this.transactionStatusData) )
    ){
        console.log(`The transaction was successfully converted to successful`);
        return true;
    }
    else if (
        ( this.accountNumberData == this.phoneNumber ) &&
        ( this.diffMinutes <= 62 ) &&
        ( this.amountTransactedData == `€${this.amountSending}` ) &&
        ( /failed/i.test(this.transactionStatusData) )
    ){
        throw new Error(`The transaction failed unexpectedly`);
    }
    else if (
        ( this.accountNumberData == this.phoneNumber ) &&
        ( this.diffMinutes <= 62 ) &&
        ( this.amountTransactedData == `€${this.amountSending}` ) &&
        ( /pending/i.test(this.transactionStatusData) ) 
    ){
        throw new Error(`The transaction returned to queued state`);
    }
    return false;
}

async assertThatThePendingTransactionGotCompleted(){

    //Wait for the processing status indicator
    await this.processingTransactionLocator.waitForExist({timeout:20000,timeoutMsg:"The 'transaction processing' indicator did not appear"})
    console.log(`Processing Transaction..`)

    //Wait for the processing status indicator to disappear
    await this.processingTransactionLocator.waitForExist({timeout:20000,reverse:true,timeoutMsg:"The 'transaction processing' indicator did not disappear"})
    console.log(`Processing complete`)

    //Get most recent transaction data
    await this.getTheMostRecentTransactionData()

    //Clean up the transaction data
    await this.cleanUpTheTransactionData()

    //Check current transaction state
    await this.checkTransactionStatus_queueTest()

    //Assert that the transaction was successful
    const wasSuccessful = await this.checkTransactionStatus_queueTest();
    console.log(`was the transaction Converted To Successful ?: ${wasSuccessful}`);
    expect(wasSuccessful).toBe(true)
    console.log(`Test Passed`)

}

async sendType(sendType){
    this.amountSendType = sendType
    console.log(`Amount send type set`)
}

async assertThatAnOverDraftWasNotAllowed(){

    //Wait for the overdraft error
    await this.notEnoughBalanceLocator.waitForExist({timeout:10000,timeoutMsg:"Overdraft Error Message was not displayed. The user may have successfully overdrafted the account"})
    this.overDraftErrorSeen = true

    //Assert that the user was not overdrafted
    await expect(this.overDraftErrorSeen).toBeTruthy()

}



}

module.exports = new transferPage()
