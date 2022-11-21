//
//  Tab3Cell.swift
//  CloneGroo
//
//  Created by SunHo Lee on 2022/11/09.
//

import Foundation
import UIKit
extension UIButton{
    func setimage(systemname: String){
        contentHorizontalAlignment = .fill
        contentVerticalAlignment = .fill
        imageView?.contentMode = .scaleAspectFit
        setImage(UIImage(systemName: systemname), for: .normal)
    }
}

class Tab3Cell : UITableViewCell{
    static let identifier = "tab3Cell"
    lazy var imgview : UIImageView = {
        let imgV = UIImageView()
        imgV.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return imgV
    }()
    
    lazy var contentslabel : UILabel = {
        let contentlabel  = UILabel()
        contentlabel.font = .systemFont(ofSize: 11, weight: .medium)
        contentlabel.numberOfLines = 5
        contentlabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        contentlabel.textColor = .black
        return contentlabel
    }()
    lazy var Writedatelabel : UILabel = {
        let label = UILabel()
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 12.0 , weight:  .bold    )
        return label
    }()
    let deletebtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.setimage(systemname: "heart")
        btn.addTarget(Tab3Cell.self, action: #selector(removediary), for: .touchUpInside)
        return btn
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 15, bottom: 15, right: 15))
    
        contentView.backgroundColor = .white
        
        
    }
    private func layout(){  
        [imgview,Writedatelabel, contentslabel, deletebtn].forEach{
            contentView.addSubview($0)
        }

        imgview.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.top.equalToSuperview().offset(10)
            $0.height.equalTo(imgview.snp.width).multipliedBy(0.5)
        }
        Writedatelabel.snp.makeConstraints{
            $0.top.equalTo(imgview.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(15)
            
            
        }
        contentslabel.snp.makeConstraints{
            $0.top.equalTo(Writedatelabel.snp.bottom).offset(10)
            $0.leading.equalTo(imgview)
            $0.trailing.equalToSuperview().inset(15)
            
        }
        deletebtn.snp.makeConstraints{
            $0.top.equalTo(Writedatelabel)
            $0.trailing.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func removediary(){
        print("button")
    }
    
    
}
