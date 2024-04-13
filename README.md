# Account Activation Task And Test Class 

## Overview

This repository contains the implementation of an Account Activation System, designed to automate the creation and activation of customer accounts in Salesforce. The system ensures that when an active account record is created or activated, a default customer contact is also created if one doesn't exist. Only Account Managers are authorized to create or edit account records.

## Features

- Automatically creates a default customer contact when activating a customer account.
- Requires Account Activation Summary when activating an account.
- Maps account and contact details according to specified criteria.
- Implements  Tests for admin and standard user personas.
- Utilizes Salesforce DX for development and packaging.

## Objects Used

- **Account**
  - Active (Boolean, default false)
  - Company Email (Email field)
  - Account Activation Summary (Long Text, 3000)
- **Contact**
  - First Name
  - Last Name
  - Email
  - Phone

## Implementation Details

### UI Component

- Added quick action button to the Account detail page for activating accounts and entering Account Activation Summary.

### Mapping Details

- First Name = Account Name
- Last Name = Customer Representative
- Email = Company Email
- Phone = Phone from related account

### Automation Approach

- Logic implemented in Apex triggers and classes to handle account activation, contact creation, and data mapping.
- Account activation validation and Account Activation Summary requirement enforced in the UI.

###  Tests

- Comprehensive  tests written for admin and standard user personas to ensure functionality and adherence to business requirements.
- Followed Test-Driven Development (TDD) approach.

## Deployment

You can clone this repository and open it in Visual Studio Code. Then, connect your Visual Studio Code to your Salesforce org. After authorizing the connection, you can deploy the source code to your org directly from Visual Studio Code.

Whichever org you deploy this code to, you can perform the same tasks and utilize the functionality provided by the implementation.
