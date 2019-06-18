//
//  AdvanceAccordionTableViewCell.swift
//  AccordionTableViewSample
//
//  Created by Yamada Shunya on 2019/06/18.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

class AdvanceAccordionTableViewCell: UITableViewCell {

    @IBOutlet weak var parentLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var childView: UIView!
    @IBOutlet weak var childLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Required
        lineView.isHidden = true
        childView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(pText: String, cText: String, isOpen: Bool) {
        parentLabel.text = pText
        childLabel.text = cText
        
        // Required
        arrowImageView.image = UIImage(named: "ic_arrow_close")
        if isOpen {
            arrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        } else {
            arrowImageView.transform = .identity
        }
        
        lineView.isHidden = !isOpen
        childView.isHidden = !isOpen
        childView.alpha = isOpen ? 1 : 0
    }
    
    func updateCell(isOpen: Bool) {
        if isOpen {
            open()
        } else {
            close()
        }
    }
    
    // 開くアニメーション: 開く -> アルファ値
    private func open() {
        lineView.isHidden = false
        UIView.animate(withDuration: 0.2,
                       animations: {
                        self.childView.isHidden = false
                        self.arrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        })
        UIView.animate(withDuration: 0.2,
                       delay: 0.2,
                       options: .curveEaseOut,
                       animations: {
                        self.childView.alpha = 1
        })
    }
    
    // 閉じるアニメーション: アルファ値 -> 閉じる
    private func close() {
        lineView.isHidden = true
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.arrowImageView.transform = .identity
                        self.childView.alpha = 0
        })
        
        // tableView.beginUpdates() のアニメーションと合わせるため0.3以上
        UIView.animate(withDuration: 0.3,
                       animations: {
                        self.childView.isHidden = true
        })
    }
}
