QBWC.configure do |c|
  
  #Currently Only supported for single logins. 
  c.username = "foo"
  c.password = "bar"
  
  config.quickbooks_name = "Quickbooks Web Connector"
  config.quickbooks_description = "Quickbooks Web Connector"
  config.quickbooks_app_id = "Quickbooks Web Connector"
  config.run_every_minutes = 5
  
  #Path to Company File (blank for open or named path or function etc..)
  c.company_file_path = ""
  
  #Minimum Quickbooks Version Required for use in QBXML Requests
  c.min_version = 7.0
  
  #Quickbooks Type (either :qb or :qbpos)
  c.api = :qb
  
  #Quickbooks Support URL provided in QWC File
  c.support_site_url = "localhost:3000"
  
  #Quickbooks Owner ID provided in QWC File
  c.quickbooks_owner_id = '{57F3B9B1-86F1-4fcc-B1EE-566DE1813D20}'
  c.quickbooks_file_id = '{90A44FB5-33D9-4815-AC85-BC87A7E7D1EB}'

  c.owner_id = '{57F3B9B1-86F1-4fcc-B1EE-566DE1813D20}'

  # Perform response processing after session termination. Enabling this option
  # will speed up qbwc session time (and potentially fix timeout issues) but
  # will necessarily eat up more memory since every response must be stored
  # until it is processed. 
  c.delayed_processing = false

end
