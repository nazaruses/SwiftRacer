//
//  ViewController.swift
//  SwiftRacer
//
//  Created by Nazar Dremach on 16/7/23.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let settingsList = ["Music", "Sound", "Obstacles", "Car Color", "User Name"]
    let isSwitchSetting = [true, true, false, false, false]
    
    lazy var settings: SettingsManager = SettingsManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTable()
    }
    
    private func setupTable() {
        registerCells()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func registerCells() {
        let switchSettingNib = UINib(nibName: "SwitchSettingTableViewCell", bundle: Bundle.main)
        tableView.register(switchSettingNib, forCellReuseIdentifier: "switchSettingCell")
        
        let openSettingNib = UINib(nibName: "OpenSettingTableViewCell", bundle: Bundle.main)
        tableView.register(openSettingNib, forCellReuseIdentifier: "openSettingCell")
    }
    @IBAction func cancelChanges(_ sender: Any) {
       
        tableView.reloadData()
        
        }
    
    @IBAction func saveChanges(_ sender: Any) {
    
        
        tableView.reloadData()
        
    }
}
            
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settingsList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        
        if isSwitchSetting[index] {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "switchSettingCell", for: indexPath) as? SwitchSettingTableViewCell else { return UITableViewCell() }
            
            cell.settingName.text = settingsList[index]
            cell.`switch`.isOn = isOnSetting(withName: settingsList[index])
            cell.delegate = self
            
            return cell
            
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "openSettingCell", for: indexPath) as? OpenSettingTableViewCell else { return UITableViewCell() }
            
            cell.settingName.text = settingsList[index]
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let index = indexPath.row
        
        if isSwitchSetting[index] {
            guard let cell = tableView.cellForRow(at: indexPath) as? SwitchSettingTableViewCell else { return }
            cell.`switch`.isOn.toggle()
            toggleSetting(withName: settingsList[index])
        } else if settingsList[index] == "User Name" {
            var placeholder = "User Name"
            if settings.userName.count > 0 {
                placeholder = settings.userName
            }
            presentAlert(
                title: "Hello",
                message: "Input User Name",
                placeholder: placeholder
            ) { [weak self] input in
                guard input.count > 0 else { return }
                self?.settings.userName = input
                NotificationCenter.default.post(
                    name: NSNotification.Name("updateUserName"),
                    object: nil,
                    userInfo: ["username": input]
                )
            }
        } else {
            self.present(UIViewController(), animated: true)
        }
    }
    
    private func presentAlert(
        title: String,
        message: String,
        placeholder: String = "",
        handler: ((String) -> ())? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addTextField { textfield in
            textfield.placeholder = placeholder
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            guard let text = alert.textFields?.first?.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                  text.count > 0 else { return }
            
            let filteredText = text // "text   text"
                .components(separatedBy: CharacterSet.whitespacesAndNewlines) // ["text", "", "", "text"]
                .filter { string in
                    string.count > 0
                } // ["text", "text"]
                .joined(separator: " ") // "text text"
            
            handler?(filteredText)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
    
    private func isOnSetting(withName name: String) -> Bool {
        switch name {
        case "Music":
            return settings.isMusicOn
        case "Sound":
            return settings.isSoundOn
        default:
            return false
        }
    }
    
    private func toggleSetting(withName name: String) {
        switch name {
        case "Music":
            settings.isMusicOn.toggle()
        case "Sound":
            settings.isSoundOn.toggle()
        default:
            return
        }
    }
    
    private func SetSetting(withName name: String, to value: Bool) {
        switch name {
        case "Music":
            settings.isMusicOn = value
        case "Sound":
            settings.isSoundOn = value
        default:
            return
        }
    }
}

extension SettingsViewController: SwitchSettingDelegate {
    func cell(_ cell: SwitchSettingTableViewCell, changeValueTo isOn: Bool) {
        guard let index = tableView.indexPath(for: cell)?.row else { return }
        SetSetting(withName: settingsList[index], to: isOn)
    }
}
