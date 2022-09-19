//
//  HotCompanyTypeTableViewCell.swift
//  Task
//
//  Created by trost.jk on 2022/09/18.
//

import UIKit

class HotCompanyTypeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var companyCollectionView: UICollectionView!
    
    static let defaultReuseIdentifier = "HotCompanyTypeTableViewCell"
    
    var recommendRecruits = [RecruitItem]()
    
    private func cofigureCollectionView() {
        self.companyCollectionView.delegate = self
        self.companyCollectionView.dataSource = self
        
        let nib = UINib.init(nibName: RecuruitCollectionViewCell.defaultReuseIdentifier, bundle: nil)
        self.companyCollectionView.register(nib, forCellWithReuseIdentifier: RecuruitCollectionViewCell.defaultReuseIdentifier)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.cofigureCollectionView()
    }
    
    func render(recommendRecruits: [RecruitItem]) {
        self.recommendRecruits = recommendRecruits

        self.companyCollectionView.reloadData()
    }
    
}

extension HotCompanyTypeTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendRecruits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = companyCollectionView.dequeueReusableCell(
            withReuseIdentifier: RecuruitCollectionViewCell.defaultReuseIdentifier,
            for: indexPath
        ) as! RecuruitCollectionViewCell

        cell.render(recruitItem: recommendRecruits[indexPath.row], bookMarkRelay: nil)
        
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


