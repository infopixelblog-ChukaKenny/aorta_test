# Resilient Euro Transfer System — QA Automation Test Suite

> **Assessment Submission** | Automated Integration Tests using Appium + Sauce Labs  
> Candidate: Chukwuka Okonkwo | Submitted: Monday, 2nd February 2026

---

## Table of Contents

1. [Project Overview](#project-overview)
2. [Tech Stack & Tooling](#tech-stack--tooling)
3. [Repository Structure](#repository-structure)
4. [How to Run Tests Locally](#how-to-run-tests-locally)
5. [CI/CD Integration Guide](#cicd-integration-guide)
6. [Test Strategy & Reasoning](#test-strategy--reasoning)
7. [Coverage Summary](#coverage-summary)
8. [Known Limitations](#known-limitations)

---

## Project Overview

This repository contains the automated integration test suite for the **Resilient Euro Transfer System** — a Flutter-based payment application designed for the German market. The app handles offline-first transactions, queue-based retries, and fraud prevention logic.

The test suite exercises real end-to-end user flows using **Appium with JavaScript (WebdriverIO)**, executed on real/virtual devices via **Sauce Labs**.

> Source application repository: [https://github.com/TuleSimon/aorta_test](https://github.com/TuleSimon/aorta_test)

---

## Tech Stack & Tooling

| Tool | Role |
|---|---|
| **Appium (v2.x)** | Mobile automation framework for driving the Flutter app |
| **WebdriverIO** | JavaScript test runner and Appium client |
| **Sauce Labs** | Cloud device farm for running tests on real/virtual Android devices |
| **GitHub Actions** | CI/CD pipeline for automated test execution on push/PR |
| **Page Object Model (POM)** | Design pattern for scalable, maintainable test structure |

---

## Repository Structure

```
└── .aorta_test/
          │ 
          │ 
          ├── .github/
          │   └── workflows/
          │       └── yamlscript.yml          # GitHub Actions CI/CD workflow
          │
          │
          └── tests/
              └── appium_saucelabs_cicd_integrationTest/
                                  │
                                  │
                                  ├── selectors/
                                  │      └──  selector.js
                                  │
                                  ├── test/
                                  │     ├── specs/
                                  │     │      └── aorta.js
                                  │     │
                                  │     └── pageObjects/
                                  │             ├── HomePage.js
                                  │             ├── TransferPage.js
                                  │             └── TransactionHistoryPage.js
                                  │ 
                                  │ 
                                  ├── utils/
                                  │     └──  fixtures.js
                                  │
                                  │
                                  ├── wdio.conf.js                    # Appium + Sauce Labs configuration
                                  ├── package.json
                                  └── README.md
```

---

## How to Run Tests Locally

### Prerequisites

Ensure the following are installed on your machine:

- **Node.js** v18 or higher with `NODE_HOME` environment variable set
- **Java JDK 11+** (required by Appium) with `JAVA_HOME` environment variable set
- **Android Studio & SDK** with `ANDROID_HOME` environment variable set
- **Appium 2.x** — install globally: `npm install -g appium`
- **Appium UiAutomator2 Driver** — `appium driver install uiautomator2`
- A Sauce Labs account with `SAUCE_USERNAME` and `SAUCE_ACCESS_KEY` set as environment variables

### Step 1 — Clone and install dependencies

```bash
git clone https://github.com/<your-username>/aorta_test_suite
cd aorta_test_suite
npm install
```

### Step 2 — Setup appium test file in the desired directory

```bash
npm wdio run
```

### Step 3 — Build the Flutter app APK

Clone the source application and build the debug APK:

```bash
git clone https://github.com/TuleSimon/aorta_test
cd aorta_test
flutter pub get
flutter build apk --debug
# APK output: build/app/outputs/flutter-apk/app-debug.apk
```

### Step 4 — Upload APK to Sauce Labs storage

### Step 5 — Copy desired capabilities and paste it in the the "wdio.conf."js" file in the "appium_saucelabs_cicd_integrationTest/" folder

### Step 6 — Set environment variables

```bash
export SAUCE_USERNAME=your_sauce_username
export SAUCE_ACCESS_KEY=your_sauce_access_key
```

### Step 5 — Run the test suite

```bash
npx wdio run wdio.conf.js --spec tests/integration/specs/aorta.js
```

### Viewing Test Results

After execution, test recordings and logs are available in your Sauce Labs dashboard at [app.saucelabs.com](https://app.saucelabs.com). Each test run generates a video replay, device logs, and a pass/fail report.

---

## CI/CD Integration Guide

The `.github/workflows/yamlscript.yml` file in this repository defines a GitHub Actions workflow that automatically triggers on every `push` or `pull_request` to the `main` branch.

### How the Pipeline Works

1. **Checkout** — The repository code is checked out.
2. **Set up Java & Flutter** — Java 17 and Flutter are configured using official GitHub Actions.
3. **Install Node dependencies** — `npm install` installs WebdriverIO and all test dependencies.
4. **Build Flutter APK** — The app is compiled into a debug APK from the source repository.
5. **Upload APK to Sauce Labs** — The APK is uploaded to Sauce Labs app storage via their REST API.
6. **Run integration tests** — `npm test` executes the full Appium test suite against Sauce Labs virtual/real devices.
7. **Upload test artifacts** — Test results and logs are uploaded as GitHub Actions artifacts for post-run review.

### Workflow Triggers

```yaml
on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]
```

Tests run automatically whenever code is pushed to `main` or a PR targeting `main` is opened. This ensures that no regression is merged without passing the integration suite.

### Required GitHub Secrets

Add the following secrets to your repository under **Settings → Secrets and variables → Actions**:

| Secret Name | Description |
|---|---|
| `SAUCE_USERNAME` | Your Sauce Labs username |
| `SAUCE_ACCESS_KEY` | Your Sauce Labs access key |

### Workflow File Location

```
.github/workflows/yamlscript.yml
```

All dependencies (Node.js, Flutter, Java, Appium drivers) are installed within the workflow itself — no additional setup is required on the runner. The workflow uses `ubuntu-latest` and relies entirely on cloud-based Sauce Labs devices, so no local Android emulator or physical device is needed in CI.

---



## Test Strategy & Reasoning

### Why Appium + Sauce Labs?

Before settling on this approach, two other options were evaluated:

**Flutter integration_test + Firebase Test Lab** was explored first. However, Flutter's `integration_test` package relies on widget finders (text values, key IDs, icons) rather than standard accessibility locators such as XPath or content descriptions. This made targeting empty input fields and dynamically rendered elements unreliable and unscalable. Firebase Test Lab was also considered, but its free tier is capped at 5 test runs per day regardless of duration — making iterative development and debugging impractical. Firebase also does not support direct Appium integration, which removed it from consideration.

**Appium + AWS Device Farm** was the next candidate. AWS Device Farm offers 1,000 free automation minutes and is well-integrated with Appium. It was a strong contender, but a technical issue with the AWS account at the time of the assessment prevented its use within the deadline.

**Appium + Sauce Labs** was ultimately chosen for the following reasons:

- Appium supports a wide range of locator strategies (XPath, accessibility ID, content description, UIAutomator) and encourages element chaining, making it robust against UI changes.
- Appium scripts are written in JavaScript, which is expressive and well-suited to complex conditional test logic such as retry verification and balance rollback checks.
- Sauce Labs is straightforward to integrate with both Appium and GitHub Actions workflows.
- Each test run on Sauce Labs generates a full video recording, which is invaluable for debugging flaky or failing tests.
- At $50/month for their entry paid tier, Sauce Labs is cost-accessible for small teams and assessments.



### What Was Prioritised

Four of the five core user flows described in the assessment brief were automated as the primary deliverable:

1. **Happy Path** — Successful transfer with balance deduction and "Completed" status.
2. **Offline Queue & Auto-Sync** — Network disabled mid-flow, transaction queued as "Pending", auto-retry triggered on reconnection, status resolves to "Completed".
3. **Anti-Fraud Guard** — Effective balance logic (server balance minus pending sum) correctly blocks a transfer that would exceed available funds.
4. **App Restart Persistence** — Transaction queued, app force-killed, app relaunched, queue confirmed to survive process death.


The **Page Object Model (POM)** design pattern was applied throughout to keep test logic decoupled from element selectors, making the suite easier to maintain and extend.

A working **CI/CD pipeline** via GitHub Actions was also prioritised as a key deliverable alongside the tests themselves.




### What Would Be Added With More Time

- An **Allure or HTML reporter** integrated into the Sauce Labs workflow to produce rich, shareable test reports with screenshots and step-level detail.
- Expanded coverage of the anti-fraud guard and offline queue scenarios with more edge cases — for example, queuing multiple transactions while offline, verifying strict FIFO processing order, and confirming max retry limits (3–5 attempts) are respected.
- A fully configured **AWS Device Farm** CI/CD path as a parallel pipeline option, providing cost flexibility and redundancy.
- Re-exploration of the **Flutter Inspector + Firebase module** combination, which may offer tighter integration with Flutter's widget tree if locator limitations can be worked around.
- Investigation of **direct Appium-to-Firebase Test Lab** connectivity

---



## Coverage Summary

| Scenario | Status | Notes |
|---|---|---|
| Happy Path | ✅ Covered | — |
| Offline Queue & Auto-Sync | ✅ Covered | Network toggled via Appium commands |
| App Restart Persistence | ✅ Covered | App terminated and relaunched via Appium |
| Anti-Fraud Guard (effective balance block) | ✅ Covered | Queued transaction reduces effective balance |

---



## Known Limitations

**iOS is not covered.** Tests target Android only. The Appium + Sauce Labs setup can be extended to iOS with a separate capability profile, but this was not prioritised within the assessment timeframe.

**Sauce Labs free tier constraints** mean that parallel test execution is limited. In a production CI/CD setup, a paid concurrency tier would be recommended to keep pipeline run times under 5 minutes.

---


