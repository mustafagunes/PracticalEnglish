//
//  ButtonCell.swift
//  PracticalEnglish
//
//  Created by Mustafa Gunes on 5.11.2022.
//

import UIKit

protocol ButtonCellDelegate: AnyObject {
  func didClickButton(url: URL?)
}

final class ButtonCell: UITableViewCell {
  
  // MARK: - Delegate
  weak var delegate: ButtonCellDelegate?
  
  // MARK: - Definitions
  var entity: WebSiteEntity?
  
  // MARK: - Outlets
  @IBOutlet weak var nextPageButton: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setLayout()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  private func setLayout() {
    nextPageButton.layer.cornerRadius = 8
  }
  
  func set(with entity: WebSiteEntity, _ delegate: ButtonCellDelegate) {
    self.delegate = delegate
    self.entity = entity
    nextPageButton.setTitle(entity.name, for: .normal)
  }
  
  @IBAction func nextPageClicked(_ sender: Any) {
    delegate?.didClickButton(url: entity?.url)
  }
}
