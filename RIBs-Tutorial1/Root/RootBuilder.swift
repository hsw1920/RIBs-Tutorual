////
////  RootBuilder.swift
////  RIBs-Tutorial1
////
////  Created by 홍승완 on 2024/02/23.
////
//
//import RIBs
//
//protocol RootDependency: Dependency {
//    var loginRepository: LoginRepository { get }
//    
//}
//
//// MARK: - Builder
//
//protocol RootBuildable: Buildable {
//    func build() -> LaunchRouting
//}
//
//
//// MARK: Builder는?
///// Builder의 책임은 RIB의 각 구성요소 클래스/children을 위한 Builder를 인스턴스화 하는 것
//
//final class RootBuilder: Builder<RootDependency>, RootBuildable {
//
//    override init(dependency: RootDependency) {
//        super.init(dependency: dependency)
//    }
//
//    /// Launch에서는 LaunchRouting을 사용함.
//    /// build 메서드에 리스너가 없고 리턴 타입도 다름
//    func build() -> LaunchRouting {
//        
//        let viewController = RootViewController()
//        
//        let component = RootComponent(
//            dependency: dependency,
//            rootViewController: viewController
//        )
//        
//        let interactor = RootInteractor(
//            presenter: viewController, 
//            loginRepository: dependency.loginRepository
//        )
//        
//        let loggedInBuilder = LoggedInBuilder(dependency: component)
//        let loggedOutBuilder = LoggedOutBuilder(dependency: component)
//        
//        return RootRouter(
//            interactor: interactor,
//            viewController: viewController,
//            loggedInBuilder: loggedInBuilder, 
//            loggedOutBuilder: loggedOutBuilder
//        )
//    }
//}
