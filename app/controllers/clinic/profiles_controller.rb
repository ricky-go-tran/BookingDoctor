# frozen_string_literal: true

module Clinic
  class ProfilesController < Clinic::BaseController
    skip_before_action :check_valid_clinic, only: %i[invalid]
    def index; end

    def show; end

    def update; end

    def edit; end

    def destroy; end

    def create; end

    def new; end

    def invalid; end
  end
end
