class helperFunctions {

    constructor(){
        this.packageName = "com.simon.aorta"
    }

get availableBalanceLocator(){
    return $(`//android.view.View[@content-desc="Available Balance"]/following-sibling::*[contains(@content-desc,"€")]`)
}    

async testHooks(){

    beforeEach(async ()=>{

        // //Terminate the app 
        // await driver.terminateApp(this.packageName)
        // console.log(`Re-terminating.. the app`)

        //Activate the app
        await driver.activateApp(this.packageName)
        console.log(`Starting App...`)

        // Toggle On Wifi mode 
        await driver.setNetworkConnection(2)

        //Wait for the app to load
        await this.availableBalanceLocator.waitForExist({timeout:30000,timeoutMsg:"The App did not load on time"})
        console.log(`User is on the app interface`)

    })

    afterEach(async()=>{

        //Terminate the app 
        await driver.terminateApp(this.packageName)
         console.log(`Terminating the app..`)

    })
    
}

async toggleOffNetworkConnection(){

    // Toggle On airplane mode 
    await driver.setNetworkConnection(1)
    console.log(`Airplane mode on.. \n Network connection toggled off`)
    // Static Wait
    await browser.pause(1500)

}

async toggleOnNetworkConnection(){

    // Toggle On Wifi mode 
    await driver.setNetworkConnection(2)
    console.log(`Wifi mode on.. \n Network connection toggled on`)
    // Static Wait
    await browser.pause(3000)

}


// restart the app (terminate then activate)
async restartApp(){
    // Terminate app to simulate a user force-quit
    await driver.terminateApp(this.packageName)
    console.log(`App terminated to simulate restart`)
    await browser.pause(1000)

    // Activate app again
    await driver.activateApp(this.packageName)
    console.log(`App re-activated`)

    // Small pause to let UI settle
    await browser.pause(1000)

}


}

module.exports = new helperFunctions()
