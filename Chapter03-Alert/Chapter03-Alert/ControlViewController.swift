//
//  ControlViewController.swift
//  Chapter03-Alert
//
//  Created by Doyeon on 2023/02/02.
//

import UIKit

class ControlViewController: UIViewController {

    let slider = UISlider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 슬라이더의 최소값 / 최대값
        self.slider.minimumValue = 0
        self.slider.maximumValue = 100
        
        // 슬라이더의 영역과 크기를 정의하고 루트 뷰에 추가한다.
        self.slider.frame = CGRect(x: 0, y: 0, width: 170, height: 30)
        self.view.addSubview(self.slider)
        
        self.preferredContentSize = CGSize(width: self.slider.frame.width, height: self.slider.frame.height + 10)
        
        // 슬라이더 알림창 생성
        let sliderBtn = UIButton(type: .system)
        sliderBtn.frame = CGRect(x: 0, y: 250, width: 100, height: 30)
        sliderBtn.center.x = self.view.frame.width / 2
        sliderBtn.setTitle("Slider Alert", for: .normal)
        sliderBtn.addTarget(self, action: #selector(sliderAlert(_:)), for: .touchUpInside)
    }
    
    @objc func sliderAlert(_ sender: Any) {
        // 콘텐츠 뷰 영역에 들어갈 뷰 컨트롤러 생성
        let contentVC = ControlViewController()
        
        // 경고창 객체 생성
        let alert = UIAlertController(title: nil,
                                      message: "이번 글의 평점을 입력해주세요.",
                                      preferredStyle: .alert)
        
        // 컨트롤 뷰 컨트롤러를 알림창에 등록한다.
        alert.setValue(contentVC, forKey: "contentViewController")
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        
        self.present(alert, animated: false)
    }

}
