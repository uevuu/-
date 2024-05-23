//
//  ServiceLocator.swift
//  MarketPlace
//
//  Created by Nikita Marin on 03.07.2023.
//

import Swinject

// MARK: - ServiceLocator
final class ServiceLocator {
    private var container: Container
    private var assembler: Assembler
    
    init() {
        self.container = Container()
        self.assembler = Assembler(
            [
                NetworkAssembly(),
                CoreDataAssembly(),
                LocalDataSourceAssembly()
            ],
            container: container
        )
    }
    
    func getResolver() -> Resolver {
        return assembler.resolver
    }
}
