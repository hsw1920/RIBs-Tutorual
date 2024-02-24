//
//  AppComponent.swift
//  RIBs-Tutorial1
//
//  Created by 홍승완 on 2024/02/23.
//

import RIBs
import UIKit

/// Component는 RIB의 종속성을 관리하는데 사용됨.
/// RIB을 구성하는 다른 Unit을 인스턴스화하여 Builder를 지원함.
/// Component는
/// - RIB을 구축하는데 필요한 외부 종속성(Dependency)에 대한 access를 제공
/// - RIB 자체에서 생성된 종속성을 소유
/// - 다른 RIB에서 위에 대한 access 제어
/// 를 함.
/// 부모 RIB의 Component는 일반적으로 자식 RIB의 Builder에 주입되어 자식에서 부모 RIB의 종속성에 대한 access를 부여함


// Tutotial의 AppComponent
class AppComponent: Component<EmptyDependency>, AppRootDependency {
    var loginRepository: LoginRepository
    init() {
        self.loginRepository = LoginRepositoryImp()
        super.init(dependency: EmptyComponent())
    }
}

