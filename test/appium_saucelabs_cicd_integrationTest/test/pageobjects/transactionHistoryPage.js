const selectors = require('../../selectors/transactionSelectors')
const fixtures = require('../../utils/fixtures')
const transferPage = require('../pageobjects/transferPage')

class transactionHistoryPage {

    constructor(){
        this.phoneNumber = fixtures.data.phoneNumber
        this.desiredTransactionData = null
        this.transactionComponent = null
        this.accountNumberData = null
        this.transactionTimeData = null
        this.amountTransactedData = null
        this.transactionStatusData = null
        this.diffMs = null
        this.diffMinutes = null
        this.phoneNumber = fixtures.data.phoneNumber
        this.timeOfLiveTransaction = transferPage.timeOfLiveTransaction
    }

    get transactionHistoryPageButton(){
        return $(selectors.selector.transactionHistoryPageButton)
    }

    get transactionHistoryPageHeader(){
        return $(selectors.selector.transactionHistoryPageHeader)
    }

    getMostRecentTransactionElement(){
        return $(selectors.selector.mostRecentTransactionDataForDesiredAccountNumber(this.phoneNumber))
    }

    async openFromTransferPage(){
        await this.transactionHistoryPageButton.click()
        await this.transactionHistoryPageHeader.waitForExist({timeout:5000,timeoutMsg:`The Transaction history page did not open`})
    }

    async getMostRecentTransactionData(){
        this.desiredTransactionData = await this.getMostRecentTransactionElement(this.phoneNumber).getAttribute("content-desc")
        return this.desiredTransactionData
    }

    async cleanUpTheTransactionData(timeOfLiveTransaction){
        this.transactionComponent = await this.desiredTransactionData.split("\n")

        this.accountNumberData = this.transactionComponent[0]
        this.transactionTimeData = this.transactionComponent[1]
        this.amountTransactedData = this.transactionComponent[2]
        this.transactionStatusData = this.transactionComponent[3]

        let expectedTransactionTime = new Date(`1970-01-01 ${timeOfLiveTransaction}`)
        let receivedTransactionTime = new Date(`1970-01-01 ${this.transactionTimeData}`)
        this.diffMs = Math.abs( receivedTransactionTime - expectedTransactionTime );
        this.diffMinutes = this.diffMs / (1000 * 60);

        return {
            accountNumberData: this.accountNumberData,
            transactionTimeData: this.transactionTimeData,
            amountTransactedData: this.amountTransactedData,
            transactionStatusData: this.transactionStatusData,
            diffMinutes: this.diffMinutes
        }
    }

    // convenience: open history, fetch most recent for phone and parse
    async fetchMostRecentParsedTransaction(){
        await this.openFromTransferPage()
        await this.getMostRecentTransactionData(this.phoneNumber)
        return await this.cleanUpTheTransactionData(transferPage.timeOfLiveTransaction)
    }

}

module.exports = new transactionHistoryPage()