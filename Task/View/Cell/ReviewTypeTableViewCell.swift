//
//  ReviewTypeTableViewCell.swift
//  Task
//
//  Created by trost.jk on 2022/09/18.
//

import UIKit

class ReviewTypeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var logoImageview: UIImageView!
    @IBOutlet weak var companyNameLabel: UILabel!
    
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var industryLabel: UILabel!
    
    @IBOutlet weak var updateDateLabel: UILabel!
    
    @IBOutlet weak var reviewSummaryLabel: UILabel!
    
    @IBOutlet weak var prosPointLabel: UILabel!
    @IBOutlet weak var consPointLabel: UILabel!
    
    static let defaultReuseIdentifier = "ReviewTypeTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func render(cellItem: CellItem) {
        if let logoImagePath = cellItem.logoPath,
              let rate = cellItem.rateTotalAvg,
              let companyName = cellItem.name,
              let industryName = cellItem.industryName,
              let updateDate = cellItem.updateDate,
              let reviewSummary = cellItem.reviewSummary,
              let prosPoint = cellItem.pros,
              let consPoint = cellItem.cons
        {
            //image
            self.logoImageview.layer.cornerRadius = 4
            self.logoImageview.layer.borderColor = UIColor.Gray03.cgColor
            self.logoImageview.layer.borderWidth = 1
            
            self.logoImageview.tintColor = .lightGray.withAlphaComponent(0.5)
            self.logoImageview.setImage(
                with: logoImagePath,
                placeholder: UIImage(systemName: "circle.dashed")) { [weak self] result in
                    guard let image = try? result.get().image else { return }
                    self?.logoImageview.image = image
            }
            
            self.companyNameLabel.text = companyName
            
            self.rateLabel.text = "\(rate)"
            self.industryLabel.text = industryName
            
            let updatedDate = updateDate.components(separatedBy: "T")
            var convertedUpdateDate = updatedDate[0]
            convertedUpdateDate = convertedUpdateDate.replacingOccurrences(of: "-", with: ".")
            self.updateDateLabel.text = convertedUpdateDate
            
            self.reviewSummaryLabel.text = reviewSummary
            
            self.prosPointLabel.text = prosPoint
            
            self.consPointLabel.text = consPoint
        }

    }
}
