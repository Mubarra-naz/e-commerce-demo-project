class Api::V1::ApiController < ApplicationController
  before_action :authenticate_with_http_basic
  skip_before_action :verify_authenticity_token
end
