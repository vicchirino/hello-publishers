import UIKit
import Combine

// prepend
print("prepend")
let numbers = (1...5).publisher
let publisher2 = (500...510).publisher

numbers
    .prepend(100,101)
    .prepend(-1,-2)
    .prepend([45,67])
    .prepend(publisher2)
    .sink {
        print($0)
}

// apend
print("apend")

numbers
    .append(99,100,12)
    .append(publisher2)
    .sink {
    print($0)
}

// switchToLatest
print("switchToLatest")

let publisherOne = PassthroughSubject<String, Never>()
let publisherTwo = PassthroughSubject<String, Never>()
let publishers = PassthroughSubject<PassthroughSubject<String, Never>, Never>()

publishers.switchToLatest().sink {
    print($0)
}

publishers.send(publisherOne)
publisherOne.send("Publisher 1 - Value 1")
publisherOne.send("Publisher 1 - Value 1")

publishers.send(publisherTwo)
publisherTwo.send("Publisher 2 - Value 1")
publisherOne.send("Publisher 1 - Value 3") // It is not catched up

let images = ["Monkey", "Monkey2", "Monkey3"]
var index = 0

func getImage() -> AnyPublisher<UIImage?, Never> {
    return Future<UIImage?, Never> { promise in
        DispatchQueue.global().asyncAfter(deadline: .now() + 3.0) {
            promise(.success(UIImage(named: images[index])))
        }
    }.map { $0 }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
}

let taps = PassthroughSubject<Void, Never>()

let subscription = taps.map { _ in getImage() }
.switchToLatest().sink {
    print($0)
}

// Monkey
taps.send()

// Monkey 2
DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
    index += 1
    taps.send()
}

// Monkey 3
DispatchQueue.main.asyncAfter(deadline: .now() + 6.5) {
    index += 1
    taps.send()
}

// merge
print("merge")

let publisherUno = PassthroughSubject<Int, Never>()
let publisherDos = PassthroughSubject<Int, Never>()

publisherUno.merge(with: publisherDos).sink {
    print($0)
}
publisherUno.send(10)
publisherUno.send(11)

publisherDos.send(12)
publisherDos.send(13)

// combineLatest
print("combineLatest")

let publisherTres = PassthroughSubject<String, Never>()

publisherUno.combineLatest(publisherTres).sink {
    print("P1: \($0), P2: \($1)")
}

publisherUno.send(1)
publisherTres.send("Hola")
publisherTres.send("Chau")

// zip
print("zip")

publisherUno.zip(publisherTres).sink {
    print("P1: \($0), P2: \($1)")
}

publisherUno.send(1)
publisherUno.send(2)
publisherTres.send("Hola")
publisherTres.send("Chau")
