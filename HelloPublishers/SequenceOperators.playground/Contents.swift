import UIKit
import Combine

// min
print("min")

let publisher = [1, -45, 10, 100, -32].publisher

publisher.min().sink {
    print($0)
}

// max
print("max")

publisher.max().sink {
    print($0)
}

// first & last
print("first & last")

let publisher2 = ["A", "B", "C", "D"].publisher

publisher2.first().sink {
    print($0)
}

publisher2.first(where: { "Cat".contains($0) }).sink {
    print($0)
}


publisher2.last().sink {
    print($0)
}

publisher2.last(where: { "Cat".contains($0) }).sink {
    print($0)
}

// output
print("output")

publisher2.output(at: 2).sink {
    print($0)
}

publisher2.output(in: (0...2)).sink {
    print($0)
}

// count
print("count")

publisher2.count().sink {
    print($0)
}

let publisherTest = PassthroughSubject<Int, Never>()

publisherTest.count().sink {
    print($0)
}

publisherTest.send(10)
publisherTest.send(10)
publisherTest.send(10)
publisherTest.send(10)
publisherTest.send(10)
publisherTest.send(completion: .finished)

// contains
print("contains")

publisher2.contains("C").sink {
    print($0)
}

// allSatisfy

let publisher3 = [1,2,3,4,5,6,7,8].publisher

publisher3.allSatisfy { $0 % 2 == 0 }.sink {
    print($0)
}

publisher3.allSatisfy { $0 > 0 }.sink {
    print($0)
}

// reduce
print("reduce")

publisher3.reduce(0) { $0 + $1 }.sink {
    print($0)
}
