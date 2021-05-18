//
//  InfoCell.swift
//  ContactBook
//
//  Created by user on 17.02.2021.
//

import UIKit

class InfoCell: UITableViewCell {


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func fillCell(title: String, values: [String]) -> UITableViewCell {
        
        if values.count == 0 {
            return UITableViewCell()
        }
        if values.count == 1 && values[0] == "" {
            return UITableViewCell()
        }
        
        let height: CGFloat = CGFloat (Int(frame.height) / values.count)
        var y: CGFloat = CGFloat(0)
        
        for value in values {
            let oneValueView = UIView(frame: CGRect(x: 0, y: y, width: frame.width, height: height))
            let titleLabel = UILabel(frame: CGRect(x: 10, y: height / CGFloat(8), width: 100, height: height / CGFloat(4)))
            titleLabel.text = title
            titleLabel.textColor = .black
            titleLabel.font = titleLabel.font.withSize(14)
            
            let valueLabel = UILabel(frame: CGRect(x: 10, y: height / CGFloat(2) - height / CGFloat(16), width: 100, height: height / CGFloat(2)))
            valueLabel.text = value
            valueLabel.textColor = .systemBlue
            valueLabel.font = valueLabel.font.withSize(17)
            
            oneValueView.addSubview(titleLabel)
            oneValueView.addSubview(valueLabel)
            oneValueView.backgroundColor = .white
            oneValueView.layer.borderWidth = 0.5
            oneValueView.layer.borderColor = UIColor.systemGray5.cgColor
            addSubview(oneValueView)
            bringSubviewToFront(oneValueView)
            y += height
        }
        
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        backgroundColor = .bgColor
    
        return self
    }

}
