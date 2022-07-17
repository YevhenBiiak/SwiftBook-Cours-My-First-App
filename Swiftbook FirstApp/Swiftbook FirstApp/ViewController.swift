//
//  ViewController.swift
//  Swiftbook FirstApp
//
//  Created by Евгений Бияк on 16.07.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var dayTextField: UITextField!
    @IBOutlet weak var monthTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var answerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        addTapGestureToHideKeyboard()
        addKeyboardObservers()
    }
    
    private func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateViews(notification:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
    }
    
    @objc private func updateViews(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else { return }

        let keyboardFrame = view.convert(keyboardRect, from: view.window)
        let keyboardHeight = view.frame.intersection(keyboardFrame).height - view.safeAreaInsets.bottom

        if keyboardHeight > 0 {
            scrollView.contentInset.bottom = keyboardHeight + 20
        } else {
            scrollView.contentInset.bottom = 0
        }
    }
    
    @IBAction func findButtonTapped(_ sender: UIButton) {
        guard let day = Int(dayTextField.text!), day <= 31 else {
            dayTextField.text = nil
            dayTextField.attributedPlaceholder = NSAttributedString(string: "Enter the correct day", attributes: [.foregroundColor: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)])
            return
        }
        guard let month = Int(monthTextField.text!), month <= 12 else {
            monthTextField.text = nil
            monthTextField.attributedPlaceholder = NSAttributedString(string: "Enter the correct month", attributes: [.foregroundColor: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)])
            return
        }
        guard let year = Int(yearTextField.text!) else {
            yearTextField.text = nil
            yearTextField.attributedPlaceholder = NSAttributedString(string: "Enter the correct year", attributes: [.foregroundColor: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)])
            return
        }
        
        let dateComponents = DateComponents(year: year, month: month, day: day)
        let date = Calendar.current.date(from: dateComponents)
        let weekdayComponent = Calendar.current.component(.weekday, from: date!)
        let weekday = Calendar.current.weekdaySymbols[weekdayComponent - 1]
        
        answerLabel.text = weekday
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        hideKeyboard()
    }
}

