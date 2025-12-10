# Resilient Payments App (Germany – Offline-First Architecture)

This project is a **resilient payment application prototype** built as a technical assessment.

The primary goal of this app is **not UI polish**, but **guaranteeing data integrity, correctness, and user capability under unstable or unavailable network conditions**, such as:

- U-Bahn / S-Bahn tunnels
- Rural **Funklöcher**
- Packet loss and intermittent connectivity

The application follows **offline-first principles** and ensures that **no valid-looking transaction can violate business rules**, regardless of network state.

---

## Core Objectives Addressed

- **Resilient Architecture** — App functions correctly with poor or zero connectivity
- **Strong Data Consistency** — Clear separation between local truth and server truth
- **Defensive Business Logic** — Prevents overdrafts, duplicates, and replay attacks
- **Clean Architecture** — Data → Domain → Presentation separation
- **Test Coverage** — Business logic and critical UI flows are tested

---

## Architecture Overview

Detailed architectural decisions, trade-offs, and resilience strategies
are documented in **ARCHITECTURE.md**.


Each layer has **one responsibility** and no upward dependency leaks.

---

##  Tech Stack & Rationale

### Flutter
- Cross-platform, deterministic rendering
- Strong test ecosystem (unit, widget, integration)

---

### **State Management: BLoC**
**Why BLoC?**
- Explicit state transitions
- Fully testable business flows
- Predictable event → state pipeline (critical for money movement)
- Prevents hidden side effects during network drops

---

### **Local Persistence: Drift**
**Why Drift?**
- Strongly typed SQL (compile-time guarantees)
- Transactional writes (ACID)
- Ideal for **ledger-style persistence**
- Easy to model:
    - Pending transactions
    - Confirmed transactions
    - Retry state
    - Sync metadata

---

### **Secure Storage: get_secure_storage**
**Why Secure Storage?**
- Holds sensitive data (user keys, session tokens)
- OS-level encryption (Keychain / Keystore)
- Prevents plaintext balance/session leakage

---

### **Network Awareness: connectivity_plus**
**Why Connectivity Monitoring?**
- Detects transition between:
    - Offline
    - Degraded network
    - Good network
- Triggers sync logic only when safe
- Prevents wasteful retries and inconsistent writes

---

## Resilience Strategy (Offline-First)

### 1. **Local Truth Is Always Primary**
- All payments are **written locally first**
- UI always reflects **local state**, not network guesses
- Server communication is **eventual**

---

### 2. Transaction Queueing

When the user initiates a transfer:
1. Balance is checked **locally**
2. Transaction is inserted into local DB with status: PENDING
3. UI reflects updated “effective balance”
4. Sync is deferred until connectivity is usable

---

### 3. Defensive Rules (Always Enforced Locally)

Prevents:
- Overspending
- Duplicate submissions
- Replay after app restarts
- UI-confirmed payments without backing state

No transaction can be executed unless:
- Local balance allows it
- Transaction hasn’t been sent already
- It passes domain validation rules

---

### 4. Sync & Retry Logic

- Connectivity listener triggers retry
- Pending transactions are synced FIFO
- Server ACK transitions state to: Completed


No optimistic deletion. Ever.

---

## Balance Consistency Model

**Displayed Balance = Effective Balance**
Effective Balance =
Server Balance
− Pending Outgoing Transactions

Pending Incoming Transactions


This guarantees:
- UI never lies
- Users never overspend
- Network drops do not corrupt state

---

## Tests

### Unit Tests
- Banking service logic
- Queue processing
- Balance calculation
- Retry logic

### Widget Tests
- Core money transfer flow
- Offline submission behavior
- State restoration on rebuild

### (Optional)
- Integration tests for full online/offline lifecycle

---

## 🚀 How to Run

```bash
flutter pub get
flutter run





