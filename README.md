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

Examples:

```text
# Example 1: Basic items
Input:
2 book at 12.49
1 music CD at 14.99
1 chocolate bar at 0.85

Output:
2 book: 24.98
1 music CD: 16.49
1 chocolate bar: 0.85
Sales Taxes: 1.50
Total: 42.32

# Example 2: Imported items
Input:
1 imported box of chocolates at 10.00
1 imported bottle of perfume at 47.50

Output:
1 imported box of chocolates: 10.50
1 imported bottle of perfume: 54.65
Sales Taxes: 7.65
Total: 65.15

# Example 3: Mixed items
Input:
1 imported bottle of perfume at 27.99
1 bottle of perfume at 18.99
1 packet of headache pills at 9.75
3 imported boxes of chocolates at 11.25

Output:
1 imported bottle of perfume: 32.19
1 bottle of perfume: 20.89
1 packet of headache pills: 9.75
3 imported boxes of chocolates: 35.55
Sales Taxes: 7.90
Total: 98.38
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
