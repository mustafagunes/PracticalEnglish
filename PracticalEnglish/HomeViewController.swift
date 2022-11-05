//
//  HomeViewController.swift
//  PracticalEnglish
//
//  Created by Mustafa Gunes on 5.11.2022.
//

import UIKit
import SafariServices

final class HomeViewController: UIViewController {
  
  // MARK: - Outlets
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: - Definitions
  var entitys: [WebSiteEntity] {
    return readAndParseJsonFile() ?? []
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setLayout()
  }
  
  private func setLayout() {
    tableView.dataSource = self
    tableView.register(UINib(nibName: "ButtonCell", bundle: nil), forCellReuseIdentifier: "ButtonCell")
  }
  
  func readAndParseJsonFile() -> [WebSiteEntity]? {
    guard let url = Bundle.main.url(forResource: "response", withExtension: "json") else { return nil }
    do {
      let data = try Data(contentsOf: url)
      let decoder = JSONDecoder()
      let container = try decoder.decode(WebSiteContainer.self, from: data)
      return container.data
    } catch {
      print("error:\(error)")
    }
    return nil
  }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return entitys.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell", for: indexPath) as? ButtonCell
    else {
      return .init()
    }
    let entity = entitys[indexPath.row]
    cell.set(with: entity, self)
    return cell
  }
}

// MARK: - ButtonCellDelegate
extension HomeViewController: ButtonCellDelegate {
  func didClickButton(url: URL?) {
    guard let url = url else { return }
    let config = SFSafariViewController.Configuration()
    config.entersReaderIfAvailable = true
    let viewController = SFSafariViewController(url: url, configuration: config)
    viewController.modalPresentationStyle = .fullScreen
    present(viewController, animated: true)
  }
}
