////
////  RootComponent.swift
////  RIBs-Tutorial1
////
////  Created by 홍승완 on 2024/02/23.
////
//
//import RIBs
//
//
//final class RootComponent: Component<RootDependency>, LoggedInDependency, LoggedOutDependency {
//    lazy var loggedInBuildable: LoggedInBuildable = {
//        return LoggedInBuilder(dependency: self)
//    }()
//    
//    lazy var loggedOutBuildable: LoggedOutBuildable = {
//        return LoggedOutBuilder(dependency: self)
//    }()
//    
//    private let rootViewController: ViewControllable
//    
//    init(
//        dependency: RootDependency,
//        rootViewController: ViewControllable
//    ) {
//        self.rootViewController = rootViewController
//        
//        super.init(dependency: dependency)
//    }
//}
