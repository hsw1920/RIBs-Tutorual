//
//  AppRootBuilder.swift
//  RIBs-Tutorial1
//
//  Created by 홍승완 on 2024/02/24.
//

import RIBs

protocol AppRootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class AppRootComponent: Component<AppRootDependency>, LoggedInDependency, LoggedOutDependency {
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol AppRootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class AppRootBuilder: Builder<AppRootDependency>, AppRootBuildable {

    override init(dependency: AppRootDependency) {
        super.init(dependency: dependency)
    }
    
    func build() -> LaunchRouting {
        // Repository
        let loginRepository = LoginRepositoryImp()
        
        let component = AppRootComponent(dependency: dependency)
        let viewController = AppRootViewController()
        let interactor = AppRootInteractor(
            presenter: viewController,
            loginRepository: loginRepository
        )

        //  Child RIBs
        let loggedInBuilder = LoggedInBuilder(dependency: component)
        let loggedOutBuilder = LoggedOutBuilder(dependency: component)

        return AppRootRouter(
            interactor: interactor,
            viewController: viewController, 
            // Child RIBs
            loggedInBuilder: loggedInBuilder,
            loggedOutBuilder: loggedOutBuilder
        )
    }
}
