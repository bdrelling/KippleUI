// Copyright © 2022 Brian Drelling. All rights reserved.

#if canImport(UIKit)

    import SwiftUI

    // source: https://stackoverflow.com/questions/56505528/swiftui-update-navigation-bar-title-color

    public typealias NavigationConfiguratorCompletion = (UINavigationController) -> Void

    public struct NavigationConfigurator: UIViewControllerRepresentable {
        public var configure: NavigationConfiguratorCompletion = { _ in }

        public func makeUIViewController(context _: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
            UIViewController()
        }

        public func updateUIViewController(_ uiViewController: UIViewController,
                                           context _: UIViewControllerRepresentableContext<NavigationConfigurator>) {
            if let navigationController = uiViewController.navigationController {
                self.configure(navigationController)
            }
        }
    }

    public extension NavigationConfigurator {
        static func transparent(configure: @escaping NavigationConfiguratorCompletion = { _ in }) -> NavigationConfigurator {
            NavigationConfigurator { nc in
                // Set the background to transparent
                nc.navigationBar.barTintColor = .clear
                nc.navigationBar.setBackgroundImage(UIImage(), for: .default)

                // Remove the drop shadow
                nc.navigationBar.shadowImage = UIImage()

                // Hide all titles by setting the color to Clear
                nc.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.clear]

                configure(nc)
            }
        }
    }

    public extension View {
        func configureNavigation(_ configurator: NavigationConfigurator) -> some View {
            self.background(configurator)
        }

        func configureNavigation(_ completion: @escaping NavigationConfiguratorCompletion) -> some View {
            self.background(NavigationConfigurator(configure: completion))
        }
    }

#endif
