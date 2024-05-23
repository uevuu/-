//
//  NetworkAssembly.swift
//  MarketPlace
//
//  Created by Nikita Marin on 03.07.2023.
//

import Swinject

final class NetworkAssembly: Assembly {
    func assemble(container: Container) {
        container.register(LogInService.self) { _ in
            LogInService()
        }
        container.register(DaDataApiService.self) { _ in
            DaDataApiService()
        }
        container.register(SignUpService.self) { _ in
            SignUpService()
        }
        
        container.register(ProductsService.self) { _ in
            MockProductsService()
        }
        .inObjectScope(.container)
        
        container.register(CartService.self) { _ in
            MockCartService()
        }
        .inObjectScope(.container)
        
        container.register(CategoryService.self) { _ in
            CategoryService()
        }
        .inObjectScope(.container)
        
        container.register(UserInfoService.self) { _ in
            MockUserInfoService()
        }
        .inObjectScope(.container)
    }
}
