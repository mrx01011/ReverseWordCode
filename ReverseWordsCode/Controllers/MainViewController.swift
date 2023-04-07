//
//  ViewController.swift
//  ReverseWordsCode
//
//  Created by Vladyslav Nhuien on 09.07.2022.
//

import SnapKit
import UIKit

class MainViewController: UIViewController {
    
    private let reverser = Reverser()
    
    //MARK: State
    private var mode: Mode = .defaultRule {
        didSet {
            applyState(state, mode)
        }
    }
    private var state: State = .initial {
        didSet {
            applyState(state, mode)
        }
    }
    
    // MARK: UIElements
    private let topSafeAreaView: UIView = {
        let view = UIView()
        view.layer.backgroundColor = Constants.Header.color
        return view
    }()
    private let headerView: UIView = {
        let view = UIView()
        view.layer.backgroundColor = Constants.Header.color
        return view
    }()
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.HeaderLabel.text
        label.textColor = Constants.HeaderLabel.textColor
        label.font = Constants.HeaderLabel.font
        return label
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Title.text
        label.font = Constants.Title.font
        label.textColor = Constants.Title.textColor
        label.textAlignment = .center
        return label
    }()
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Subtitle.text
        label.font = Constants.Subtitle.font
        label.textColor = Constants.Subtitle.textColor
        label.textAlignment = .center
        label.numberOfLines = Constants.Subtitle.numberOfLines
        return label
    }()
    private let inputTextField: UITextField = {
        let textField = UITextField()
        textField.font = Constants.ReverseTextField.font
        textField.textColor = Constants.ReverseTextField.textColor
        textField.attributedPlaceholder = Constants.ReverseTextField.placeholder
        textField.returnKeyType = .done
        return textField
    }()
    private let dividerView: UIView = {
        let view = UIView()
        view.layer.backgroundColor = Constants.Divider.inactiveColor
        return view
    }()
    private let segmentedControll: UISegmentedControl = {
        let menuArr = [Constants.Segment.defaultName,Constants.Segment.customName]
        let segments = UISegmentedControl(items: menuArr)
        segments.backgroundColor = Constants.Segment.inselectedBackgroundColor
        segments.selectedSegmentTintColor = Constants.Segment.selectedBackgroundColor
        segments.selectedSegmentIndex = Constants.Segment.defaultIndex
        return segments
    }()
    private let defaultSegmentLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.DefaultSegment.text
        label.textColor = Constants.DefaultSegment.textColor
        label.font = Constants.DefaultSegment.font
        label.textAlignment = .center
        label.numberOfLines = Constants.DefaultSegment.numberOfLines
        return label
    }()
    private let customSegmentTextField: UITextField = {
        let textField = UITextField()
        textField.font = Constants.CustomSegment.font
        textField.textColor = Constants.CustomSegment.textColor
        textField.attributedPlaceholder = Constants.CustomSegment.placeholder
        textField.returnKeyType = .done
        textField.isHidden = true
        textField.clearsOnBeginEditing = true
        return textField
    }()
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.backgroundColor = .white
        return scrollView
    }()
    private let resultTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.font = Constants.Result.font
        textView.textColor = Constants.Result.textColor
        textView.backgroundColor = .white
        return textView
    }()
    private let reverseButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.ReverseButton.titleLabelReverse, for: .normal)
        button.layer.backgroundColor = Constants.ReverseButton.inactiveBackgroundColor
        button.layer.cornerRadius = Constants.ReverseButton.cornerRadius
        button.isEnabled = false
        return button
    }()
    
    // MARK: NSElements
    private var reverseButtonBottomConstraint: NSLayoutConstraint?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        defaultConfiguration()
        observeKeyboardNotificaton()
    }
    
    // MARK: Methods
    private func setupUI() {
        // Top Safe Area
        view.addSubview(topSafeAreaView)
        topSafeAreaView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constants.OffSet.side)
            make.top.equalToSuperview().inset(Constants.OffSet.Header.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        // Header View
        view.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constants.OffSet.Header.side)
            make.top.equalTo(topSafeAreaView.snp.bottom).offset(Constants.OffSet.Header.top)
            make.height.equalTo(Constants.OffSet.Header.height)
        }
        // Header Label
        headerView.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.centerX.equalTo(headerView.snp.centerX)
            make.bottom.equalTo(headerView.snp.bottom).offset(-Constants.OffSet.Header.labelBottom)
        }
        // Title Label
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constants.OffSet.side)
            make.top.equalTo(headerView.snp.bottom).offset(Constants.OffSet.Title.top)
        }
        // Subtitle Label
        view.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constants.OffSet.Subtitle.side)
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.OffSet.Subtitle.top)
        }
        // Reverse Text Field
        view.addSubview(inputTextField)
        inputTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constants.OffSet.side)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(Constants.OffSet.ReverseTextField.top)
        }
        // Divider View
        view.addSubview(dividerView)
        dividerView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constants.OffSet.side)
            make.top.equalTo(inputTextField.snp.bottom).offset(Constants.OffSet.Divider.top)
            make.height.equalTo(Constants.OffSet.Divider.height)
        }
        // Segmented Controll
        view.addSubview(segmentedControll)
        segmentedControll.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constants.OffSet.side)
            make.top.equalTo(dividerView.snp.bottom).offset(Constants.OffSet.Segment.top)
        }
        // Segment Default Label
        view.addSubview(defaultSegmentLabel)
        defaultSegmentLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constants.OffSet.side)
            make.top.equalTo(segmentedControll.snp.bottom).offset(Constants.OffSet.Segment.topLabel)
        }
        // Segment Custom Text Field
        view.addSubview(customSegmentTextField)
        customSegmentTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constants.OffSet.side)
            make.top.equalTo(segmentedControll.snp.bottom).offset(Constants.OffSet.Segment.topTextField)
        }
        // Text View
        scrollView.addSubview(resultTextView)
        resultTextView.snp.makeConstraints { make in
            make.height.equalTo(scrollView.snp.height)
            make.width.equalTo(scrollView.snp.width)
        }
        // Scroll View
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constants.OffSet.side)
            make.top.equalTo(segmentedControll.snp.bottom).offset(Constants.OffSet.Scroll.top)
        }
        // Reverse Button
        view.addSubview(reverseButton)
        reverseButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constants.OffSet.Button.side)
            make.top.equalTo(scrollView.snp.bottom).offset(Constants.OffSet.Button.top)
            make.bottom.equalToSuperview().offset(-Constants.OffSet.Button.bottom)
            make.height.equalTo(Constants.OffSet.Button.height)
        }
    }
    
    private func defaultConfiguration() {
        inputTextField.delegate = self
        customSegmentTextField.delegate = self
        view.backgroundColor = .white
        reverseButton.addTarget(self, action: #selector(onActionButton), for: .touchUpInside)
        segmentedControll.addTarget(self, action: #selector(selectedSegment), for: .valueChanged)
    }
    
    private func observeKeyboardNotificaton() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func applyState(_ state: State,_ mode: Mode) {
        func applyInitialState() {
            resultTextView.text = ""
            inputTextField.text = ""
            reverseButton.setTitle(Constants.ReverseButton.titleLabelReverse, for: .normal)
            reverseButton.layer.backgroundColor = Constants.ReverseButton.inactiveBackgroundColor
            reverseButton.isEnabled = false
            dividerView.layer.backgroundColor = Constants.Divider.inactiveColor
        }
        func applyTypingState(hasEnteredText: Bool) {
            if hasEnteredText {
                reverseButton.isEnabled = true
                reverseButton.layer.backgroundColor = Constants.ReverseButton.activeBackgroundColor
                reverseButton.setTitle(Constants.ReverseButton.titleLabelReverse, for: .normal)
                dividerView.layer.backgroundColor = Constants.Divider.activeColor
                resultTextView.text = ""
            } else {
                applyInitialState()
            }
        }
        func applyResultState(result: String) {
            reverseButton.setTitle(Constants.ReverseButton.titleLabelClear, for: .normal)
            dividerView.layer.backgroundColor = Constants.Divider.inactiveColor
            resultTextView.text = result
        }
        func applyDefaultMode() {
            defaultSegmentLabel.isHidden = false
            customSegmentTextField.isHidden = true
        }
        func applyCustomMode() {
            defaultSegmentLabel.isHidden = true
            customSegmentTextField.isHidden = false
        }
        
        switch mode {
        case .defaultRule:
            applyDefaultMode()
        case .customRule:
            applyCustomMode()
        }
        switch state {
        case .initial:
            applyInitialState()
        case .typing(let text):
            applyTypingState(hasEnteredText: !text.isEmpty)
        case .result(let result):
            applyResultState(result: result)
        }
    }
    
    @objc private func onActionButton(sender: UIButton) {
        func reverseText(text: String) {
            let result = reverser.defaultReverse(textToReverse: text)
            state = .result(result: result)
        }
        func reverseTextWithRule(text: String, ignore: String?) {
            let result = reverser.reverseWithIgnoreRules(textToReverse: text, textToIgnore: ignore ?? "")
            state = .result(result: result)
        }
        func clearText() {
            state = .initial
        }
        
        switch state {
        case .initial:
            break
        case .typing(let text):
            switch mode {
            case .defaultRule:
                reverseText(text: text)
            case .customRule(let ignore):
                reverseTextWithRule(text: text, ignore: ignore)
            }
        case .result:
            clearText()
        }
    }
    
    @objc private func selectedSegment(sender: UISegmentedControl) {
        let segmentIndex = sender.selectedSegmentIndex
        let text = customSegmentTextField.text ?? ""
        if let mode = Mode(index: segmentIndex, text: text) {
            self.mode = mode
        }
        state = .typing(text: inputTextField.text ?? "")
    }
    
    @objc private func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo,
              let kbSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        reverseButton.snp.updateConstraints { make in
            make.bottom.equalToSuperview().offset(-(kbSize.height + Constants.OffSet.Button.keyboardIndent))
        }
    }
    
    @objc private func keyboardWillHide(sender: NSNotification) {
        reverseButton.snp.updateConstraints { make in
            make.bottom.equalToSuperview().offset(-Constants.OffSet.Button.bottom)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}
// MARK: Text Field Delegate
extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            if textField == inputTextField {
                state = .typing(text: updatedText)
            } else if textField == customSegmentTextField {
                mode = .customRule(text: updatedText)
                state = .typing(text: inputTextField.text ?? "")
            }
        }
        return true
    }
}

