class QbwcController < ApplicationController
  require "Quickbooks"

  def qwc
    qwc = <<-QWC
    <QBWCXML>
    <AppName>#{QBWC.quickbooks_name} #{Rails.env}</AppName>
    <AppID></AppID>
    <AppURL>#{quickbooks_url(:protocol => 'https://', :action => 'api')}</AppURL>
    <AppDescription>#{QBWC.quickbooks_description}</AppDescription>
    <AppSupport>#{QBWC.quickbooks_support_site_url}</AppSupport>
    <UserName>#{QBWC.qbwc_username}</UserName>
    <OwnerID>#{QBWC.quickbooks_owner_id}</OwnerID>
    <FileID>#{QBWC.quickbooks_file_id}</FileID>
    <QBType>QBFS</QBType>
    <Style>Document</Style>
    <Scheduler>
      <RunEveryNMinutes>#{QBWC.run_every_minutes}</RunEveryNMinutes>
    </Scheduler>
    </QBWCXML>
    QWC
    send_data qwc, :filename => 'name_me.qwc'
  end

  def api
    # respond successfully to a GET which some versions of the Web Connector send to verify the url

    if request.get?
      render :nothing => true
      return
    end

    req = request
    puts "========== #{ params["Envelope"]["Body"].keys.first}  =========="
    res = QBWC::SoapWrapper.route_request(req)
    render :xml => res, :content_type => 'text/xml'
  end

end
