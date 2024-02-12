# Debit Cards API

This is a simple API for managing debit cards. It allows you to create debit cards and perform reload and checkout operations on them.

## Setup

### Navigate to the project directory and install the dependencies:

```bash
cd debit-cards-api
bundle install
```

### Create database structure:

```bash
rails db:drop db:create db:migrate db:seed
```

### Start the server:

```bash
bin/dev
```

## API Endpoints

### Create a Debit Card

URL: /api/debit_cards
Method: POST
Request Body:

```json
{
  "debit_card": {
    "name": "credit card",
    "balance": 100
  }
}
```

Response: Returns the created debit card object

### Reload a Debit Card

:id = credit_card_number
URL: /api/debit_cards/:id/reload
Method: PATCH
Request Body:

```json
{
  "amount": 100
}
```

Response: Returns the updated debit card object.

### Response: Returns the updated debit card object.

:id = credit_card_number
URL: /api/debit_cards/:id/checkout
Method: PATCH
Request Body:

```json
{
  "amount": 50
}
```

Response: Returns the updated debit card object.
