# bi-ios-2020

1. Úvod, Xcode - 23. 9. | ackee
2. Swift - 30. 9. | STRV
3. UIView, UIControl - 7. 10. | ackee
4. Autolayout - 14. 10. | STRV | **(zadání 1. úkolu)**
5. UIViewController, navigace - 21. 10. | ackee
6. UIScrollView, UICollectionView - 4. 11. | ackee
7. Networking - 11. 11. | ackee
8. Architektura (MVC, MVVM) - 18. 11. | ackee
9. MapKit, CoreLocation - 25. 11. | ackee | **(zadání 2. úkolu)**
10. Firebase - 2. 12. | ackee
11. SwiftUI - 9. 12. | STRV
12. SwiftUI - 16. 12. | STRV

## 1. Úvod, Xcode

branch: `master`

- úvod do mobilního vývoje
- úvod do platformy iOS
- ukázka prostředí Xcode

## 2. Swift
branch: 02-swift

- Základní datové typy
- Optionals
- Kolekce
- Struktury, třídy, výčtový typ
- Reference
- Funkce, closures
- Extension, protokoly, delegáty
- Modifikátory přístupu
- Známé operátory a metody

## 3. Views

branch: `03-views`

- co je `UIView`
- co je `UIControl` + `UIButton`
- cviko +- reflektuje jak se dělalo UI v dobách, kdy iPhone měl pouze jeden rozměr, jak to dělat lépe si ukážeme na dalším cviku
- [rozdíl point vs. pixel](https://www.paintcodeapp.com/news/ultimate-guide-to-iphone-resolutions)
    - reflektuje různou jemnost displejů, počet px * scale displeje 
    - aplikace pracuje s pointy

## 4. Autolayout

branch: `04-autolayout`

- Autolayout v interface builderu
- `intrinsicContentSize`, `contentHugging` a `contentCompressionResistance`
- Autolayout v kódu (NSLayoutConstraint a `translatesAutoresizingMaskIntoConstraints`)
- Úprava constraints v runtime (update constant)
- Jednoduché animování autolayoutu

## 5. ViewControllers

- Nastavení `rootViewController`u v kódu + inicializace `UIViewController`u jak přímo v kódu, tak pomocí Storyboardu
- Lifecycle controllerů
    * `init`
    * `loadView`
    * `viewDidLoad`
    * `viewWillAppear`
    * `viewDidAppear`
    * `viewWillDisappear`
    * `viewDidDisappear`
    * `deinit`
- `UINavigationController` a nastavení přes `navigationItem`
- `UITabBarController` a nastavení přes `tabBarItem`
- Základní přechody mezi obrazovkami `push`, `present`

## 6. ScrollViews

branch: `06-scrollViews`

- scrollovací prvky `UIScrollView`, `UITableView` & `UICollectionView`
- simple layout pomocí `UIScrollView`
- reusable scrolling views pomocí `UITableView`
- multicolumn layout pomocí `UICollectionView`
- plnění dat do `UITableView` pomocí `UITableViewDiffableDataSource` (analogicky pro `UICollectionView`)
- plnění dat do `UICollectionView` pomocí `UICollectionViewDataSource` (analogicky pro `UITableView`)
    - `collectionView.reloadData()` pro vyžádání reloadu z data source 
- konfigurace buněk `UITableView` pomocí subclass `UITableViewCell` (analogicky pro `UICollectionView`)
- konfigurace buněk `UICollectionView` pomocí subclass `UIContentConfiguration` (analogicky pro `UITableView`)

## 7. Networking

branch: `07-networking`

- network requesty
    - `GET`, `POST` požadavky
    - hlavičky requestů (např. `Content-Type`)
    - základní specifikace klient-server komunikace pomocí `JSON`
- vytvoření požadavku přes `URL` a `URLRequest`
- mapování pomocí `Codable`
    - mapovací klíče `CodingKeys`
    - vlastní mapování pomocí `init(from decoder: Decoder) throws`
- persistence dat přes `UserDefaults`

## 8. Architecture

branch: `08-architecture`

- rozdíl mezi MVC, MVVM
- extrakce logiky a dat do ViewModelů
- integrace ViewModelu do ViewControllerů ve storyboardu / kódu
- přidání `NetworkService` závislosti
- pokročilé: skrytí implementace za protokoly pro lepší testování a snížení vazeb mezi prvky

## 9. MapKit, CoreLocation

branch: `09-mapkit`

- CoreLocation introduction
    - získání polohy uživatele
    - jak pracovat s autorizací
    - konverze koordinátů na název místa pomocí `CLGeocoder`
- základní práce s MapKitem
    - zobrazovaní pinů
    - custom `MKAnnotation` a `MKAnnotationView`
    - custom callout
    - zobrazení polohy uživatele na mapě
    - základní práce s GPX files