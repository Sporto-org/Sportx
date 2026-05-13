//
//  OnboardingViewController.swift
//  SportX
//
//  Created by Zeiad Mohammed on 11/05/2026.
//

import UIKit

class OnboardingViewController: UIViewController {

    // MARK: - Outlets (connect in XIB)
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!

    // MARK: - Properties
    var onFinish: (() -> Void)?

    private let pages: [(title: String, subtitle: String, systemImage: String)] = [
        (
            title: "Welcome to SportX",
            subtitle: "Your ultimate companion for all sports. Stay updated with live scores, fixtures, and your favourite leagues.",
            systemImage: "figure.run"
        ),
        (
            title: "Explore Every Sport",
            subtitle: "From football to tennis, cricket to basketball — browse leagues and teams across the globe.",
            systemImage: "globe"
        ),
        (
            title: "Save Your Favourites",
            subtitle: "Add leagues to your favourites for quick access. We'll keep them safe even when you're offline.",
            systemImage: "heart.fill"
        )
    ]

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.backgroundColor

        setupCollectionView()
        setupControls()
    }

    // MARK: - Setup

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0

        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: "OnboardingCell")
    }

    private func setupControls() {
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = Theme.accentColor
        pageControl.pageIndicatorTintColor = Theme.secondaryText.withAlphaComponent(0.3)

        nextButton.setTitle("Next", for: .normal)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.backgroundColor = Theme.accentColor
        nextButton.layer.cornerRadius = 25

        skipButton.setTitle("Skip", for: .normal)
        skipButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        skipButton.setTitleColor(Theme.secondaryText, for: .normal)
    }

    // MARK: - Actions

    @IBAction func nextTapped(_ sender: UIButton) {
        let currentPage = pageControl.currentPage
        if currentPage < pages.count - 1 {
            let nextIndex = IndexPath(item: currentPage + 1, section: 0)
            collectionView.scrollToItem(at: nextIndex, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = currentPage + 1
            updateButtonTitle()
        } else {
            onFinish?()
        }
    }

    @IBAction func skipTapped(_ sender: UIButton) {
        onFinish?()
    }

    private func updateButtonTitle() {
        let isLastPage = pageControl.currentPage == pages.count - 1
        nextButton.setTitle(isLastPage ? "Get Started" : "Next", for: .normal)
        skipButton.isHidden = isLastPage
    }
}

// MARK: - UICollectionView DataSource & Delegate

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell", for: indexPath) as! OnboardingCell
        let page = pages[indexPath.item]
        cell.configure(title: page.title, subtitle: page.subtitle, systemImage: page.systemImage)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = page
        updateButtonTitle()
    }
}

// MARK: - Onboarding Cell (programmatic — no XIB needed for inner cell)

class OnboardingCell: UICollectionViewCell {

    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.tintColor = Theme.accentColor
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = Theme.primaryText
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = Theme.secondaryText
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -80),
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 120),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32)
        ])
    }

    func configure(title: String, subtitle: String, systemImage: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        imageView.image = UIImage(systemName: systemImage)?.withRenderingMode(.alwaysTemplate)

        let config = UIImage.SymbolConfiguration(pointSize: 80, weight: .light)
        imageView.preferredSymbolConfiguration = config
    }
}
