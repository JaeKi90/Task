//
//  HotCompanyTypeTableViewCell.swift
//  Task
//
//  Created by trost.jk on 2022/09/18.
//

import UIKit

class HotCompanyTypeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var hotCompanyCollectionView: UICollectionView!

    static let defaultReuseIdentifier = "HotCompanyTypeTableViewCell"
    
    var recommendRecruits = [RecruitItem]()
    
    private func cofigureCollectionView() {
//        let nib = UINib.init(nibName: RecuruitCollectionViewCell.defaultReuseIdentifier2, bundle: nil)
//        self.hotCompanyCollectionView.register(nib, forCellWithReuseIdentifier: RecuruitCollectionViewCell.defaultReuseIdentifier2)
        self.hotCompanyCollectionView.register(
            HotCompanyCollectionViewCell.self,
            forCellWithReuseIdentifier: HotCompanyCollectionViewCell.reuseId
        )
        
        self.hotCompanyCollectionView.delegate = self
        self.hotCompanyCollectionView.dataSource = self
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.cofigureCollectionView()
    }
    
    func render(recommendRecruits: [RecruitItem]) {
        self.recommendRecruits = recommendRecruits
        
        self.hotCompanyCollectionView.reloadData()
    }
    
}

extension HotCompanyTypeTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendRecruits.count
    }
    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = self.hotCompanyCollectionView.dequeueReusableCell(
//            withReuseIdentifier: HothotCompanyCollectionViewCell.reuseId,
//            for: indexPath
//        ) as! HothotCompanyCollectionViewCell
//
//        cell.createConstraints()
//
////        let cell = hotCompanyCollectionView.dequeueReusableCell(
////            withReuseIdentifier: RecuruitCollectionViewCell.defaultReuseIdentifier2,
////            for: indexPath
////        ) as! RecuruitCollectionViewCell
////
////        cell.render(recruitItem: recommendRecruits[indexPath.row], bookMarkRelay: nil)
//
//        return cell
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.hotCompanyCollectionView.dequeueReusableCell(withReuseIdentifier: HotCompanyCollectionViewCell.reuseId, for: indexPath) as! HotCompanyCollectionViewCell
        
        cell.createConstraints()

        return cell
    }
}

extension HotCompanyTypeTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 160, height: 228)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 16, left: 20, bottom: 22, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}


