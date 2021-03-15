//
//  Observer.swift
//  DynamicForm
//
//  Created by Fábio Maciel de Sousa on 15/03/21.
//

import Foundation

final class Observer<Value> {
    typealias Listener = (Value?) -> Void
    
    private var listener: Listener?
    var value: Value? {
        willSet { listener?(newValue) }
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
    }
}
