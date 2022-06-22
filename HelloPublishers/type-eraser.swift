//
//  type-eraser.swift
//  HelloPublishers
//
//  Created by Victor Chirino on 21/06/2022.
//

import UIKit
import Combine

let publisher = PassthroughSubject<Int, Never>().eraseToAnyPublisher()
