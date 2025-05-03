import UIKit

class LegalAidViewController: UIViewController {
    // MARK: - UI Components
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let questionTextField = UITextField()
    private let sendButton = UIButton(type: .system)
    private let responseTextView = UITextView()
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    private let resetButton = UIButton(type: .system)
    
    // MARK: - Properties
    private lazy var legalAidService = LegalAidService(apiKey: Config.anthropicApiKey)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupKeyboardDismissGesture()
        registerForKeyboardNotifications()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        title = "Legal Ai(d)"
        view.backgroundColor = .systemBackground
        
        // Setup scroll view
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        // Question input field
        questionTextField.placeholder = "Ask a legal question about NY law..."
        questionTextField.borderStyle = .roundedRect
        questionTextField.returnKeyType = .send
        questionTextField.delegate = self
        questionTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(questionTextField)
        
        // Send button
        sendButton.setTitle("Send", for: .normal)
        sendButton.backgroundColor = .systemBlue
        sendButton.setTitleColor(.white, for: .normal)
        sendButton.layer.cornerRadius = 5
        sendButton.addTarget(self, action: #selector(sendQuestion), for: .touchUpInside)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(sendButton)
        
        // Reset button
        resetButton.setTitle("Reset", for: .normal)
        resetButton.backgroundColor = .systemRed
        resetButton.setTitleColor(.white, for: .normal)
        resetButton.layer.cornerRadius = 5
        resetButton.addTarget(self, action: #selector(resetConversation), for: .touchUpInside)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(resetButton)
        
        // Response text view
        responseTextView.isEditable = false
        responseTextView.font = UIFont.systemFont(ofSize: 16)
        responseTextView.layer.borderWidth = 1
        responseTextView.layer.borderColor = UIColor.systemGray4.cgColor
        responseTextView.layer.cornerRadius = 5
        responseTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        responseTextView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(responseTextView)
        
        // Loading indicator
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.color = .systemBlue
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(loadingIndicator)
        
        // Layout constraints
        NSLayoutConstraint.activate([
            // Scroll view constraints
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            // Content view constraints
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Question text field
            questionTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            questionTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            questionTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -10),
            
            // Send button
            sendButton.topAnchor.constraint(equalTo: questionTextField.topAnchor),
            sendButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            sendButton.widthAnchor.constraint(equalToConstant: 80),
            sendButton.heightAnchor.constraint(equalTo: questionTextField.heightAnchor),
            
            // Reset button
            resetButton.topAnchor.constraint(equalTo: questionTextField.bottomAnchor, constant: 10),
            resetButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            resetButton.widthAnchor.constraint(equalToConstant: 80),
            
            // Response text view
            responseTextView.topAnchor.constraint(equalTo: resetButton.bottomAnchor, constant: 10),
            responseTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            responseTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            responseTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            responseTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 300),
            
            // Loading indicator
            loadingIndicator.centerXAnchor.constraint(equalTo: responseTextView.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: responseTextView.centerYAnchor)
        ])
        
        // Initial message
        responseTextView.text = "Welcome to Legal Ai(d). Ask any question about New York State or NYC laws."
    }
    
    // MARK: - Keyboard Handling
    private func setupKeyboardDismissGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let keyboardHeight = keyboardFrame.height
        
        scrollView.contentInset.bottom = keyboardHeight
        scrollView.scrollIndicatorInsets.bottom = keyboardHeight
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset.bottom = 0
        scrollView.scrollIndicatorInsets.bottom = 0
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Actions
    @objc private func sendQuestion() {
        guard let question = questionTextField.text, !question.isEmpty else {
            responseTextView.text = "Please enter a legal question."
            return
        }
        
        loadingIndicator.startAnimating()
        responseTextView.text = "Processing your question..."
        questionTextField.resignFirstResponder()
        
        Task {
            do {
                let response = try await legalAidService.sendMessage(question)
                await MainActor.run {
                    responseTextView.text = response
                    loadingIndicator.stopAnimating()
                    questionTextField.text = ""
                }
            } catch {
                await MainActor.run {
                    responseTextView.text = "Error: \(error.localizedDescription)"
                    loadingIndicator.stopAnimating()
                }
            }
        }
    }
    
    @objc private func resetConversation() {
        legalAidService.resetConversation()
        responseTextView.text = "Conversation has been reset. You can ask a new question."
        questionTextField.text = ""
    }
}

// MARK: - UITextFieldDelegate
extension LegalAidViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == questionTextField {
            sendQuestion()
            return false
        }
        return true
    }
}
