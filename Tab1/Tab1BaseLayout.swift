//
//  Tab1BaseLayout.swift
//  CloneGroo
//
//  Created by JOSUEYEON on 2022/11/10.
//

import Foundation
import UIKit
import SnapKit

// tab 1 base layout
class Tab1BaseLayout {
    let layout_main = UIView()
    let label_title = UILabel()
    let button_calendar = UIButton()
    let layout_calendar = Tab1CalendarLayout()
    
    func initViews(_ superView: UIView) {
        superView.addSubview(self.layout_main)
        layout_main.snp.makeConstraints() { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-15)
            make.leading.equalToSuperview().offset(15)
        }
        
        layout_main.addSubview(self.layout_calendar.layout_main)
        layout_main.addSubview(self.label_title)
        layout_main.addSubview(self.button_calendar)
        
        label_title.snp.makeConstraints() { make in
            make.top.equalToSuperview().offset(70)
            make.leading.equalToSuperview()
        }
        label_title.text = "가드닝 스케줄"
        label_title.font = UIFont.boldSystemFont(ofSize: 30)
        label_title.textColor = .black
        label_title.textAlignment = .left
        label_title.sizeToFit()
        
        button_calendar.snp.makeConstraints() { make in
            make.top.equalToSuperview().offset(70)
            make.centerY.equalTo(self.label_title)
            make.trailing.equalToSuperview()
        }
        button_calendar.setImage(UIImage(systemName: "calendar.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .light)), for: .normal)
        
        
    }
}

