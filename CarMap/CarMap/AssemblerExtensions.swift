//
//  AssemblerExtensions.swift
//  CarMap
//
//  Created by mithat samet kaskara on 26.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import Foundation
import Swinject

public func inject<TClass: NSObject>() -> TClass {
    return Assembler.sharedAssembler.resolver.resolve(TClass.self)!
}

extension Assembler {
    
    static let sharedAssembler: Assembler = {
        let container = Container()
        let assembler = Assembler([AppAssembly()], container: container)
        
        return assembler
    }()
    
}
