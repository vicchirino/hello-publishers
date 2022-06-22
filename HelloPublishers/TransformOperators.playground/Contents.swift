import UIKit
import Combine

let lettersArray = ["A", "B", "C", "D", "E"]

lettersArray.publisher.sink {
    print($0)
}

// Collect

lettersArray.publisher.collect(3).sink {
    print($0)
}


// Map

let formatter = NumberFormatter()
formatter.numberStyle = .spellOut

let numberArray = [123, 45, 67]

numberArray.publisher.map {
    formatter.string(from: NSNumber(integerLiteral: $0)) ?? ""
}.sink {
    print($0)
}

// Map KeyPath

struct Point {
    let x: Int
    let y: Int
}

let publisher = PassthroughSubject<Point, Never>()

publisher.map(\.x, \.y).sink { x, y in
    print("x is \(x) and y is \(y)")
}

publisher.send(Point(x: 2, y: 10))

// flatMap

struct School {
    let name: String
    let noOfStudent: CurrentValueSubject<Int, Never>
    
    init(name: String, noOfStudent: Int) {
        self.name = name
        self.noOfStudent = CurrentValueSubject(noOfStudent)
    }
}

let citySchool = School(name: "Manuel Belgrano", noOfStudent: 100)
let school = CurrentValueSubject<School, Never>(citySchool)
school
    .flatMap {
        $0.noOfStudent
    }
    .sink {
    print($0)
}

let townSchool = School(name: "Normal 3", noOfStudent: 45)
school.value = townSchool
citySchool.noOfStudent.value += 1
townSchool.noOfStudent.value += 10

// replaceNil

["A", "B", nil, "C"].publisher.replaceNil(with: "*")
    .map { $0! }
    .sink {
        print($0)
    }


// replaceEmpty

let empty = Empty<Int, Never>()

empty
    .replaceEmpty(with: 1)
    .sink(receiveCompletion: {  print($0)
}, receiveValue: { print($0) })

// scan

let numberPublisher = (1...10).publisher

numberPublisher.scan([]) { numbers, value -> [Int] in
    numbers + [value]
}.sink {
    print($0)
}
