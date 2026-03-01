const selector = {
    availableBalanceLocator: `//android.view.View[@content-desc="Available Balance"]/following-sibling::*[contains(@content-desc,"€")]`,
    recepientsAccountNumberTextField: `//android.view.View[@content-desc="Recipient"]//following-sibling::android.widget.EditText[@hint = "Phone or account number"]`,
    amountToSendTextField: `//android.view.View[@content-desc="Amount of Transfer Request"]//following-sibling::android.widget.EditText[@hint = "Enter amount"]`,
    sendButton: `//android.widget.Button[contains(@content-desc,"Send")]`,
    enterPinBottomSheetTitle: `~Enter PIN`,
    transactionPinTextField: `//android.view.View[@content-desc="Enter your 4 or 6 digit PIN to authorize this transfer"]//following-sibling::android.widget.EditText`,
    confirmButton: `~Confirm`,
    successfulTransactionHeader: `~Success`,
    successfulTransactionMessage: `~The transfer completed successfully.`,
    queuedTransactionHeader: `~Transaction Queued`,
    queuedTransactionMessage: `~You don't seem to currently have a network connection, your transaction has been queued, and will resume once internet connectivity is available`,
    failedTransactionErrorHeader: `~Failed`,
    okButton: `~OK`,
    increaseSendAmountErrorMessage: `//android.view.View[contains(@content-desc,"Amount too small")]`,
    transactionHistoryPageButton: `//android.view.View[@content-desc="Transfer Request"]//following-sibling::android.widget.ImageView`,
    transactionHistoryPageHeader: `~Transaction History`,
    // dynamic selectors that require phone number
    transactionHistoryListItems: (phone) => `//android.view.View[contains(@content-desc,"${phone}")]`,
    mostRecentTransactionDataForDesiredAccountNumber: (phone) => `(//android.view.View[contains(@content-desc,"${phone}")])[position()=1]`,
    backButton: `~Back`,
    processingTransactionLocator: `//android.view.View[contains(@content-desc,"PROCESSING")]`,
    notEnoughBalanceLocator: `~Not enough balance`
}

module.exports = {selector}