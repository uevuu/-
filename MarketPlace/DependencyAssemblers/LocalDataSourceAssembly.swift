//
//  LocalDataSourceAssembly.swift
//  MarketPlace
//
//  Created by Nikita Marin on 03.07.2023.
//

import Swinject

final class LocalDataSourceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ProductLocalDataSources.self) { _ in
            ProductLocalDataSources()
        }
        .inObjectScope(.container)
    }
}
