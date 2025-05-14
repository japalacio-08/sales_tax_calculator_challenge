# Sales Tax Calculator

A Ruby application that calculates sales tax for shopping baskets and generates receipts. The application handles different product categories, imported goods, and applies appropriate tax rules.

## Problem Link

[Sales Tax Calculator Problem](https://gist.github.com/safplatform/792314da6b54346594432f30d5868f36)

## Prerequisites

- Ruby 3.3.0 (as specified in `.tool-versions`)
- Bundler

## Setup

1. Install Ruby 3.3.0 (if not already installed)

   ```bash
   rbenv install 3.3.0  # if using rbenv
   # or
   rvm install 3.3.0    # if using rvm
   # or
   asdf install ruby 3.3.0 # if using asdf
   ```

2. Install dependencies

   ```bash
   bundle install
   ```

## Usage

The application processes shopping basket inputs and generates receipts with calculated taxes. You can run it in two ways:

1. Using input files:

   ```bash
   ruby bin/checkout.rb inputs/input_1.txt
   # or
   ruby bin/checkout.rb inputs/input_2.txt
   # or
   ruby bin/checkout.rb inputs/input_3.txt
   ```

2. Using pipe input:

   ```bash
   cat inputs/input_1.txt | ruby bin/checkout.rb
   ```

### Input Format

Each line in the input should follow this format:

```text
<quantity> <product name> at <price>
```

Example:

```text
2 book at 12.49
1 music CD at 14.99
1 chocolate bar at 0.85
```

## Assumptions

1. **Product Categories**: The application automatically categorizes products based on keywords:
   - Books: Contains the word "book"
   - Food: Contains "chocolate" or "chocolates"
   - Medical: Contains "pills"
   - Other: Everything else

2. **Tax Rules**:
   - Basic sales tax: 10% on all goods except books, food, and medical products
   - Import duty: 5% on all imported goods
   - Both taxes are rounded up to the nearest 0.05

3. **Input Format**:
   - Each line must follow the exact format: `<quantity> <product name> at <price>`
   - Product names containing "imported" are considered imported goods
   - Prices should be in decimal format (e.g., 12.49)
   - Quantities should be positive integers

4. **Output Format**:
   - Receipt shows each item with its quantity and total price
   - Sales taxes are shown per item
   - Total amount and total taxes are shown at the bottom

## Testing

Run the test suite using:

```bash
bundle exec rspec
```

## Code Quality

The project uses RuboCop for code style enforcement. Run the linter with:

```bash
bundle exec rubocop
```
