class Api::V1::TeamsController < ApplicationController
  before_action :authenticate
  include Transactable
end
