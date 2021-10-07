//
//  Dynamic.swift
//  Crowded
//
//  Created by Blain Ellis on 04/10/2021.
//

import Foundation

final class Dynamic<Value> {
    //Each Dynamic can have a Listener that Dynamic notifies when the value changes.
    typealias Listener = (Value) -> Void
    var listener: Listener?
    //Dynamic has a generic type value. The didSet property observer detects any changes and notifies Listener of any value update.
    var value: Value {
        didSet {
            listener?(value)
        }
    }
    //The initializer sets Dynamic's initial value.
    init(_ value: Value) {
        self.value = value
    }
    //When a Listener calls bind(listener:) on Dynamic, it becomes Listener and immediately gets notified of the Dynamic's current value.
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
