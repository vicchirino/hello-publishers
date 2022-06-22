import UIKit
import Combine

var subscription3: AnyCancellable?

guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
  fatalError("Invalid URL")
}

// share

let subject = PassthroughSubject<Data, URLError>()
//let request = URLSession.shared.dataTaskPublisher(for: url).map(\.data).print().share()  downloading only 1 time the data

let request = URLSession.shared.dataTaskPublisher(for: url).map(\.data).print().multicast(subject: subject)

let subscription = request.sink(receiveCompletion: { _ in }) {
    print("Subscription number 1")
    print($0)
}

let subscription2 = request.sink(receiveCompletion: { _ in }) {
    print("Subscription number 2")
    print($0)
}

subscription3 = request.sink(receiveCompletion: { _ in }, receiveValue: {
    print("Subscription number 3")
    print($0)
})

request.connect()
//subject.send(Data())



