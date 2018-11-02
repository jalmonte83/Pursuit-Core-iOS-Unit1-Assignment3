//
//  main.swift
//  Calculator
//
//  Created by Alex Paul on 10/25/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

func mathStuffFactory(opString: String) -> (Double, Double) -> Double {
    switch opString {
    case "+":
        return {x, y in x + y }
    case "-":
        return {x, y in x - y }
    case "*":
        return {x, y in x * y }
    case "/":
        return {x, y in x / y }
    default:
        return {x, y in x + y }
    }
}

func myFilter(arr: [Int], closure: (Int) -> Bool) -> [Int] {
    var newArr = [Int]()
    for num in arr {
        if closure(num) {
            newArr.append(num)
        }
    }
    return newArr
}
func customMap (arr: [Int], closure: (Int) -> Int) -> [Int] {
    var newArr = [Int]()
    for num in arr {
        let newNum = closure(num)
        newArr.append(newNum)
    }
    return newArr
}
func myReduce(arr: [Int], closure: (Int,Int) -> Int, given: Int) -> Int{
    var currentTotal = given
    for num in arr {
        currentTotal = closure(currentTotal, num)
    }
    return currentTotal
}
var operatorSymbolsArray = ["+", "-", "/","*","?"]
var highOrderFuncs = ["map", "filter", "reduce"]
var highOrderFuncOperators = ["+","/","*","<",">"]

var calculatorInUse = true

while calculatorInUse {
    print("Choose a application, 1(simple) or 2(high order):")
    
    guard let userInputUnwrapped = readLine() else {
        continue
    }
    switch userInputUnwrapped {
    case "1":
        print("Do an Opteration or have some fun and use a (?) as operator for guessing game")
        guard let userInputUnwrapped = readLine() else {
            continue
        }
        let componentsArray = userInputUnwrapped.components(separatedBy: " ")
        guard componentsArray.count == 3 else {
            print("Too many numbers or operators")
            continue
        }
        guard let num1 = Double(componentsArray[0]) else {
            print("use a number")
            continue
        }
        guard let num2 = Double(componentsArray[2]) else {
            print("use a number")
            continue
        }
        guard operatorSymbolsArray.contains(componentsArray[1]) else {
            print("use a correct operator")
            continue
        }
        switch componentsArray[1] {
        case "+":
            let answer = mathStuffFactory(opString: "+")(num1,num2)
            print(answer)
        case "-":
            let answer = mathStuffFactory(opString: "-")(num1,num2)
            print(answer)
        case "/":
            let answer = mathStuffFactory(opString: "/")(num1,num2)
            print(answer)
        case "*":
            let answer = mathStuffFactory(opString: "*")(num1,num2)
            print(answer)
        case "?":
            let randomNumber = Int.random(in: 0...3)
            var randomOperator = ""
            switch randomNumber {
            case 0:
                randomOperator = "+"
            case 1:
                randomOperator = "-"
            case 2:
                randomOperator = "/"
            case 3:
                randomOperator = "*"
            default:
                print("Pick")
            }
            let answer = mathStuffFactory(opString: randomOperator)(num1,num2)
            print(answer)
            print("Guess the operator")
            guard let userInput = readLine() else {
                continue
                
            }
            if userInput == randomOperator {
                print("Correct!")
            } else {
                print("wrong answer!")
            }
            
            
        default:
            print("huh!?")
        }
        
    case "2":
        print("choose a high order function from (filter, map, reduce) e.g filter 1,5,2,7,3,4 by  < 4")
        guard let userInputUnwrapped = readLine() else {
            continue
        }
        let componentsArray = userInputUnwrapped.components(separatedBy: " ")
        guard componentsArray.count == 5 else {
            print("That does not compute. write it out like:filter 1,5,2,7,3,4 by  < 4)")
            continue
        }
        guard highOrderFuncs.contains(componentsArray[0]) else {
            print("not valid function. try again.")
            continue
        }
        let stringNums = componentsArray[1].components(separatedBy: ",")
        var intNums = [Int]()
        for stringNum in stringNums {
            if let num = Int(stringNum) {
                intNums.append(num)
            }
        }
        guard componentsArray[2] == "by" else {
            print("Please enter the word (by)")
            continue
        }
        guard highOrderFuncOperators.contains(componentsArray[3]) else {
            print("use a valid oparation")
            continue
        }
        
        guard let userNum = Int(componentsArray[4]) else {
            print("write a valid nmuber")
            continue
        }
        let userOperator = componentsArray[3]
        let userHighOrderWord = componentsArray[0]
        switch userHighOrderWord {
        case "filter":
            if userOperator == "<" {
                print(myFilter(arr: intNums, closure: { (num) -> Bool in
                    return num < userNum
                }))
                
            }
            else if  userOperator == ">" {
                print(myFilter(arr: intNums, closure: { (num) -> Bool in
                    return num > userNum
                }))
            } else {
                print("not vaild Operator, please use either < or > ")
            }
        case "map":
            if userOperator == "*" {
                print(customMap(arr: intNums, closure: { (num) -> Int in
                    return num * userNum
                })) }
            else if userOperator == "/" {
                print(customMap(arr: intNums, closure: { (num) -> Int in
                    return num / userNum
                }))
                }
        case "reduce":
            if userOperator == "+" {
                print(myReduce(arr: intNums, closure: { (num1, num2) -> Int in
                    return num1 + num2
                }, given: userNum))
            }
            else if  userOperator == "*" {
                print(myReduce(arr: intNums, closure: { (num1, num2) -> Int in
                    return num1 * num2
                }, given: userNum)) }
        default:
            print("use valid Word e.g (map, filter or reduce)")
       
        }
        
    default:
        print("invalid entry")
    }
}
