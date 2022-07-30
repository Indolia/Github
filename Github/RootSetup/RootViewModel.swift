//
//  RootViewModel.swift
//  Github
//
//  Created by Rishi Indolia on 30/07/22.
//

import Foundation

protocol RootViewModelProtocol: AnyObject {
    func didPush(completion: (() -> Void)?)
    func didPop(completion: (() -> Void)?)
    func didPresent(completion: (() -> Void)?)
    func didSetAsRoot(completion: (() -> Void)?)
}

// Default imp
extension RootViewModelProtocol {
    func didPush(completion: (() -> Void)?) {
        completion?()
    }
    
    func didPop(completion: (() -> Void)?) {
        completion?()
    }
    
    func didPresent(completion: (() -> Void)?) {
        completion?()
    }
    
    func didSetAsRoot(completion: (() -> Void)?) {
        completion?()
    }
}