// MARK: Models
extension MainViewController {
    enum State {
        case initial
        case typing(text: String)
        case result(result: String)
    }
    
    enum Mode {
        case defaultRule
        case customRule(text: String)
        init?(index: Int, text: String?) {
            if index == 0 {
                self = .defaultRule
            } else if index == 1, let value = text {
                self = .customRule(text: value)
            } else {
                return nil
            }
        }
    }
}
// MARK: Constants
extension MainViewController {
    private enum Constants {
        enum Header {
            static let color = UIColor(red: 0.976, green: 0.976, blue: 0.976, alpha: 0.94).cgColor
        }
        enum HeaderLabel {
            static let text = "Reverse Words"
            static let font = UIFont(name: "Roboto-Bold", size: 17) ?? UIFont.systemFont(ofSize: 17)
            static let textColor = UIColor(red: 0.129, green: 0.129, blue: 0.129, alpha: 1)
        }
        enum Title {
            static let text = "Reverse Words"
            static let font = UIFont(name: "Roboto-Bold", size: 34) ?? UIFont.systemFont(ofSize: 34)
            static let textColor = UIColor(red: 0.129, green: 0.129, blue: 0.129, alpha: 1)
        }
        enum Subtitle {
            static let text = "This application will reverse your words. Please type text below"
            static let font = UIFont(name: "Roboto-Regular", size: 17) ?? UIFont.systemFont(ofSize: 17)
            static let textColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.6)
            static let numberOfLines = 0
        }
        enum ReverseTextField {
            static let placeholder = NSAttributedString(
                string: "Text to reverse",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            static let font = UIFont(name: "Roboto-Regular", size: 17) ?? UIFont.systemFont(ofSize: 17)
            static let textColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 1)
        }
        enum Divider {
            static let inactiveColor = UIColor(red: 0.129, green: 0.129, blue: 0.129, alpha: 0.2).cgColor
            static let activeColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1).cgColor
        }
        enum Segment {
            static let defaultName = "Default"
            static let customName = "Custom"
            static let defaultIndex = 0
            static let inselectedBackgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 0.6)
            static let selectedBackgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1)
        }
        enum DefaultSegment {
            static let text = "All characters except alphabetic symbols"
            static let font = UIFont(name: "Roboto-Regular", size: 17) ?? UIFont.systemFont(ofSize: 17)
            static let textColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.6)
            static let numberOfLines = 0
        }
        enum CustomSegment {
            static let placeholder = NSAttributedString(
                string: "Text to ignore",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            static let font = UIFont(name: "Roboto-Regular", size: 17) ?? UIFont.systemFont(ofSize: 17)
            static let textColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 1)
        }
        enum Result {
            static let font = UIFont(name: "Roboto-Regular", size: 24) ?? UIFont.systemFont(ofSize: 24)
            static let textColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1)
        }
        enum ReverseButton {
            static let titleLabelReverse = "Reverse"
            static let titleLabelClear = "Clear"
            static let inactiveBackgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 0.6).cgColor
            static let activeBackgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1).cgColor
            static let cornerRadius: CGFloat = 14
        }
        enum OffSet {
            static let side: CGFloat = 16
            enum Header {
                static let side: CGFloat = 0
                static let top: CGFloat = 0
                static let height: CGFloat = 38
                static let labelBottom: CGFloat = 10
            }
            enum Title {
                static let top: CGFloat = 64
            }
            enum Subtitle {
                static let side: CGFloat = 33
                static let top: CGFloat = 16
            }
            enum ReverseTextField {
                static let top: CGFloat = 69
            }
            enum Divider {
                static let top: CGFloat = 18
                static let height: CGFloat = 1
            }
            enum Segment {
                static let top: CGFloat = 10
                static let topLabel: CGFloat = 10
                static let topTextField: CGFloat = 10
            }
            enum Scroll {
                static let top: CGFloat = 30
            }
            enum Button {
                static let side: CGFloat = 13
                static let top: CGFloat = 45
                static let bottom: CGFloat = {
                    let window = UIApplication.shared.windows.first
                    let bottomPadding = window?.safeAreaInsets.bottom ?? 0
                    return bottomPadding + 22
                }()
                static let height: CGFloat = 60
                static let keyboardIndent: CGFloat = 10
            }
        }
    }
}
