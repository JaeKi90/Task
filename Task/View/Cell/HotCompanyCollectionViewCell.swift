//
//  HotCompanyCollectionViewCell.swift
//  Task
//
//  Created by trost.jk on 2022/09/20.
//

import UIKit
import RxCocoa
import SnapKit
import Then

class HotCompanyCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let view = UIView().then {
        $0.layer.borderColor = UIColor.Gray03.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .red
    }

    
    internal func createConstraints() {
        self.contentView.addSubview(self.view)
        
        self.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

    }
    
    func render(label: String) {
//        self.label.text = label
    }
    
    static var reuseId: String {
        return NSStringFromClass(self)
    }
}


