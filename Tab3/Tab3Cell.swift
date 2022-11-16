//
//  Tab3Cell.swift
//  CloneGroo
//
//  Created by SunHo Lee on 2022/11/09.
//

import Foundation
import UIKit
class Tab3Cell : UITableViewCell{
    static let identifier = "tab3Cell"
    var photoview : UIImage?
    var writeDate : Date?
    var contents : String?
    let deletebtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(.remove, for: .normal)
        btn.addTarget(Tab3Cell.self, action: #selector(removediary), for: .touchUpInside)
        return btn
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    private func layout(){
        let imgview : UIImageView = {
            let imgV = UIImageView()
            imgV.image = photoview
            
            return imgV
        }()
        let Writedatelabel : UILabel = {
            let label = UILabel()
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "yyyy-MM-dd"
            
            label.text = dateformatter.string(from: writeDate!)
            return label
        }()
        let contentslabel : UILabel = {
            let contentlabel  = UILabel()
            contentlabel.text = contents
            return contentlabel
        }()
        addSubview(imgview)
        addSubview(Writedatelabel)
        addSubview(contentslabel)
        imgview.snp.makeConstraints{
            $0.leading.top.equalTo(10)
            $0.size.width.height.equalTo(100)
        }
        Writedatelabel.snp.makeConstraints{
            $0.top.equalTo(Writedatelabel.snp.bottom).offset(15)
            $0.leading.equalTo(Writedatelabel)
        }
        contentslabel.snp.makeConstraints{
            $0.top.equalTo(Writedatelabel.snp.bottom).offset(20)
            $0.leading.equalTo(imgview)
        }
        deletebtn.snp.makeConstraints{
            $0.top.equalTo(Writedatelabel)
            $0.trailing.equalTo(imgview.snp.trailing)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func removediary(){
        print("button")
    }
    
    
}
