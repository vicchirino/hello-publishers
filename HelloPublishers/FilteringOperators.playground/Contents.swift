import UIKit
import Combine


// filter
print("filter")

let numbers = (1...10).publisher

numbers.filter { $0 % 2 == 0 }
.sink {
    print($0)
}

// removeDuplicates remove only the duplicate that is in secuence
print("removeDuplicates")

let words = "apple apple fruit apple mango banana watermelon banana".components(separatedBy: " ").publisher

words
    .removeDuplicates()
    .sink {
    print($0)
}

// compactMap remove nil/undefined values
print("compactMap")

let strings = ["a", "1.25", "b", "3.45", "6.7"].publisher.compactMap{ Float($0) }.sink {
    print($0)
}

// ignoreOutput
print("ignoreOutput")
let numbersRange = (1...5000).publisher

numbersRange
    .ignoreOutput()
    .sink(receiveCompletion: { print($0) }, receiveValue: {print($0)})


// first
print("first")
let newNumbers = (1...9).publisher

newNumbers.first(where: {$0 % 2 == 0})
    .sink {
        print($0)
    }

// last
print("last")
newNumbers.last(where: {$0 % 2 == 0}).sink {
    print($0)
}

// dropFirst
print("dropFirst")

numbers.dropFirst(8).sink {
    print($0)
}

// dropWhile

print("dropWhile")
numbers.drop(while: { $0 % 3 != 0} ).sink {
    print($0)
}

// dropUntilOutputForm
print("dropUntilOutputForm")
let isReady = PassthroughSubject<Void, Never>()
let taps = PassthroughSubject<Int, Never>()

taps.drop(untilOutputFrom: isReady).sink {
    print($0)
}

(1...10).forEach { n in
    taps.send(n)
    if n == 3 {
        isReady.send()
    }
}


// prefix
print("prefix")

numbers.prefix(2).sink {
    print($0)
}

numbers.prefix(while: { $0 < 3 })
    .sink {
        print($0)
    }

/*
 Challenge: Filter all the things
 
 Create an example that publishes a collection of numbers from 1 trough 100, and use filtering
    operators to:
 
 1. Skip the first 50 values emitted by the upstream publisher.
 2. Take the next 20 values after those first 50 values.
 3. Only take even numbers.
 
 The output of your example should produce the following numbers, one per line:
 52 54 56 58 60 62 64 66 68 70
 */

print("Challenge")

let example = (1...100).publisher

example
    .dropFirst(50)
    .prefix(20)
    .filter { $0 % 2 == 0}
    .sink {
        print($0)
}
