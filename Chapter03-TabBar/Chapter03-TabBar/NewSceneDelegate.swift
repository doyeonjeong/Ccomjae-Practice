//
//  NewSceneDelegate.swift
//  Chapter03-TabBar
//
//  Created by Doyeon on 2023/02/01.
//

import UIKit

class NewSceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    /*
     < SceneDelegate 클래스의 4가지 구성 조건 >
     1. UIResponder 클래스 상속 받을 것
     2. UIWindowSceneDelegate 프로토콜 구현할 것
     3. UIWindow 타입 멤버 변수 window가 정의되어 있어야 함
     4. Info.plist 파일의 [Delegate Class Name] 항목에 등록되어 있어야 한다.
     */
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // 1) 탭 바 컨트롤러를 생성하고, 배경을 흰색으로 설정
        let tbC = UITabBarController()
        tbC.view.backgroundColor = .white
        
        // 2) 완성된 tbC를 루트 뷰 컨트롤러로 등록한다.
        self.window?.rootViewController = tbC
        
        // 3) 탭 바 아이템에 연결될 뷰 컨트롤러 객체를 생성한다.
        let view01 = ViewController()
        let view02 = SecondViewController()
        let view03 = ThirdViewController()
        
        // 4) 생성된 뷰 컨트롤러 객체들을 탭 바 컨트롤러에 등록한다.
        tbC.setViewControllers([view01, view02, view03], animated: false)
        
        // 5) 개별 탭 바 아이템 속성을 설정한다.
        view01.tabBarItem = UITabBarItem(title: "Calendar", image: UIImage(named: "calendar"), selectedImage: nil)
        view02.tabBarItem = UITabBarItem(title: "File", image: UIImage(named: "file-tree"), selectedImage: nil)
        view03.tabBarItem = UITabBarItem(title: "Photo", image: UIImage(named: "photo"), selectedImage: nil)
    }
}
