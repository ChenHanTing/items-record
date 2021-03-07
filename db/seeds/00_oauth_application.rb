progressbar = ProgressBar.create(title: 'Creating OAuth Applications', total: APPLICATIONS_TO_CREATE)

['IOS Client', 'Android Client', 'React', 'POS', 'Live Chat'].each do |application|
  Doorkeeper::Application.create name: application, redirect_uri: '', scopes: (application.eql?('React') ? 'frontend' : '')

  progressbar.increment
end