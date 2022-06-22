//
//  ViewController.swift
//  HelloPublishers
//
//  Created by Victor Chirino on 21/06/2022.
//

import UIKit
import Combine

enum MyError: Error {
    case subscriberError
}

class StringSubscriber: Subscriber {
    func receive(completion: Subscribers.Completion<MyError>) {
        print("Completed")
    }
    
    func receive(subscription: Subscription) {
        print("Received Subscription")
        subscription.request(.max(3)) // backpreassure. Number of item I want to receive
    }
    
    func receive(_ input: String) -> Subscribers.Demand {
        print("Received value", input)
        return .none
        // return .unlimited  return all the values.
    }
    
    typealias Input = String
    typealias Failure = MyError
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func subjectsExample() {
        let subscriber = StringSubscriber()
        let subject = PassthroughSubject<String, MyError>()
        subject.subscribe(subscriber)
        
        subject.send("A")
    }
    
    func customSubscriber() {
        let publisher = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K"].publisher
        let subscriber = StringSubscriber()
//        publisher.subscribe(subscriber)
    }
    
    func newNotificationCenterPublisher() {
        let notification = Notification.Name("MyNotification")
        let publisher = NotificationCenter.default.publisher(for: notification, object: nil)
                
        let subscription = publisher.sink { _ in
            print("Notification received")
        }
        NotificationCenter.default.post(name: notification, object: nil)
        subscription.cancel()
        NotificationCenter.default.post(name: notification, object: nil)
    }
    
    func oldNotificationCenter() {
        let notification = Notification.Name("MyNotification")
        let center = NotificationCenter.default
        let observer = center.addObserver(forName: notification, object: nil, queue: nil) { notification in
            print("Notification received: \(notification.name)")
        }
        center.post(name: notification, object: nil)
    }
    
    
}

