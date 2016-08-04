Pod::Spec.new do |s|
  s.name             = "ValidatedExtension"
  s.version          = "3.0.0"
  s.summary          = "A Swift μ-Library for Somewhat Dependent Types"
  s.description      = <<-DESC
                        Validated is a μ-library (~50 Source Lines of Code) that allows you make better use of Swift's type system
                        by providing tools for easily generating new types with built-in guarantees.
                        DESC
  s.homepage         = "https://vknabel.github.io/ValidatedExtension"
  s.license          = { :type => "MIT", :file => "LICENSE.md" }
  s.author           = { "Valentin Knabel" => "develop@vknabel.com" }
  s.social_media_url = "https://twitter.com/vknabel"
  s.source           = { :git => "https://github.com/vknabel/ValidatedExtension.git", :tag => s.version.to_s }
  s.ios.deployment_target     = '8.0'
  s.osx.deployment_target     = '10.10'
  s.tvos.deployment_target    = '9.0'
  s.watchos.deployment_target = '2.0'
  s.requires_arc = true
  s.source_files     = 'Sources/**/*.swift'
end
