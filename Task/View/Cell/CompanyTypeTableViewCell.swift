//
//  CompanyTypeTableViewCell.swift
//  Task
//
//  Created by trost.jk on 2022/09/18.
//

import UIKit

class CompanyTypeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var industryLabel: UILabel!
    
    @IBOutlet weak var updateDateLabel: UILabel!
    @IBOutlet weak var reviewSummaryLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    
    @IBOutlet weak var interviewQuestionLabel: UILabel!
    
    static let defaultReuseIdentifier = "CompanyTypeTableViewCell"
    
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
              let salaryAvg = cellItem.salaryAvg,
              let interviewQuestion = cellItem.interviewQuestion
        {
            //image
            self.logoImageView.layer.cornerRadius = 4
            self.logoImageView.layer.borderColor = UIColor.Gray03.cgColor
            self.logoImageView.layer.borderWidth = 1

            self.logoImageView.tintColor = .lightGray.withAlphaComponent(0.5)
            self.logoImageView.setImage(
                with: logoImagePath,
                placeholder: UIImage(systemName: "circle.dashed")) { [weak self] result in
                    guard let image = try? result.get().image else { return }
                    self?.logoImageView.image = image
            }

            self.companyNameLabel.text = companyName

            self.industryLabel.text = industryName

            let updatedDate = updateDate.components(separatedBy: "T")
            var convertedUpdateDate = updatedDate[0]
            convertedUpdateDate = convertedUpdateDate.replacingOccurrences(of: "-", with: ".")
            self.updateDateLabel.text = convertedUpdateDate

            self.reviewSummaryLabel.text = reviewSummary

            self.salaryLabel.text = "\(salaryAvg)"
            
            self.interviewQuestionLabel.text = interviewQuestion
        }
    }

    
}
