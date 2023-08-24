//
//  MultipleOptionsPickerViewController.swift
//  MAD CW2
//
//  Created by user239258 on 8/24/23.
//

import UIKit

class MultipleOptionsPickerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    weak var delegate: MultipleOptionsViewControllerDelegate?
    var selectedOptions: [String] = []
    var options: [String] = []
    
    @IBOutlet weak var optionsTblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        optionsTblView.delegate = self
        optionsTblView.dataSource = self
    }
    
    @IBAction func doneOnClick(_ sender: Any) {
        delegate?.didSelectOptions(options:selectedOptions)
        self.dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "optionsTblCellView", for: indexPath) as! MultipleOptionsTableViewCell
        let option = options[indexPath.row]
        cell.optionLbl.text = option
        if(selectedOptions.contains(option)){
            cell.optionCheckMarkImg.isHidden = false
        }else{
            cell.optionCheckMarkImg.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedOption = options[indexPath.row]
        if selectedOptions.contains(selectedOption) {
            selectedOptions.removeAll { $0 == selectedOption }
        } else {
            selectedOptions.append(selectedOption)
        }
        tableView.reloadData()
    }
}
