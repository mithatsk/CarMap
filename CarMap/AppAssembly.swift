//
//  AppAssembly.swift
//  CarMap
//
//  Created by mithat samet kaskara on 26.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import Foundation
import Swinject

final class AppAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(LoadingIndicatorPresenter.self) { _ in LoadingIndicatorPresenter() }.inObjectScope(.container)
        container.register(BaseService.self) { _ in BaseService() }.inObjectScope(.container)
        container.register(Localization.self) { _ in Localization() }.inObjectScope(.container)
    }
    
}
