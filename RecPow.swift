//
//  RecPow.swift
//
//  Created by Zak Goneau
//  Created on 2025-04-29
//  Version 1.0
//  Copyright (c) 2025 Zak Goneau. All rights reserved.
//
//  This program uses recursion to calculate the value of a number at the power of something.

// Import library
import Foundation

// Define main function
func main() {

    // Introduce program
    print("This program uses recursion to find the value of the a number to the power of an exponent .")
    print("The output will be displayed in the output.txt file")

    // Assign file names
    let inputFile = "input.txt"
    let outputFile = "output.txt"

    // Declare result
    var powerResult = 0

    // Declare array to hold input
    var inputArray = [String]()

    // Initialize output string
    var outputStr = ""

    // Try to read the input file
    guard let input = FileHandle(forReadingAtPath: inputFile) else {

        // Tell user input file couldn't be opened
        print("Couldn't open input file")

        // Exit function
        exit(1)
    }

    // Try to read the output file
    guard let output = FileHandle(forWritingAtPath: outputFile) else {

        // Tell user output file couldn't be opened
        print("Couldn't open output file")

        // Exit function
        exit(1)
    }

    // Read lines from input file
    let inputData = input.readDataToEndOfFile()

    // Convert data to string
    guard let inputString = String(data: inputData, encoding: .utf8) else {

        // Tell user couldn't convert data to string
        print("Couldn't convert data to string")

        // Exit function
        exit(1)
    }

    // Split string by new lines
    let lines = inputString.components(separatedBy: "\n")

    // Initialize position in file
    var position = 0

    // Loop through lines
    while position < lines.count {
        // Split line by spaces and assign to array
        inputArray = lines[position].components(separatedBy: " ")

        // Check if array length is 2
        if (inputArray.count == 2) {
            // Try converting first index to integer
            guard let base = Int(inputArray[0]) else {

                // Add to output string that the base is not an integer
                outputStr += "\(inputArray[0]) is not an integer\n"

                // Exit guard and continue to next line
                position += 1
                continue
            }

            // Try converting second index to integer
            guard let exponent = Int(inputArray[1]) else {

                // Add to output string that exponent is not an integer
                outputStr += "\(inputArray[1]) is not a positive integer\n"

                // Exit guard and continue to next line
                position += 1
                continue
            }

            // Check if exponent is negative
            if (exponent < 0) {
                // Add to output string that exponent is negative
                outputStr += "\(inputArray[1]) is not a positive integer\n"

                // Exit guard and continue to next line
                position += 1
                continue

            // Otherwise, the exponent is valid
            } else {
                // Call function to find value raised to a power
                powerResult = recPow(base: base, exponent: exponent)

                // Write the value to output string
                outputStr += "\(base) ^ \(exponent) is \(powerResult)\n"
            }

        } else {
            // Add to output string that there isn't two integers
            outputStr += "There are not two integers on this line.\n"

            // Exit guard & continue to next line
            position += 1
            continue
        }

        // Increment the position
        position += 1
    }

    // Write to output file
    output.write(outputStr.data(using: .utf8)!)

    // Close files
    output.closeFile()
    input.closeFile()
}

// Define function to find value at a raised to a power
func recPow(base: Int, exponent: Int) -> Int {

    // Base case, check if exponent is 0
    if (exponent == 0) {
        // Return 1
        return 1

    // Otherwise, perform recursion and find value
    } else {
        // Call function recursively
        return base * recPow(base: base, exponent: exponent - 1)
    }
}

// Call main
main()