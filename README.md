# iOS_BFit
BFit App iOS Documentation
------------------------

User Story #1: (List of exercises)

1- HomeViewController contains:
- SwiftUI HeaderView (title, subtitle, settings button).
- TableView with customized TableViewCell (Exercise image, Exercise name).

------------------------

User Story #2: (Exercise Detail)

 1- ExerciseDetailViewController contains:
- UILabel for Exercise name.
- UICollectionView with customized UICollectionViewCell displays images of the exercise if provided.
- UIImageView displays the Exercise image as a placeholder in case no images.
- UILabel for Exercise Description.
- UICollectionView with customized UICollectionViewCell for the Exercise Variations, if provided.

------------------------

User Story #3: (Exercise Variations)

1- ExerciseDetailViewController can also open for the Variation Exercise's Detail.

------------------------

1- Tap the settings button that opens SettingsViewController so that you can change the language for the whole App (Localization).

2- Tap on HomeTableViewCells opens ExerciseDetailViewController to display all the Exercise Info in ScrollableView.

3 - Each cell in HomeTableView has (Exercise name, Exercise image) fetched from HomeViewModel.

------------------------

Tech Story #1: (Architecture)

(MVVM) as an architectural design pattern.
(UIKit & SwiftUI) for presenting Intuitive UI/UX.
(RxSwift) as a reactive approach for binding data and UI visual elements in any propagation of change.

------------------------

Tech Story #2: (Unit Tests)

(UnitTesting) to prove the correctness of the code with mocking API responses.

------------------------

Tech Story #3: (Efficient Loading)

Apply lazy loading approaches by only fetching the required data when needed.
ProgressHUD: for loading Indicator

------------------------

Network Layer: Alamofire with Generics Codable Models for parsing JSON
SDWebImage
Followed (DRY, SOLID) Principles.

------------------------
PS: you need to install pods to build & run the app
