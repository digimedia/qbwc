$:.unshift File.dirname(File.expand_path(__FILE__))
require "qbwc/version"
require "quickbooks_api"

module QBWC

  # Web connector login credentials
  mattr_accessor :username
  @@username = 'foo'
  mattr_accessor :password
  @@password = 'bar'
  
  mattr_accessor :quickbooks_name
  @@quickbooks_name = "Quickbooks Web Connector"
  mattr_accessor :quickbooks_description
  @@quickbooks_description = "Quickbooks Web Connector"
  mattr_accessor :quickbooks_app_id
  @@quickbooks_app_id = "Quickbooks Web Connector"
  
  
  mattr_accessor :run_every_minutes
  @@run_every_minutes = 5
  
  #Path to Company File 
  mattr_accessor :quickbooks_company_file_path 
  @@quickbooks_company_file_path = "" #blank for open or named path or function etc..
  # Full path to pompany file 
  mattr_accessor :company_file_path 
  @@company_file_path = ""
  
  # Minimum quickbooks version required for use in qbxml requests
  mattr_accessor :min_version
  @@min_version = 3.0
  
  #Quickbooks Support URL provided in QWC File
  mattr_accessor :quickbooks_support_site_url
  @@quickbooks_support_site_url = "http://localhost"
  
  #Quickbooks Owner ID provided in QWC File
  mattr_accessor :quickbooks_owner_id
  @@quickbooks_owner_id = '{57F3B9B1-86F1-4fcc-B1EE-566DE1813D20}'
  mattr_accessor :quickbooks_file_id
  @@quickbooks_file_id = '{90A44FB5-33D9-4815-AC85-BC87A7E7D1EB}'
  
  # Quickbooks support url provided in qwc file
  mattr_accessor :support_site_url
  @@support_site_url = 'http://qb_support.lumber.com'
  
  # Quickbooks owner id provided in qwc file
  mattr_accessor :owner_id
  @@owner_id = '{57F3B9B1-86F1-4fcc-B1EE-566DE1813D20}'
  
  # Job definitions
  mattr_reader :jobs
  @@jobs = {}
  
  # Do processing after session termination
  # Enabling this option will speed up qbwc session time but will necessarily eat
  # up more memory since every response must be stored until it is processed. 
  mattr_accessor :delayed_processing
  @@delayed_processing = false

  # Quickbooks Type (either :qb or :qbpos)
  mattr_reader :api, :parser
  @@api= ::QuickbooksApi::API[:qb]
  
class << self

  def add_job(name, &block)
    @@jobs[name] = Job.new(name, &block)
  end

  def api=(api)
    raise 'Quickbooks type must be :qb or :qbpos' unless [:qb, :qbpos].include?(api)
    @@api = api
    @@parser = ::Quickbooks::API[api]
  end

  # Allow configuration overrides
  def configure
    yield self
  end

end
  
end

require 'fiber'

#Todo Move this to Autolaod
require 'qbwc/soap_wrapper/default'
require 'qbwc/soap_wrapper/defaultMappingRegistry'
require 'qbwc/soap_wrapper/defaultServant'
require 'qbwc/soap_wrapper/QBWebConnectorSvc'
require 'qbwc/soap_wrapper'
require 'qbwc/session'
require 'qbwc/request'
require 'qbwc/job'
