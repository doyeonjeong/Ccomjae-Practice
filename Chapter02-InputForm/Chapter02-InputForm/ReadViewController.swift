//
//  ReadViewController.swift
//  Chapter02-InputForm
//
//  Created by Doyeon on 2023/01/30.
//

import UIKit

class ReadViewController: UIViewController {
    
    // 전달된 값을 저장할 변수 정의
    var pEmail: String?
    var pUpate: Bool?
    var pInterval: Double?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 배경 색상 설정
        self.view.backgroundColor = .white
        
        // 레이블 객체 정의
        let email = UILabel()
        let update = UILabel()
        let interval = UILabel()
        
        // 위치와 영역 정의
        email.frame = CGRect(x: 50, y: 100, width: 300, height: 30)
        update.frame = CGRect(x: 50, y: 150, width: 300, height: 30)
        interval.frame = CGRect(x: 50, y: 200, width: 300, height: 30)
        
        // 전달받은 값을 레이블에 표시
        email.text = "전달받은 이메일 : \(self.pEmail!)"
        update.text = "업데이트 여부 : \(self.pUpate!)"
        interval.text = "업데이트 주기 : \(self.pInterval!)"
        
        // 레이블을 루트 뷰에 추가
        self.view.addSubview(email)
        self.view.addSubview(update)
        self.view.addSubview(interval)
        
    }

}
