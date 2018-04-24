//
//  Observable.swift
//  WasteRecon
//
//  Created by Tran Cong Thanh on 24/04/2018.
//  Copyright © 2018 WasteRecon. All rights reserved.
//

protocol Observable {
    var observers: [Observer] {get}
    
    func register(newObserver: Observer)
    func unregister(oldObserver: Observer)
    func notifyObservers()
}
