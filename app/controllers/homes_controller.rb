class HomesController < ApplicationController
  skip_before_action :require_login, only: %i[top introduction]

  def top; end

  def introduction; end
end
