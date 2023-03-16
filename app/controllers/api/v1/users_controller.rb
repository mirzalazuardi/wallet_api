class Api::V1::UsersController < ApplicationController
  before_action :authenticate
  include Transactable

end
