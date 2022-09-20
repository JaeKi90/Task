//
//  CompanyTypeTableViewCell.swift
//  Task
//
//  Created by trost.jk on 2022/09/18.
//

import UIKit

class CompanyTypeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var companyAndReviewCommonView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var industryLabel: UILabel!
    @IBOutlet weak var updateDateLabel: UILabel!
    @IBOutlet weak var reviewSummaryLabel: UILabel!
    
    @IBOutlet weak var companyTypeView: UIView!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var interviewQuestionLabel: UILabel!
    
    @IBOutlet weak var reviewTypeView: UIView!
    @IBOutlet weak var prosPointLabel: UILabel!
    @IBOutlet weak var consPointLabel: UILabel!
    
    static let defaultReuseIdentifier = "CompanyTypeTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }
    
    func render(cellItem: CellItem) {
        switch cellItem.cellType {
        case .cellTypeCompany:
            self.setCompanyTypeView(cellItem: cellItem)
        case .cellTypeReview:
            self.setReviewTypeView(cellItem: cellItem)
        case .cellTypeHorizontalTheme:
            print("cellTypeHorizontalTheme")
        }
    }
    
    private func setReviewTypeView(cellItem: CellItem) {
        guard let logoImagePath = cellItem.logoPath,
              let rate = cellItem.rateTotalAvg,
              let companyName = cellItem.name,
              let industryName = cellItem.industryName,
              let updateDate = cellItem.updateDate,
              let reviewSummary = cellItem.reviewSummary else { return }
        
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
        
        //view 숨김처리
        self.companyTypeView.isHidden = true
        
        self.reviewTypeView.isHidden = false
        
        if let prosPoint = cellItem.pros,
           let consPoint = cellItem.cons
        {
            self.prosPointLabel.text = prosPoint
            self.consPointLabel.text = consPoint
        }
    }
    
    private func setCompanyTypeView(cellItem: CellItem) {
        guard let logoImagePath = cellItem.logoPath,
              let rate = cellItem.rateTotalAvg,
              let companyName = cellItem.name,
              let industryName = cellItem.industryName,
              let updateDate = cellItem.updateDate,
              let reviewSummary = cellItem.reviewSummary else { return }
        
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
        
        //view 숨김처리
        self.reviewTypeView.isHidden = true
        
        self.companyTypeView.isHidden = false
        
        if let salaryAvg = cellItem.salaryAvg,
           let interviewQuestion = cellItem.interviewQuestion
        {
            self.salaryLabel.text = "\(salaryAvg)"
            self.interviewQuestionLabel.text = interviewQuestion
        }
        
    }
    
}
