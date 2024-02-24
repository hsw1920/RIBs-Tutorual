//
//  AppRootBuilder.swift
//  RIBs-Tutorial1
//
//  Created by 홍승완 on 2024/02/24.
//

import RIBs
import UIKit

protocol AppRootDependency: Dependency {
    var loginRepository: LoginRepository { get }
    var window: UIWindow { get }
}

final class AppRootComponent: Component<AppRootDependency>, LoggedInDependency, LoggedOutDependency {
    lazy var loggedInBuildable: LoggedInBuildable = {
        return LoggedInBuilder(dependency: self)
    }()
    
    lazy var loggedOutBuildable: LoggedOutBuildable = {
        return LoggedOutBuilder(dependency: self)
    }()

    override init(
        dependency: AppRootDependency
    ) {
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol AppRootBuildable: Buildable {
    func build() -> AppRootRouting
}

final class AppRootBuilder: Builder<AppRootDependency>, AppRootBuildable {
    
    override init(dependency: AppRootDependency) {
        super.init(dependency: dependency)
    }

    /// Launch에서는 LaunchRouting을 사용함.
    /// build 메서드에 리스너가 없고 리턴 타입도 다름
    func build() -> AppRootRouting {
        
        let component = AppRootComponent(
            dependency: dependency
        )
        
        let interactor = AppRootInteractor(loginRepository: dependency.loginRepository)
        
        let loggedInBuilder = LoggedInBuilder(dependency: component)
        let loggedOutBuilder = LoggedOutBuilder(dependency: component)
        
        return AppRootRouter(
            interactor: interactor,
            loggedInBuilder: loggedInBuilder,
            loggedOutBuilder: loggedOutBuilder, 
            window: dependency.window
        )
    }
}
