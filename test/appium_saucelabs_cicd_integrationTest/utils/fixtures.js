const data = {
    "phoneNumber":"08142101522",
    "pin":"1111",
    "transactionHistoryState_success":"completed",
    "transactionHistoryState_failure":"failed",
    "transactionHistoryState_queued":"pending",
    "addThisToTheAvailableBalance": 10.00,
    "sendType_specific":"specific",
    "sendType_random":"random",
    "sendType_overdraft":"overdraft",
    "specificAmount": 1.50,
    // Additional fixtures for new scenarios
    "specificAmount_serverRejection": 9999,
    "sendType_persist": "random"
}

module.exports = {data}