# Sales Tax Calculator

## Approach

### Business Logic

Each line item is initialized as an `Item` object based on the input data. An `Item` object stores various details about the product, such as its name, quantity, base price, and whether it is tax-exempt or imported.

The `Item` class is defined in `models/item.rb`.

To calculate the tax for each item, a `TaxCalculator` class accepts an `Item` instance through its `calculate_tax` method. Using the attributes of `Item`, it determines the applicable tax rate, applies it, and handles rounding to the nearest 0.05. The `TaxCalculator` class can be found in `lib/tax_calculator.rb`.

The `TaxCalculator` is utilized by the `ReceiptGenerator`, which provides a `generate_for` method that accepts an array of `Item` instances. It iterates over the items, passing each to the `TaxCalculator`, and then compiles the string output for the receipt.

The `ReceiptGenerator` class is located in `lib/receipt_generator.rb`.

Additionally, an `ItemBuilder` class initializes an `Item` object by extracting attributes from input strings, such as `"1 imported box of chocolates at 10.00"`. This builder is used in the command-line interface for single-string input parsing.

## Challenges

The example inputs and desired outputs required parsing strings to determine tax-exempt status, which was inferred by identifying specific keywords (e.g., “book,” “chocolate,” and “pill”) in the input. This approach is functional but limited in extensibility and may result in errors for varied inputs.

Nevertheless, a command-line interface was implemented to handle string inputs, as demonstrating string-parsing skills seemed potentially relevant for the project. Additionally, due to possible ambiguities in how inputs might be formatted, an alternative command-line interface was developed, which allows users to input item attributes individually—this approach is likely to be more robust.

As I was unsure if a command line interface would meet the requirements, a basic web server was created using only Ruby’s standard library. However, I think may be somewhat excessive for the current requirements and that WEBrick has been removed from ruby.

If it is indeed outwith the scope of this please ignore it. Equally, if you would like it to work with the singe string input type, please let me know and
I would be happy to implement a textarea where the user can enter the item lines separated by a new line space then I can hook that in to the existing code.

In a real project, I would normally seek clarification on requirements before implementing multiple interfaces. However, given the external nature of the task and limited time, I opted to implement all three interfaces to cover different potential use cases.

## Dependencies

- Ruby version 3.3.5 (the application may work on older versions but has not been tested)
- RSpec ~> 3.0

## Tests

RSpec was used for testing. 

To run the tests in the application directory:

1. Run `bundle install` if this is the first setup.
2. Execute the tests with `bundle exec rspec spec`.

Tests for the provided examples can be found in `spec/single_string_spec.rb`.

## Running the Application

Navigate to the application directory.

Run `bundle install` if you have not already done so.

### Option 1: Single String Command-Line Interface

To start the single-string command-line interface, run:

```bash
ruby single_string_input.rb
```

Follow the instructions displayed in the command line.

### Option 2: Individual Attributes Command-Line Interface

To start the individual-attributes command-line interface, run:

```bash
ruby manual_input.rb
```

Follow the instructions displayed in the command line.

### Option 3: Web Server Interface

To start the web server, run:

```bash
ruby start_server.rb
```

This will start the server on port 3000 by default. To use a different port, specify it as follows:

```bash
ruby start_server.rb -p INSERT_PORT_NUMBER
```

In your browser, go to:

```url
http://localhost:3000
```

If you used a different port, replace `3000` in the URL with that port number.

On the web interface, add products, and click the "Calculate" button to view the receipt.

## Future Work

1. **Enhanced Test Coverage**: Add test coverage for the command-line and server interfaces, as these were challenging to test with RSpec due to time constraints and limited experience in testing such interfaces.

2. **Persistent Item Data**: Allow users to save items with their price, import status, and tax status. This feature would let users select items from a dropdown and only enter quantities, streamlining the input process.