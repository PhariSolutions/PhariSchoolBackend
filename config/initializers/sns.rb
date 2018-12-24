class SNS
  attr_accessor :client, :application_arn

  def initialize()
    @application_arn = 'arn:aws:sns:us-east-1:953907593888:app/GCM/prontaentregaapp'
    @client = Aws::SNS::Client.new(region: 'sa-east-1', credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_KEY']))
  end

  def create_endpoint(device_token, user_id)
    raise ArgumentError, "Device already in use" if Device.exists?(token: device_token)
    endpoint = @client.create_platform_endpoint({platform_application_arn: @application_arn, token: device_token, custom_user_data: user_id})
    endpoint.endpoint_arn
  end

  def delete_endpoint(endpoint)
    @client.delete_endpoint({endpoint_arn: endpoint})
  end

  def notify(user)
    devices = user.devices
    devices.each do |device|
      endpoint = Aws::SNS::PlatformEndpoint.new(device.endpoint)
      notification = {
          target_arn: endpoint.arn,
          subject:params['subject'],
          message:{
            "default": "Something went terribly wrong",
            "GCM": {
              data: params['data']
            }.to_json
          }.to_json,
          message_structure: "json"
      }
      begin
        endpoint.publish(notification)
      rescue Aws::SNS::Errors::EndpointDisabled => e
        logger.error "#{e.message}: #{device.endpoint}"
        device.delete
        endpoint.delete
      rescue Aws::SNS::Errors::ServiceError => e
        logger.error "#{e.message}: #{device.endpoint}"
      end
    end
  end

  def api
    yield(@client, @application_arn) if block_given?
  end

end
